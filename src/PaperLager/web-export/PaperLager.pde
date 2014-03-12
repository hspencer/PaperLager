/**
 * PaperLager 
 * Herbert Spencer 2013
 */


void setup() {
  size(960, 600);
  numPuntos = numX * numY;
  puntos = new Punto[numPuntos];
  achurados = new ArrayList();
  creaPuntos();
  creaAchurados();
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
    }
  }
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
}

void dibujaAchurados() {
  stroke(0, 40);
  for (int i = 0; i < achurados.size(); i++) {
    Achurado a = (Achurado)achurados.get(i);
    a.draw();
  }
  for (int i = 0; i < puntos.length; i++) {
    if (puntos[i].over()) {
      puntos[i].draw();
    }
  }
}

var ancho = 960;
var alto = 600;

Punto[] puntos;                   // los puntos
ArrayList achurados;              // los achurados, compuestos cada uno por 4 puntos

// número de puntos
int numX = 15;
int numY = 10;

int numPuntos;  // numX * numY
float m = 100;  // margen

// colores
color fondo  = color(#8B3F0D);
color lineas = color(#B2581D);

// trama
float anchoTrama = 5;
float anchoTrazo = 1;
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

void regen(){
  puntos = new Punto[numPuntos];
  achurados = new ArrayList();
  creaPuntos();
  creaAchurados();
  width = ancho;
  height = alto;
}

void zoomIn() {
  float inc = 10;
  for (int i = 0; i < puntos.length; i++) {
    puntos[i].x = map(puntos[i].x, 0, ancho, -inc, ancho + inc);
    puntos[i].y = map(puntos[i].y, 0, alto, -inc, alto + inc);
  }
}

void zoomOut() {
  float inc = -10;
  for (int i = 0; i < puntos.length; i++) {
    puntos[i].x = map(puntos[i].x, 0, ancho, -inc, ancho + inc);
    puntos[i].y = map(puntos[i].y, 0, alto, -inc, alto + inc);
  }
}

void updateAnchoTrazo(float at) {
  anchoTrazo = at;
}

void updateAnchoTrama(float at) {
  anchoTrama = at;
}

void addNoise() {
  for (int i = 0; i < puntos.length; i++) {
    puntos[i].x += (noise((millis()/2000 + puntos[i].x)/100, (millis()/2000 + puntos[i].y)/100, 0) - 0.5) * 10;
    puntos[i].y += (noise((millis()/2000 + puntos[i].x)/100, (millis()/2000 + puntos[i].y)/100, 100) - 0.5) * 10;
  }
}

void updateLineas(String col){
  lineas = toColor(col);
}

void updateFondo(String col){
  fondo = toColor(col);
}

color toColor(String s){
  s = "FF" + s.substring(1);
  return color(unhex(s));
}

void updateSize(int nuevoAncho, int nuevoAlto){
    for (int i = 0; i < puntos.length; i++) {
      puntos[i].x = map(puntos[i].x, 0, ancho, 0, nuevoAncho);
      puntos[i].y = map(puntos[i].y, 0, alto, 0, nuevoAlto);
    }
    size(nuevoAncho, nuevoAlto);
    ancho = nuevoAncho;
    alto = nuevoAlto;
    // width = ancho;
    // height = alto;
}
void keyPressed() {
  if (key == 'r') {
    achurados.clear();
    creaPuntos();
    creaAchurados();
  }

  if (key == 's' || key == 'S') {
    String filename = "img/hatch-"+year()+"_"+month()+"_"+day()+"___"+hour()+"-"+minute()+"-"+second()+".png";
    saveFrame(filename);
    // println("se ha grabado exitosamente el archivo "+filename);
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
  if (key == 'n' || key == 'N') {
    addNoise();
  }
  if (key == 'f' || key == 'F') {
    zoomOut();
  }
  if (key == 'v' || key == 'V') {
    zoomIn();
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

void mouseDragged() {
  for (int i = 0; i < puntos.length; i++) {
    if (puntos[i].over()) {
      puntos[i].x = mouseX;
      puntos[i].y = mouseY;
      puntos[i].over() = true;
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

  boolean over() {
    if (dist(x, y, mouseX, mouseY) < 8) {
      return true;
    }
    else if(mousePressed == false){
      return false;
    }
  }
  void draw() {
    fill(color(red(lineas)+20, green(lineas)+20, blue(lineas)+20));
    noStroke();
    ellipse(x, y, anchoTrazo*4, anchoTrazo*4);
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
    // println(centro.x);
  }

  void draw() {
    calc();
    strokeWeight(anchoTrazo);
    stroke(lineas);
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
    float[] coordenadasX = {
      a.x, b.x, c.x, d.x
    };
    float[] coordenadasY = {
      a.y, b.y, c.y, d.y
    };
    float minX = min(coordenadasX);
    float maxX = max(coordenadasX);
    float minY = min(coordenadasY);
    float maxY = max(coordenadasY);

    radio = min((maxX - minX), (maxY - minY)) / 2;

    if (dist(mouseX, mouseY, centro.x, centro.y) < radio) {
      over = true;
    }
    else {
      over = false;
    }
  }
}


