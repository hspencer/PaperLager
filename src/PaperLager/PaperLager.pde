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

