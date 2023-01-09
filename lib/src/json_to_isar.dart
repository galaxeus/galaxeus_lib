// ignore_for_file: unnecessary_brace_in_string_interps, non_constant_identifier_names
//

import 'dart:convert';

import 'package:galaxeus_lib/galaxeus_lib.dart';
import 'package:universal_io/io.dart';

class IsarDataScript {
  String className;
  List<String> datas;
  IsarDataScript({
    required this.className,
    required this.datas,
  });
  String get first {
    return datas.first;
  }

  String get last {
    return datas.last;
  }

  String get first_name {
    return "${className.camelCaseClass().toLowerCase()}.dart";
  }

  String get last_name {
    return "${className.camelCaseClass().toLowerCase()}.g.dart";
  }

  Future<Directory> saveToFile(Directory output) async {
    if (!output.existsSync()) {
      await output.create(recursive: true);
    }
    String output_path = output.path;
    String output_first_name = output_path;
    String output_last_name = output_path;
    if (output_path[output_path.length - 1] == "/") {
      output_first_name = "${output_first_name}${output_first_name}";
      output_first_name = "${output_first_name}${output_first_name}";
    } else if (output_path[output_path.length - 1] == r"\") {
      output_first_name = "${output_first_name}${output_first_name}";
      output_first_name = "${output_first_name}${output_first_name}";
    } else {
      if (Platform.isWindows) {
        output_first_name = "${output_first_name}\\${output_first_name}";
        output_first_name = "${output_first_name}\\${output_first_name}";
      } else {
        output_first_name = "${output_first_name}/${output_first_name}";
        output_first_name = "${output_first_name}/${output_first_name}";
      }
    }
    await File(output_first_name).writeAsString(first);
    await File(output_last_name).writeAsString(last);
    return output;
  }
}

IsarDataScript jsonToIsar(
  Map<String, dynamic> data, {
  String className = "Root",
  bool isMain = true,
  bool isUseClassName = false,
  String? comment,
}) {
  return IsarDataScript(
    className: className,
    datas: [
      jsonToIsarDynamic(
        data,
        className: className,
        isMain: isMain,
        isUseClassName: isUseClassName,
        comment: comment,
      ),
      """
part "${className.camelCaseClass().toLowerCase()}.dart";
"""
    ],
  );
}

