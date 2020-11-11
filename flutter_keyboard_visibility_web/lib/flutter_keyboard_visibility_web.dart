import 'dart:html' as html show window, BatteryManager, Navigator;
import 'package:flutter_keyboard_visibility_platform_interface/flutter_keyboard_visibility_platform_interface.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

/// The web implementation of the [FlutterKeyboardVisibilityPlatform] of the Battery plugin.
class FlutterKeyboardVisibilityPlugin
    extends FlutterKeyboardVisibilityPlatform {
  /// Constructs a [FlutterKeyboardVisibilityPlugin].
  FlutterKeyboardVisibilityPlugin(html.Navigator navigator);

  /// Factory method that initializes the Battery plugin platform with an instance
  /// of the plugin for the web.
  static void registerWith(Registrar registrar) {
    FlutterKeyboardVisibilityPlatform.instance =
        FlutterKeyboardVisibilityPlugin(html.window.navigator);
  }

  @override
  Stream<bool> get onChange async* {
    yield false;
  }
}
