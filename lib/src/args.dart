

class Args {
  List<String> arguments = [];
  Args(List<String> args) {
    arguments.addAll(args);
  }

  String? operator [](String name) {
    for (var i = 0; i < arguments.length; i++) {
      String arg = arguments[i];
      if (arg == name) {
        try {
          return arguments[i + 1];
        } catch (e) {
          return null;
        }
      }
    }
    return null;
  }

  void operator []=(String key, String value) {
    int? index = findIndex(key);
    if (index != null) {
      try {
        arguments[index + 1] = value;
      } catch (e) {
        arguments.add(value);
      }
    } else {
      arguments.addAll([
        key,
        value,
      ]);
    }
  }

  int? findIndex(String name) {
    for (var i = 0; i < arguments.length; i++) {
      String arg = arguments[i];
      if (arg == name) {
        try {
          return i;
        } catch (e) {
          return null;
        }
      }
    }
    return null;
  }
}
