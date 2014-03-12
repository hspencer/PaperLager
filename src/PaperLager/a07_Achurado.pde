class Achurado {
  Punto a, b, c, d, centro;
  float radio;
  boolean over;
  boolean horizontal;
  Achurado(Punto a, Punto b, Punto c, Punto d) {
    this.a = a;
    this.b = b;
    this.c = c;
    this.d = d;
    float n = random(1);
    if (n < .5) {
      horizontal = true;
    }
    else {
      horizontal = false;
    }
    // el promedio
    float x = (a.x + b.x + c.x + d.x)/4;
    float y = (a.y + b.y + c.y + d.y)/4;
    centro = new Punto(x, y);
    // println(centro.x);
  }

  void draw() {
    calc();
    strokeWeight(anchoTrazo);
    stroke(lineas);
    if (horizontal) {
      hatch(a, b, c, d);
    }
    else {
      hatch(c, a, d, b);
    }
    noFill();
    quad(a.x, a.y, b.x, b.y, d.x, d.y, c.x, c.y);
  }

  void calc() {
    centro.x = (a.x + b.x + c.x + d.x)/4;
    centro.y = (a.y + b.y + c.y + d.y)/4;
    float[] coordenadasX = {
      a.x, b.x, c.x, d.x
    };
    float[] coordenadasY = {
      a.y, b.y, c.y, d.y
    };
    float minX = min(coordenadasX);
    float maxX = max(coordenadasX);
    float minY = min(coordenadasY);
    float maxY = max(coordenadasY);

    radio = min((maxX - minX), (maxY - minY)) / 2;

    if (dist(mouseX, mouseY, centro.x, centro.y) < radio) {
      over = true;
    }
    else {
      over = false;
    }
  }
}

