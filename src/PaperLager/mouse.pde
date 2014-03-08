void mouseReleased() {
  for (int i = 0; i < achurados.size(); i++) {
    Achurado a = (Achurado)achurados.get(i);
    if (a.over) {
      a.horizontal = !a.horizontal;
    }
  }
}
