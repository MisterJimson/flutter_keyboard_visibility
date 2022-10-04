import 'dart:html' as html show window, Navigator;
import 'package:flutter_keyboard_visibility_platform_interface/flutter_keyboard_visibility_platform_interface.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

/// The web implementation of the [FlutterKeyboardVisibilityPlatform] of the
/// FlutterKeyboardVisibility plugin.
class FlutterKeyboardVisibilityPluginWeb
    extends FlutterKeyboardVisibilityPlatform {
  /// Constructs a [FlutterKeyboardVisibilityPluginWeb].
  FlutterKeyboardVisibilityPluginWeb(html.Navigator navigator);

  /// Factory method that initializes the FlutterKeyboardVisibility plugin
  /// platform with an instance of the plugin for the web.
  static void registerWith(Registrar registrar) {
    FlutterKeyboardVisibilityPlatform.instance =
        FlutterKeyboardVisibilityPluginWeb(html.window.navigator);
  }

  /// Emits changes to keyboard visibility from the platform. Web is not
  /// implemented yet so false is returned.
  @override
  Stream<bool> get onChange async* {
    yield false;
  }
}
