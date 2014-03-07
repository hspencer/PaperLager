/**
 * PaperLager 
 * Herbert Spencer 2013
 */

Punto[] puntos;                   // los puntos
ArrayList achurados;              // los achurados, compuestos cada uno por 4 puntos
int numX, numY, numPuntos;        // número de puntos
float m = 150;                    // margen
PFont f;
boolean muestraPuntos;

color fondo, lineas;
float anchoTrama, anchoTrazo;
int ancho, alto;

void setup() {
  ancho = 960;
  alto = 600;
  size(ancho, alto);
  numX = 10;
  numY = 5;
  numPuntos = numX * numY;
  puntos = new Punto[numPuntos];
  achurados = new ArrayList();
  f = createFont("Monaco", 10);
  textFont(f, 10);
  textAlign(CENTER);
  muestraPuntos = false;
  creaPuntos();
  creaAchurados();
  fondo = color(#8B3F0D);
  lineas = color(#B2581D);
  anchoTrama = 15;
  anchoTrazo = 1;
  strokeCap(SQUARE);
  strokeJoin(BEVEL);
}

void creaPuntos() {

  // se crean puntos en una retícula ordenada
  float xSpacer = (width - (2*m)) / float(numX - 1);
  float ySpacer = (height -(2*m)) / float(numY - 1);

  int i = 0; // contador para recorrer el arreglo de puntos

  for (int y = 0; y < numY; y++) {
    for (int x = 0; x < numX; x++) {

      // las coordenadas del nuevo punto
      float px = m + xSpacer * x;
      float py = m + ySpacer * y;

      puntos[i] = new Punto(px, py, i);
      i++;
      // println("Punto creado en "+px+", "+py);
    }
  }
  //imprimePuntos();
}


void creaAchurados() {

  for (int i = 0; i < puntos.length - numX - 1; i++) {
    if ((i - (numX - 1)) % numX != 0) {
      Achurado a = new Achurado(puntos[i], puntos[i+1], puntos[i+numX], puntos[i+numX+1]);
      achurados.add(a);
    }
  }
}

void draw() {
  background(fondo);
  dibujaAchurados();
  if (muestraPuntos) { 
    dibujaPuntos();
  }
  if (keyPressed && key =='n') {
    for (int i = 0; i < puntos.length; i++) {
      //float x = puntos[i].x;
      //float y = puntos[i].y;
      puntos[i].x += noise((millis()/2000 + puntos[i].x)/100, (millis()/2000 + puntos[i].y)/100, 0) - 0.5;
      puntos[i].y += noise((millis()/2000 + puntos[i].x)/100, (millis()/2000 + puntos[i].y)/100, 100) - 0.5;
    }
  }
}

void dibujaAchurados() {
  stroke(0, 40);
  for (int i = 0; i < achurados.size(); i++) {
    Achurado a = (Achurado)achurados.get(i);
    a.draw();
  }
}

void dibujaPuntos() {
  for (int i = 0; i < numPuntos; i++) {
    fill(0);
    noStroke();
    ellipse(puntos[i].x, puntos[i].y, 5, 5);
    text(puntos[i].num, puntos[i].x, puntos[i].y+12);
  }
}

void keyPressed() {
  if (key == 'r') {
    achurados.clear();
    creaPuntos();
    creaAchurados();
  }
  if (key == ' ') {
    muestraPuntos = !muestraPuntos;
  }
  if (key == 's' || key == 'S') {
    String filename = "img/hatch-"+year()+"_"+month()+"_"+day()+"___"+hour()+"-"+minute()+"-"+second()+".png";
    saveFrame(filename);
    println("se ha grabado exitosamente el archivo "+filename);
  }
  if (key == 'a' || key == 'A') {
    anchoTrazo += .5;
  }
  if (key == 'z' || key == 'Z') {
    if (anchoTrazo >= 1) anchoTrazo -= .5;
  }
  if (key == 'd' || key == 'D') {
    anchoTrama += .5;
  }
  if (key == 'c' || key == 'C') {
    if (anchoTrama >= 1)anchoTrama -= .5;
  }
}

void imprimePuntos() {
  println("||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||");
  for (int i = 0; i < puntos.length; i++) {
    println(i+"\t\t"+puntos[i].x+"\t\t"+puntos[i].y);
  }
}

void mouseReleased() {
  for (int i = 0; i < achurados.size(); i++) {
    Achurado a = (Achurado)achurados.get(i);
    if (a.over) {
      a.horizontal = !a.horizontal;
    }
  }
}

class Achurado {
  Punto a, b, c, d, centro;
  float radio;
  boolean over;
  boolean horizontal;
  Achurado(Punto a, Punto b, Punto c, Punto d) {
    this.a = a;
    this.b = b;
    this.c = c;
    this.d = d;
    float n = random(1);
    if (n < .5) {
      horizontal = true;
    }
    else {
      horizontal = false;
    }
    // el promedio
    float x = (a.x + b.x + c.x + d.x)/4;
    float y = (a.y + b.y + c.y + d.y)/4;
    centro = new Punto(x, y);
    println(centro.x);
  }

  void draw() {
    calc();
    strokeWeight(anchoTrazo);
    if (over) {
      noStroke();
      //fill(#BB0AED, 100);
      //ellipse(centro.x, centro.y, 2*radio, 2*radio);
      
      color col = lerpColor(lineas, color(255), .2);
      stroke(col);
    }
    else {
      stroke(lineas);
    }
    if (horizontal) {
      hatch(a, b, c, d);
    }
    else {
      hatch(c, a, d, b);
    }
    noFill();
    quad(a.x, a.y, b.x, b.y, d.x, d.y, c.x, c.y);
  }

  void calc() {
    centro.x = (a.x + b.x + c.x + d.x)/4;
    centro.y = (a.y + b.y + c.y + d.y)/4;
    float[] coordenadasX = {a.x, b.x, c.x, d.x};
    float[] coordenadasY = {a.y, b.y, c.y, d.y};
    float minX = min(coordenadasX);
    float maxX = max(coordenadasX);
    float minY = min(coordenadasY);
    float maxY = max(coordenadasY);
    
    radio = min((maxX - minX),(maxY - minY)) / 2;

    if (dist(mouseX, mouseY, centro.x, centro.y) < radio) {
      over = true;
    }
    else {
      over = false;
    }
  }
}

class Punto {
  float x, y;
  int num;
  
  Punto() {
    x = random(m, width-m);
    y = random(m, height-m);
  }
  
  Punto(float _x, float _y) {
    x = _x;
    y = _y;
    num = 999;
  }
  
  Punto(float _x, float _y, int n) {
    x = _x;
    y = _y;
    num = n;
  }
}

void hatch(
float x1, float y1, 
float x2, float y2, 
float x3, float y3, 
float x4, float y4
) {
  int num = 12;
  float incx1 = (x2 - x1) / (float)(num - 1);
  float incy1 = (y2 - y1) / (float)(num - 1);
  float incx2 = (x4 - x3) / (float)(num - 1);
  float incy2 = (y4 - y3) / (float)(num - 1);
  for (int i = 0; i < num; i++) {
    line(x1 + incx1 * i, y1 + incy1 * i, 
    x3 + incx2 * i, y3 + incy2 * i);
  }
}

void hatch(
float x1, float y1, 
float x2, float y2, 
float x3, float y3, 
float x4, float y4, 
int num
) {
  float incx1 = (x2 - x1) / (float)(num - 1);
  float incy1 = (y2 - y1) / (float)(num - 1);
  float incx2 = (x4 - x3) / (float)(num - 1);
  float incy2 = (y4 - y3) / (float)(num - 1);
  for (int i = 0; i < num; i++) {
    line(x1 + incx1 * i, y1 + incy1 * i, 
    x3 + incx2 * i, y3 + incy2 * i);
  }
}

void hatch(Punto a, Punto b, Punto c, Punto d, int num) {
  float incx1 = (b.x - a.x) / (float)(num - 1);
  float incy1 = (b.y - a.y) / (float)(num - 1);
  float incx2 = (d.x - c.x) / (float)(num - 1);
  float incy2 = (d.y - c.y) / (float)(num - 1);
  for (int i = 0; i < num; i++) {
    line(a.x + incx1 * i, b.y + incy1 * i, 
    c.x + incx2 * i, c.y + incy2 * i);
  }
}

void hatch(Punto a, Punto b, Punto c, Punto d) {
  int num = round(((dist(a.x, a.y, b.x, b.y)+dist(c.x, c.y, d.x, d.y))/2) / anchoTrama);
  float incx1 = (b.x - a.x) / (float)(num - 1);
  float incy1 = (b.y - a.y) / (float)(num - 1);
  float incx2 = (d.x - c.x) / (float)(num - 1);
  float incy2 = (d.y - c.y) / (float)(num - 1);
  for (int i = 0; i < num; i++) {
    line(a.x + incx1 * i, a.y + incy1 * i, 
    c.x + incx2 * i, c.y + incy2 * i);
  }
}


