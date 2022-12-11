// ignore_for_file: non_constant_identifier_names

part of galaxeus_lib;

extension GalaxeusExtensionList on List {
  List cloneAndRandom(List array) {
    late List<String> random_datas = [];
    for (var index = 0; index < array.length; index++) {
      random_datas.add(array[index]);
    }
    for (var index = 0; index < random_datas.length; index++) {
      random_datas.shuffle();
    }
    return random_datas;
  }
}

extension GalaxeusRegExpExtensionList on List<RegExp> { 

  bool hashData(dynamic input) {
    for (var i = 0; i < length; i++) {
      RegExp regExp = this[i];
      if (regExp.hashData(input)) {
        return true;
      }
    }
    return false;
  }
}
