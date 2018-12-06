# keyboard_visibility

Notification service for soft-keyboard visibility

# Usage

Import `package:keyboard_visibility/keyboard_visibility.dart`, instantiate `KeyboardVisibilityNotification`
and use the Android and iOS notifications to get events about changes of the visibility of the soft-keyboard

Example:

```dart
import 'package:keyboard_visibility/keyboard_visibility.dart';

KeyboardVisibilityNotification().addNewListener(
  onChange: (bool visible) {
    // called when the keyboard visibility changes
  },
);
```

Also check out the example included with the package

## Getting Started

For help getting started with Flutter, view the following online
[documentation](http://flutter.io/).