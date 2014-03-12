void mouseReleased() {
  for (int i = 0; i < achurados.size(); i++) {
    Achurado a = (Achurado)achurados.get(i);
    if (a.over) {
      a.horizontal = !a.horizontal;
    }
  }
}

void mouseDragged() {
  for (int i = 0; i < puntos.length; i++) {
    if (puntos[i].over()) {
      puntos[i].x = mouseX;
      puntos[i].y = mouseY;
      puntos[i].over() = true;
    }
  }
}

