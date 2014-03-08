/**
 * PaperLager 
 * Herbert Spencer 2013
 */

interface JavaScript {
  void showXYCoordinates(int x, int y);
}

void bindJavascript(JavaScript js) {
  javascript = js;
}

JavaScript javascript;

Punto[] puntos;                   // los puntos
ArrayList achurados;              // los achurados, compuestos cada uno por 4 puntos

// número de puntos
int numX = 15;
int numY = 10;

int numPuntos;
float m = 100;                    // margen


color fondo, lineas;
float anchoTrama, anchoTrazo;

void setup() {
  size(960, 600);
  numPuntos = numX * numY;
  puntos = new Punto[numPuntos];
  achurados = new ArrayList();

  creaPuntos();
  creaAchurados();
  fondo = color(#8B3F0D);
  lineas = color(#B2581D);
  anchoTrama = 5;
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
}

void mouseReleased() {
  for (int i = 0; i < achurados.size(); i++) {
    Achurado a = (Achurado)achurados.get(i);
    if (a.over) {
      a.horizontal = !a.horizontal;
    }
  }
}

