import 'package:flutter/services.dart';
import 'dart:async';

/// Provides access to the current keyboard visibility state and emits
/// changes as they happen.
class KeyboardVisibility {
  static const _keyboardVisibilityStream =
      EventChannel('flutter_keyboard_visibility');

  static bool _isInitialized = false;
  static final _onChangeController = StreamController<bool>();
  static final _onChange = _onChangeController.stream.asBroadcastStream();

  /// Emits true every time the keyboard is shown, and false every time the
  /// keyboard is dismissed.
  static Stream<bool> get onChange {
    if (!_isInitialized) {
      _keyboardVisibilityStream
          .receiveBroadcastStream()
          .listen(_onKeyboardEvent);
      _isInitialized = true;
    }
    return _onChange;
  }

  /// Returns true if the keyboard is currently visible, false if not.
  static bool isVisible = false;

  KeyboardVisibility._();

  static void _onKeyboardEvent(dynamic arg) {
    isVisible = (arg as int) == 1;
    _onChangeController.add(isVisible);
  }
}
