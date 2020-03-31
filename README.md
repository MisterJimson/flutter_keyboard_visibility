# Flutter Keyboard Visibility
[![pub package](https://img.shields.io/pub/v/flutter_keyboard_visibility.svg?label=flutter_keyboard_visibility&color=blue)](https://pub.dev/packages/flutter_keyboard_visibility)

Notification service for keyboard visibility.
This is a fork, original project [here](https://github.com/adee42/flutter_keyboard_visibility).

# Install
Add the dependency to your pubspec.yaml
```
dependencies:
  flutter_keyboard_visibility: ^0.7.0
```
(Please note that the two spaces in the beginning of the line are important)
Run `flutter packages get` in your root folder after saving the pubspec.yaml file.
# Usage
Import `package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart` 
The best practice to call the addNewListener function is inside the initState function as in the following example:

```dart
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

@override
void initState() {
  super.initState();

  KeyboardVisibilityNotification().addNewListener(
    onChange: (bool visible) {
      print(visible);
    },
  );
}
```