String jsonToIsarDynamic(
  Map<String, dynamic> data, {
  String className = "Root",
  bool isMain = true,
  bool isUseClassName = false,
  String? comment,
}) {
  comment ??= "";
  List<String> classMessages = [];
  String classMessage = """
${((isMain) ? """
// ignore_for_file: non_constant_identifier_names
import 'dart:convert';
import 'package:isar/isar.dart';
part "${className.camelCaseClass().toLowerCase()}.g.dart";

@collection""" : "@embedded")} 
class ${className} { 

""";
  String classData = """

  ${comment}
  ${className}(this.rawData) {
  
""";
  String classDataCreate = """

  ${comment}
  factory ${className}.create({

""";
  String classDataCreateJson = """{

  
""";
  String operator_data = "";
  data.forEach((key, value) {
    String nameClass = key.camelCaseClass();
    if (isUseClassName) {
      nameClass = "${className}${key.camelCaseClass()}";
    }

    if (value is String) {
      classMessage += textToFunctionIsar(
        key: key,
        value: value,
        className: className,
        returnType: "String",
        comment: comment,
        callback: (text) {
          classData += text;
        },
        paramFunction: (text) {
          classDataCreate += text;
        },
        paramJson: (text) {
          classDataCreateJson += text;
        },
        operatorData: (text) {
          operator_data += text;
        },
      );
    }
    if (value is int) {
      classMessage += textToFunctionIsar(
        key: key,
        value: value,
        className: className,
        returnType: "int",
        comment: comment,
        callback: (text) {
          classData += text;
        },
        paramFunction: (text) {
          classDataCreate += text;
        },
        paramJson: (text) {
          classDataCreateJson += text;
        },
        operatorData: (text) {
          operator_data += text;
        },
      );
    } else if (value is double) {
      classMessage += textToFunctionIsar(
        key: key,
        value: value,
        className: className,
        returnType: "double",
        comment: comment,
        callback: (text) {
          classData += text;
        },
        paramFunction: (text) {
          classDataCreate += text;
        },
        paramJson: (text) {
          classDataCreateJson += text;
        },
        operatorData: (text) {
          operator_data += text;
        },
      );
    } else if (value is num) {
      classMessage += textToFunctionIsar(
        key: key,
        value: value,
        className: className,
        returnType: "num",
        comment: comment,
        callback: (text) {
          classData += text;
        },
        paramFunction: (text) {
          classDataCreate += text;
        },
        paramJson: (text) {
          classDataCreateJson += text;
        },
        operatorData: (text) {
          operator_data += text;
        },
      );
    }
    if (value is bool) {
      classMessage += textToFunctionIsar(
        key: key,
        value: value,
        className: className,
        returnType: "bool",
        comment: comment,
        callback: (text) {
          classData += text;
        },
        paramFunction: (text) {
          classDataCreate += text;
        },
        paramJson: (text) {
          classDataCreateJson += text;
        },
        operatorData: (text) {
          operator_data += text;
        },
      );
    }
    if (value is Map) {
      classMessage += textToFunctionIsar(
        key: key,
        value: value,
        className: className,
        returnType: "Map",
        isClass: true,
        isUseClassName: isUseClassName,
        comment: comment,
        callback: (text) {
          classData += text;
        },
        paramFunction: (text) {
          classDataCreate += text;
        },
        paramJson: (text) {
          classDataCreateJson += text;
        },
        operatorData: (text) {
          operator_data += text;
        },
      );
      classMessages.add(jsonToIsar(
        value.cast<String, dynamic>(),
        className: nameClass,
        isMain: false,
        isUseClassName: isUseClassName,
        comment: comment,
      ).first);
    }

    if (value is List) {
      if (value.isNotEmpty) {
        if (value.first is Map) {
          classMessage += textToFunctionIsar(
            key: key,
            value: value,
            className: className,
            returnType: "Map",
            isClass: true,
            isUseClassName: isUseClassName,
            isList: true,
            comment: comment,
            callback: (text) {
              classData += text;
            },
            paramFunction: (text) {
              classDataCreate += text;
            },
            paramJson: (text) {
              classDataCreateJson += text;
            },
            operatorData: (text) {
              operator_data += text;
            },
          );
          classMessages.add(
            jsonToIsar(
              (value.first as Map).cast<String, dynamic>(),
              className: nameClass,
              isMain: false,
              isUseClassName: isUseClassName,
              comment: comment,
            ).first,
          );
        }
        if (value.first is bool) {
          classMessage += textToFunctionIsar(
            key: key,
            value: value,
            className: className,
            returnType: "bool",
            isClass: false,
            isList: true,
            comment: comment,
            callback: (text) {
              classData += text;
            },
            paramFunction: (text) {
              classDataCreate += text;
            },
            paramJson: (text) {
              classDataCreateJson += text;
            },
            operatorData: (text) {
              operator_data += text;
            },
          );
        }
        if (value.first is String) {
          classMessage += textToFunctionIsar(
            key: key,
            value: value,
            className: className,
            returnType: "String",
            isClass: false,
            isList: true,
            comment: comment,
            callback: (text) {
              classData += text;
            },
            paramFunction: (text) {
              classDataCreate += text;
            },
            paramJson: (text) {
              classDataCreateJson += text;
            },
            operatorData: (text) {
              operator_data += text;
            },
          );
        }
        if (value.first is int) {
          classMessage += textToFunctionIsar(
            key: key,
            value: value,
            className: className,
            returnType: "int",
            isClass: false,
            isList: true,
            comment: comment,
            callback: (text) {
              classData += text;
            },
            paramFunction: (text) {
              classDataCreate += text;
            },
            paramJson: (text) {
              classDataCreateJson += text;
            },
            operatorData: (text) {
              operator_data += text;
            },
          );
        } else if (value.first is double) {
          classMessage += textToFunctionIsar(
            key: key,
            value: value,
            className: className,
            returnType: "double",
            isClass: false,
            isList: true,
            comment: comment,
            callback: (text) {
              classData += text;
            },
            paramFunction: (text) {
              classDataCreate += text;
            },
            paramJson: (text) {
              classDataCreateJson += text;
            },
            operatorData: (text) {
              operator_data += text;
            },
          );
        } else if (value.first is num) {
          classMessage += textToFunctionIsar(
            key: key,
            value: value,
            className: className,
            returnType: "num",
            isClass: false,
            isList: true,
            comment: comment,
            callback: (text) {
              classData += text;
            },
            paramFunction: (text) {
              classDataCreate += text;
            },
            paramJson: (text) {
              classDataCreateJson += text;
            },
            operatorData: (text) {
              operator_data += text;
            },
          );
        }
        if (value.first == null) {
          classMessage += textToFunctionIsar(
            key: key,
            value: value,
            className: className,
            returnType: "Object",
            isClass: false,
            isList: true,
            comment: comment,
            callback: (text) {
              classData += text;
            },
            paramFunction: (text) {
              classDataCreate += text;
            },
            paramJson: (text) {
              classDataCreateJson += text;
            },
            operatorData: (text) {
              operator_data += text;
            },
          );
        }
      } else {
        classMessage += textToFunctionIsar(
          key: key,
          value: value,
          className: className,
          returnType: "Object",
          isClass: false,
          isList: true,
          comment: comment,
          callback: (text) {
            classData += text;
          },
          paramFunction: (text) {
            classDataCreate += text;
          },
          paramJson: (text) {
            classDataCreateJson += text;
          },
          operatorData: (text) {
            operator_data += text;
          },
        );
      }
    }

    if (value == null) {
      classMessage += textToFunctionIsar(
        key: key,
        value: value,
        className: className,
        returnType: "Object",
        isClass: false,
        isList: false,
        comment: comment,
        callback: (text) {
          classData += text;
        },
        paramFunction: (text) {
          classDataCreate += text;
        },
        paramJson: (text) {
          classDataCreateJson += text;
        },
        operatorData: (text) {
          operator_data += text;
        },
      );
    }
  });
  // classDataCreateJson += "\n\n  }";
  // classDataCreate += "})  {";
  // classDataCreate += "\n\nreturn ${className}(${classDataCreateJson});";

  // classDataCreate += "\n\n      }";
  // classData += "\n\n    }";

  // classMessage += classData;

  // classMessage += classDataCreate;

  classMessage += """
 
  /// operator map data
   operator [](key) {
    return toJson()[key];
  }
 
  /// operator map data
  void operator []=(key, value) {
    ${operator_data}
  }

  /// return original data json
  Map toMap() {
    return toJson();
  }

  /// return original data json
  Map toJson() {
    
    return 
      ${classDataCreateJson}
    };
  }

  /// return string data encode json original data
  @override
  String toString() {
    return json.encode(toJson());
  }

}""";

  classMessage += "\n\n${classMessages.join("\n\n")}";
  return classMessage;
}

