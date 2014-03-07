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

