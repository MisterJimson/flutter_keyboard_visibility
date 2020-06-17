# Flutter Keyboard Visibility
[![pub package](https://img.shields.io/pub/v/flutter_keyboard_visibility.svg?label=flutter_keyboard_visibility&color=blue)](https://pub.dev/packages/flutter_keyboard_visibility)

React to keyboard visibility changes.

This is a fork, original project [here](https://github.com/adee42/flutter_keyboard_visibility).

# Install
Add the dependency to your pubspec.yaml
```
dependencies:
  flutter_keyboard_visibility: ^2.0.0
```
# Usage

## Option 1: Within your `Widget` tree

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

## Option 2: Direct query and subscription

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
