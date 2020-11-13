import 'dart:async';
import 'package:flutter_keyboard_visibility/src/keyboard_visibility_handler.dart';
import 'package:meta/meta.dart';

/// Provides access to the current keyboard visibility state and emits
/// changes as they happen.
@Deprecated(
    'Use KeyboardVisibilityController instead. Will be removed in a future release.')
class KeyboardVisibility {
  KeyboardVisibility._();

  /// Emits true every time the keyboard is shown, and false every time the
  /// keyboard is dismissed.
  @Deprecated(
      'Use KeyboardVisibilityController instead. Will be removed in a future release.')
  static Stream<bool> get onChange => KeyboardVisibilityHandler.onChange;

  /// Returns true if the keyboard is currently visible, false if not.
  @Deprecated(
      'Use KeyboardVisibilityController instead. Will be removed in a future release.')
  static bool get isVisible => KeyboardVisibilityHandler.isVisible;

  /// Forces `KeyboardVisibility` to report `isKeyboardVisible`
  /// for testing purposes.
  ///
  /// `KeyboardVisibility` will continue reporting `isKeyboardVisible`
  /// until the value is changed again with this method. To stop
  /// using fake values altogether, set `isKeyboardVisible` to null.
  @Deprecated(
      'Mock KeyboardVisibilityController instead. Will be removed in a future release.')
  @visibleForTesting
  static void setVisibilityForTesting(bool isKeyboardVisible) =>
      KeyboardVisibilityHandler.setVisibilityForTesting(isKeyboardVisible);
}
