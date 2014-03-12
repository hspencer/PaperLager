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

