extension IntExtension on int {
  String padZero() {
    return toString().padLeft(2, '0');
  }
}
