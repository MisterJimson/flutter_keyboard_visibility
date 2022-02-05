import 'dart:async';
import 'dart:html' as html show window, Navigator;
import 'package:flutter/foundation.dart';
import 'package:flutter_keyboard_visibility_platform_interface/flutter_keyboard_visibility_platform_interface.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

/// The web implementation of the [FlutterKeyboardVisibilityPlatform] of the
/// FlutterKeyboardVisibility plugin.
class FlutterKeyboardVisibilityPlugin extends FlutterKeyboardVisibilityPlatform {
  /// Constructs a [FlutterKeyboardVisibilityPlugin].
  FlutterKeyboardVisibilityPlugin(html.Navigator navigator);

  static final _onChangeController = StreamController<bool>();
  static final _onChange = _onChangeController.stream.asBroadcastStream();

  static final isMobile = defaultTargetPlatform == TargetPlatform.iOS ||
      defaultTargetPlatform == TargetPlatform.android;

  /// Factory method that initializes the FlutterKeyboardVisibility plugin
  /// platform with an instance of the plugin for the web.
  static void registerWith(Registrar registrar) {
    FlutterKeyboardVisibilityPlatform.instance =
        FlutterKeyboardVisibilityPlugin(html.window.navigator);

    html.window.addEventListener('resize', (e) {
      // check if the visible part of the screen is less than 85%
      // if it is then the keyboard is showing
      final newValue =
          isMobile && (html.window.visualViewport!.height! / html.window.screen!.height!) < 0.85;
      _updateValue(newValue);
    });
  }

  static bool get isVisible => _isVisible;
  static bool _isVisible = false;

  static void _updateValue(bool newValue) {
    // Don't report the same value multiple times
    if (newValue == _isVisible) {
      return;
    }

    _isVisible = newValue;
    _onChangeController.add(newValue);
  }

  /// Emits changes to keyboard visibility from the platform.
  @override
  Stream<bool> get onChange => _onChange;
}
