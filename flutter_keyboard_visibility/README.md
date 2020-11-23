# Flutter Keyboard Visibility
[![pub package](https://img.shields.io/pub/v/flutter_keyboard_visibility.svg?label=flutter_keyboard_visibility&color=blue)](https://pub.dev/packages/flutter_keyboard_visibility)

React to keyboard visibility changes.

## Install
Add the dependency to your pubspec.yaml
```yaml
dependencies:
  flutter_keyboard_visibility: ^3.3.0
```
## Usage: React to Keyboard Visibility Changes
### Option 1: Within your `Widget` tree using a builder
Build your Widget tree based on whether or not the keyboard is visible by using `KeyboardVisibilityBuilder`.
```dart
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

/// In any of your widgets...
@override
Widget build(BuildContext context) {
  return KeyboardVisibilityBuilder(
    builder: (context, isKeyboardVisible) {
      return Text(
        'The keyboard is: ${isKeyboardVisible ? 'VISIBLE' : 'NOT VISIBLE'}',
      );
    }
  );
```
### Option 2: Within your `Widget` tree using a provider
Build your `Widget` tree based on whether or not the keyboard is
visible by including a `KeyboardVisibilityProvider` near the top
of your tree.
```dart
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

// Somewhere near the top of your tree...
@override
Widget build(BuildContext context) {
  return KeyboardVisibilityProvider(
    child: MyDemoPage(),
  );
}

// Within MyDemoPage...
@override
Widget build(BuildContext context) {
  final bool isKeyboardVisible = KeyboardVisibilityProvider.isKeyboardVisible(context);
  return Text(
    'The keyboard is: ${isKeyboardVisible ? 'VISIBLE' : 'NOT VISIBLE'}',
  );
}
```

### Option 3: Direct query and subscription

Query and/or subscribe to keyboard visibility directly with the  
`KeyboardVisibility` class.

```dart
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

@override
void initState() {
  super.initState();
  // Query
  print('Keyboard visibility direct query: ${KeyboardVisibility.isVisible}');
  
  // Subscribe
  KeyboardVisibility.onChange.listen((bool visible) {
    print('Keyboard visibility update. Is visible: ${visible}');
  });
}
```
## Usage: Dismiss keyboard on tap
Place a `KeyboardDismissOnTap` near the top of your `Widget` tree. When a user taps outside of the currently focused `Widget`, the `Widget` will drop focus and the keyboard will be dismissed.
```dart
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

// Somewhere near the top of your tree...
@override
Widget build(BuildContext context) {
  return KeyboardDismissOnTap(
    child: MyDemoPage(),
  );
}
```
## Testing
Mock `MockKeyboardVisibilityController` and pass it to `KeyboardVisibilityBuilder` or `KeyboardVisibilityProvider`
```dart
void main() {
  testWidgets('My Test', (WidgetTester tester) async {
     // Pretend that the keyboard is visible.
      var mockController = MockKeyboardVisibilityController();
      when(mockController.onChange)
          .thenAnswer((_) => Stream.fromIterable([true]));
      when(mockController.isVisible).thenAnswer((_) => true);

      await tester.pumpWidget(
        KeyboardVisibilityBuilder(
          controller: mockController,
          builder: (_, _isKeyboardVisible) {
            // _isKeyboardVisible is true!
            return SizedBox();
          },
        ),
      );
  });
}
```