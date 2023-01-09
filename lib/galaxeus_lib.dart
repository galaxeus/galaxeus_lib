library galaxeus_lib;

import 'dart:math';
export 'package:http/http.dart';

export 'src/json_each.dart';
export 'src/json_to_dart.dart';
export "src/json_to_message.dart";
export 'src/json_to_update.dart';
export 'src/production.dart';

export 'extension/list.dart';
export 'extension/map.dart';
export 'extension/regexp.dart';
export 'extension/string.dart';

export 'extension/tcp.dart';
export "src/args.dart";
export 'src/captcha.dart';
export 'src/device_id.dart';
export 'src/event_emitter.dart';
export 'src/fetch.dart';
export 'src/tcp_client.dart';
export 'src/tcp_server.dart';
export 'src/utils.dart';
export 'src/websocket_client.dart';

/// getRandom uuid for parameters @extra
String getUuid(int length, {String? text}) {
  var ch = '0123456789abcdefghijklmnopqrstuvwxyz';
  if (text != null && text.isNotEmpty) {
    ch = text;
  }
  Random r = Random();
  return String.fromCharCodes(
      Iterable.generate(length, (_) => ch.codeUnitAt(r.nextInt(ch.length))));
}

T getRandomElement<T>(List<T> list) {
  final random = Random();
  var i = random.nextInt(list.length);
  return list[i];
}
