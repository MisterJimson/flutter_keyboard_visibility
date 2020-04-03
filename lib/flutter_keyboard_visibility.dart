import 'package:flutter/services.dart';
import 'dart:async';

class KeyboardVisibility {
  static const _keyboardVisibilityStream =
      EventChannel('flutter_keyboard_visibility');
  static bool _isInitialized = false;

  static final _onChangeController = StreamController<bool>();
  static final _onChange = _onChangeController.stream.asBroadcastStream();

  static Stream<bool> get onChange {
    if (!_isInitialized) {
      _keyboardVisibilityStream
          .receiveBroadcastStream()
          .listen(_onKeyboardEvent);
      _isInitialized = true;
    }
    return _onChange;
  }

  static bool isKeyboardVisible = false;

  KeyboardVisibility._();

  static void _onKeyboardEvent(dynamic arg) {
    isKeyboardVisible = (arg as int) == 1;
    _onChangeController.add(isKeyboardVisible);
  }

  static void dispose() {
    _onChangeController.close();
  }
}