String textToFunctionIsar({
  required String key,
  required value,
  required String returnType,
  required String className,
  bool isClass = false,
  bool isList = false,
  bool isUseClassName = false,
  String? comment,
  required void Function(String text) callback,
  required void Function(String text) paramFunction,
  required void Function(String text) paramJson,
  required void Function(String text) operatorData,
}) {
  comment ??= "";
  if (value is String) {
    value = json.encode(value);
  }
  String nameClass = key.camelCaseClass();
  if (isUseClassName) {
    nameClass = "${className}${key.camelCaseClass()}";
  }

  String nameMethod = key.replaceAll(RegExp(r"^(@|[0-9]+)", caseSensitive: false), "special_");

  operatorData.call("""


    if (key == "${key}") {
      ${nameMethod} = value;
    }


""");

  if (isClass) {
    if (isList) {
      paramFunction.call("""
      List<${nameClass}?>? ${nameMethod},
""");
      paramJson.call("""
      "${key}": (${nameMethod} != null)? ${nameMethod}.map((res) => res!.toJson()).toList().cast<Map>(): null,
""");
      callback.call("""
      try {
        if (rawData["$key"] is List == false){
          ${nameMethod}  = null;
        }
        ${nameMethod} = (rawData["$key"] as List).map((e) => ${nameClass}(e as $returnType)).toList().cast<${nameClass}>();
      } catch (e) {
        ${nameMethod}  = null;
      }
""");
      return """
  ${comment}
  List<${nameClass}> ${nameMethod} = [];

""";
    }
    paramFunction.call("""
      ${nameClass}? ${nameMethod},
""");
    paramJson.call("""
      "${key}": (${nameMethod} != null)?${nameMethod}.toJson(): null,
""");
    callback.call("""
      try {
        if (rawData["$key"] is $returnType == false){
          ${nameMethod}  =  ${nameClass}({});
        }
        ${nameMethod} = ${nameClass}(rawData["$key"] as $returnType);
      } catch (e) {
        ${nameMethod}  = ${nameClass}({}); 
      }
""");
    return """

  ${comment}
  ${nameClass} ${nameMethod} = ${nameClass}();

""";
  }
  if (isList) {
    paramFunction.call("""
      List<${returnType}?>? ${nameMethod},
""");
    paramJson.call("""
      "${key}": ${nameMethod},
""");
    callback.call("""
      try {
        if (rawData["$key"] is List == false){
          ${nameMethod}  = null;
        }
        ${nameMethod} = (rawData["$key"] as List).cast<${returnType}>();
      } catch (e) {
        ${nameMethod}  = null;
      }
""");
    return """

  ${comment}
  List<${returnType}> ${nameMethod} = ${value};

""";
  }
  paramFunction.call("""
    $returnType? ${nameMethod},
""");
  paramJson.call("""
      "${key}": ${nameMethod},
""");
  callback.call("""
      try {
        if (rawData["$key"] is $returnType == false){
          ${nameMethod}  = null;
        }
        ${nameMethod} = rawData["$key"] as $returnType;
      } catch (e) {
        ${nameMethod}  = null;
      }
""");
  return """

  ${comment}
  $returnType ${nameMethod} = ${value};

""";
}

// extension JsonToClassStringExtensions on String {
//   String camelCaseClass({RegExp? regExp}) {
//     regExp ??= RegExp(r"(_)", caseSensitive: false);
//     String text = "";
//     for (var i = 0; i < length; i++) {
//       var loopData = this[i];
//       if (i == 0) {
//         text += loopData.toUpperCase();
//       } else {
//         if (regExp.hasMatch(text[text.length - 1])) {
//           text += loopData.toUpperCase();
//         } else {
//           text += loopData;
//         }
//       }
//     }
//     return text.replaceAll(regExp, "");
//   }
// }
