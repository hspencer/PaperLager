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

