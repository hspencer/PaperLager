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
