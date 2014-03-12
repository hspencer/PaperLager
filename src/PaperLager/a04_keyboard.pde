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

