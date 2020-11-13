import 'package:flutter_keyboard_visibility/src/keyboard_visibility.dart';

class KeyboardVisibilityController {
  /// Constructs a singleton instance of [KeyboardVisibilityController].
  ///
  /// [KeyboardVisibilityController] is designed to work as a singleton.
  // When a second instance is created, the first instance will not be able to listen to the
  // EventChannel because it is overridden. Forcing the class to be a singleton class can prevent
  // misuse of creating a second instance from a programmer.
  factory KeyboardVisibilityController() {
    _instance ??= KeyboardVisibilityController._();
    return _instance;
  }

  KeyboardVisibilityController._();

  static KeyboardVisibilityController _instance;

  Stream<bool> get onChange => KeyboardVisibility.onChange;

  bool get isVisible => KeyboardVisibility.isVisible;
}
