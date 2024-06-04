String formatCurrency(double value) {
  if (value >= 1e12) {
    return 'R\$ ${(value / 1e12).toStringAsFixed(1)} Tri';
  } else if (value >= 1e9) {
    return 'R\$ ${(value / 1e9).toStringAsFixed(1)} Bi';
  } else if (value >= 1e6) {
    return 'R\$ ${(value / 1e6).toStringAsFixed(1)} Mi';
  } else if (value >= 1e3) {
    return 'R\$ ${(value / 1e3).toStringAsFixed(1)} Mil';
  } else {
    return 'R\$ ${value.toStringAsFixed(2)}';
  }
}
