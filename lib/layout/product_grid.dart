int productGridColumnCount(double width) {
  if (width >= 1450) return 7;
  if (width >= 1200) return 6;
  if (width >= 960) return 5;
  if (width >= 720) return 4;
  if (width >= 520) return 3;
  return 2;
}
