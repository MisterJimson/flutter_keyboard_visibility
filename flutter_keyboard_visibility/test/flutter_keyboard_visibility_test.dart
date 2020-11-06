import 'package:flutter/widgets.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('KeyboardVisibilityProvider', () {
    testWidgets('It reports true when the keyboard is visible',
        (WidgetTester tester) async {
      // Pretend that the keyboard is visible.
      KeyboardVisibility.setVisibilityForTesting(true);

      // Build a Widget tree and query KeyboardVisibilityProvider
      // for the visibility of the keyboard.
      bool isKeyboardVisible;

      await tester.pumpWidget(
        KeyboardVisibilityProvider(
          child: Builder(
            builder: (BuildContext context) {
              isKeyboardVisible =
                  KeyboardVisibilityProvider.isKeyboardVisible(context);
              return SizedBox();
            },
          ),
        ),
      );

      // Verify that KeyboardVisibilityProvider reported that the
      // keyboard is visible.
      expect(isKeyboardVisible, true);
    });

    testWidgets('It reports false when the keyboard is NOT visible',
        (WidgetTester tester) async {
      // Pretend that the keyboard is hidden.
      KeyboardVisibility.setVisibilityForTesting(false);

      // Build a Widget tree and query KeyboardVisibilityProvider
      // for the visibility of the keyboard.
      bool isKeyboardVisible;

      await tester.pumpWidget(
        KeyboardVisibilityProvider(
          child: Builder(
            builder: (BuildContext context) {
              isKeyboardVisible =
                  KeyboardVisibilityProvider.isKeyboardVisible(context);
              return SizedBox();
            },
          ),
        ),
      );

      // Verify that KeyboardVisibilityProvider reported that the
      // keyboard is visible.
      expect(isKeyboardVisible, false);
    });

    testWidgets('It rebuilds when the keyboard visibility changes',
        (WidgetTester tester) async {
      // Pretend that the keyboard is visible.
      KeyboardVisibility.setVisibilityForTesting(true);

      // Build a Widget tree with a KeyboardVisibilityProvider.
      bool isKeyboardVisible;

      await tester.pumpWidget(
        KeyboardVisibilityProvider(
          child: Builder(
            builder: (BuildContext context) {
              isKeyboardVisible =
                  KeyboardVisibilityProvider.isKeyboardVisible(context);
              return SizedBox();
            },
          ),
        ),
      );

      // We expect that the keyboard is initially reported as visible.
      expect(isKeyboardVisible, true);

      // Pretend that the keyboard has gone from visible to hidden.
      KeyboardVisibility.setVisibilityForTesting(false);

      // Pump the tree to allow the InheritedWidget dependency to
      // rebuild its descendants.
      await tester.pumpAndSettle();

      // Verify that our descendant rebuilt itself, and received the
      // updated visibility of the keyboard.
      expect(isKeyboardVisible, false);
    });
  });
}
