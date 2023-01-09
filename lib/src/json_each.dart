// ignore_for_file: unnecessary_brace_in_string_interps, non_constant_identifier_names
//

Map jsonEach({
  required Map data,
  required dynamic Function(dynamic key, dynamic value, bool isList, bool isMapInList) builder,
}) {
  late Map jsonData = {};

  data.forEach((key, value) {
    if (value is Map) {
      jsonData[key] = jsonEach(data: value, builder: builder);
    } else if (value is List) {
      jsonData[key] = jsonListEach(key: key, data: value, builder: builder);
    } else {
      jsonData[key] = builder(key, value, false, false);
    }
  });
  return jsonData;
}

List jsonListEach({
  required String key,
  required List data,
  required dynamic Function(dynamic key, dynamic value, bool isList, bool isMapInList) builder,
}) {
  return data.map((e) {
    if (e is Map) {
      return jsonEach(data: e, builder: builder);
    } else if (e is List) {
      return jsonListEach(key: key, data: e, builder: builder);
    } else {
      return builder(key, e, true, false);
    }
  }).toList();
}
