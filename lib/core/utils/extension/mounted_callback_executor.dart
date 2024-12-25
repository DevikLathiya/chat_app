import 'dart:async';
import 'package:flutter/scheduler.dart';

class MountedCallbackExecutor {
  MountedCallbackExecutor._();

  static Future<dynamic> ensureIsThatMounted(Future<dynamic> Function() callBack) async {
    final completer = Completer<dynamic>();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      final result = await callBack();
      completer.complete(result);
    });
    return completer.future;
  }
}
