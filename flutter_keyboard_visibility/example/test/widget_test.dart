import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_keyboard_visibility_example/main.dart';

/// If [KeyboardVisibility.setVisibilityForTesting] is set we should not see
/// a MissingPluginException logged
void main() {
  testWidgets('MissingPluginException Test', (WidgetTester tester) async {
    KeyboardVisibility.setVisibilityForTesting(false);

    await tester.pumpWidget(MyApp());
    await tester.runAsync(() async {
      await Future.delayed(Duration(milliseconds: 50));
    });
  });
}
