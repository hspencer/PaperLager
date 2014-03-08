void zoomIn() {
  float inc = 10;
  for (int i = 0; i < puntos.length; i++) {
    puntos[i].x = map(puntos[i].x, 0, width, -inc, width + inc);
    puntos[i].y = map(puntos[i].y, 0, height, -inc, height + inc);
  }
}

void zoomOut() {
  float inc = -10;
  for (int i = 0; i < puntos.length; i++) {
    puntos[i].x = map(puntos[i].x, 0, width, -inc, width + inc);
    puntos[i].y = map(puntos[i].y, 0, height, -inc, height + inc);
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

