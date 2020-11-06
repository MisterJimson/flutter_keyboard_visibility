import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility_platform_interface/flutter_keyboard_visibility_platform_interface.dart';
import 'package:meta/meta.dart';

class MethodChannelFlutterKeyboardVisibility
    extends FlutterKeyboardVisibilityPlatform {
  @visibleForTesting
  EventChannel eventChannel = EventChannel('flutter_keyboard_visibility');

  Stream<bool> _onKeyboardVisibilityChange;

  @override
  Stream<bool> get onChange {
    if (_onKeyboardVisibilityChange == null) {
      _onKeyboardVisibilityChange = eventChannel
          .receiveBroadcastStream()
          .map((dynamic event) => (event as int) == 1);
    }
    return _onKeyboardVisibilityChange;
  }
}
