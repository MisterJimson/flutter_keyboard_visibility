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
```dart
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

@override
void initState() {
  super.initState();
  KeyboardVisibility.onChange.listen((bool visible) {
    print(visible);
  });
}
```
