import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility_platform_interface/flutter_keyboard_visibility_platform_interface.dart';
import 'package:meta/meta.dart';

/// The method channel implementation of the flutter_keyboard_visibility plugin,
/// currently used for Android and iOS.
class MethodChannelFlutterKeyboardVisibility
    extends FlutterKeyboardVisibilityPlatform {
  /// The event channel used for emitting keyboard visibility updates
  @visibleForTesting
  EventChannel eventChannel = EventChannel('flutter_keyboard_visibility');

  Stream<bool> _onKeyboardVisibilityChange;

  /// Emits changes to keyboard visibility from the platform
  @override
  Stream<bool> get onChange {
    _onKeyboardVisibilityChange ??= eventChannel
        .receiveBroadcastStream()
        .map((dynamic event) => (event as int) == 1);
    return _onKeyboardVisibilityChange;
  }
}
