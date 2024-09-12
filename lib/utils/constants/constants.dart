class Constants{
  static RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'
  );

  static bool isNumeric(String str) {
    final numericRegex = RegExp(r'^[0-9]+$');
    return numericRegex.hasMatch(str);
  }
}