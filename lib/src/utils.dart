import 'dart:async';

import 'package:flutter/widgets.dart';

/// Creates and returns a timer that fires periodically.
Timer createPeriodicTimer({
  required Duration period,
  required void Function(Timer timer) callback,
  bool fireImmediately = false,
}) {
  final timer = Timer.periodic(period, callback);
  if (fireImmediately) {
    callback(timer);
  }
  return timer;
}

/// A callback that takes a [BuildContext] as an argument and returns nothing.
typedef VoidContextedCallback = void Function(BuildContext context);
