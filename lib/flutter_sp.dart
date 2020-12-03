import 'dart:async';

import 'package:flutter/services.dart';

class FlutterSp {
  static const MethodChannel _channel =
      const MethodChannel('io.flutter.plugins/flutter_sp');

  static Future<String> getUid() async {
    return _channel.invokeMethod('get_uid');
  }

  static Future<void> clearUid() async {
    return _channel.invokeMethod('set_uid');
  }
}
