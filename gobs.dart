// ignore_for_file: non_constant_identifier_names
import 'dart:convert';

class Root<K, V> {
  late Map<K, V> rawData;

  Root(this.rawData);

  static Map get defaultData {
    return {
      "@type": "azka",
      "baru": "saoks",
      "data": {"@type": "sign", "is_login": true}
    };
  }

  String? get special_type {
    try {
      if (rawData["@type"] is String == false) {
        return null;
      }
      return rawData["@type"] as String;
    } catch (e) {
      return null;
    }
  }

  String? get baru {
    try {
      if (rawData["baru"] is String == false) {
        return null;
      }
      return rawData["baru"] as String;
    } catch (e) {
      return null;
    }
  }

  Data get data {
    try {
      if (rawData["data"] is Map == false) {
        return Data({});
      }
      return Data(rawData["data"] as Map);
    } catch (e) {
      return Data({});
    }
  }

  static Root create({
    String? special_type,
    String? baru,
    Data? data,
  }) {
    late Map jsonData = Root.defaultData;
    late Map jsonCreate = {
      "@type": special_type,
      "baru": baru,
      "data": (data != null) ? data.toJson() : null,
    };

    jsonCreate.forEach((key, value) {
      try {
        if (value != null) {
          jsonData[key] = value;
        }
      } catch (e, stack) {
        print("Root ${e.toString()}, ${stack.toString()}");
      }
    });
    return Root(jsonData);
  }

  /// operator map data
  V? operator [](K key) {
    return rawData[key];
  }

  /// operator map data
  void operator []=(K key, V value) {
    rawData[key] = value;
  }

  /// return original data json
  Map<K, V> toMap() {
    return rawData;
  }

  /// return original data json
  Map<K, V> toJson() {
    return rawData;
  }

  /// return string data encode json original data
  @override
  String toString() {
    return json.encode(rawData);
  }
}

class Data<K, V> {
  late Map<K, V> rawData;

  Data(this.rawData);

  static Map get defaultData {
    return {"@type": "sign", "is_login": true};
  }

  String? get special_type {
    try {
      if (rawData["@type"] is String == false) {
        return null;
      }
      return rawData["@type"] as String;
    } catch (e) {
      return null;
    }
  }

  bool? get is_login {
    try {
      if (rawData["is_login"] is bool == false) {
        return null;
      }
      return rawData["is_login"] as bool;
    } catch (e) {
      return null;
    }
  }

  static Data create({
    String? special_type,
    bool? is_login,
  }) {
    late Map jsonData = Data.defaultData;
    late Map jsonCreate = {
      "@type": special_type,
      "is_login": is_login,
    };

    jsonCreate.forEach((key, value) {
      try {
        if (value != null) {
          jsonData[key] = value;
        }
      } catch (e, stack) {
        print("Data ${e.toString()}, ${stack.toString()}");
      }
    });
    return Data(jsonData);
  }

  /// operator map data
  V? operator [](K key) {
    return rawData[key];
  }

  /// operator map data
  void operator []=(K key, V value) {
    rawData[key] = value;
  }

  /// return original data json
  Map<K, V> toMap() {
    return rawData;
  }

  /// return original data json
  Map<K, V> toJson() {
    return rawData;
  }

  /// return string data encode json original data
  @override
  String toString() {
    return json.encode(rawData);
  }
}
