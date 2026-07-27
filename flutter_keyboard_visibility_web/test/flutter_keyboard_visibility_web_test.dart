import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_keyboard_visibility_web/flutter_keyboard_visibility_web.dart';
import 'package:web/web.dart' as web;

void main() {
  test('reports that keyboard visibility is unsupported', () async {
    final plugin = FlutterKeyboardVisibilityPluginWeb(web.window.navigator);

    await expectLater(plugin.onChange, emits(false));
  });
}
