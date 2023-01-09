extension GalaxeusRegExpExtension on RegExp {
  bool hashData(dynamic input) {
    try {
      if (input is String == false) {
        input = input.toString();
      }
      return hasMatch(input);
    } catch (e) {
      return false;
    }
  }
}
