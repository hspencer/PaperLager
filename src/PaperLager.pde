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

