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
