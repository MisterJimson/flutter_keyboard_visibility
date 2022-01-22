import 'package:flutter/widgets.dart';

/// Removes the current focus and hides the keyboard when
/// the user taps on this widget.
///
/// Place this widget somewhere near the top of your widget
/// tree and when the user taps outside of a focused widget,
/// the focus will be removed and the keyboard will be hidden.
class KeyboardDismissOnTap extends StatelessWidget {
  /// Used to control if clicking a widget inheriting GestureDetector will
  /// dismiss the keyboard or not
  ///
  /// By default GestureDetectors are ignored
  final bool ignoreGestureDetectors;

  /// This is used to control if the next dismiss is allowed
  static bool _dismissible = true;

  const KeyboardDismissOnTap({
    Key? key,
    required this.child,
    this.ignoreGestureDetectors = true,
  }) : super(key: key);

  final Widget child;

  void _hideKeyboard(BuildContext context) {
    Future.delayed(Duration.zero, () {
      if (!_dismissible) {
        _dismissible = true;
      } else {
        final currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus && currentFocus.hasFocus) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ignoreGestureDetectors
        ? GestureDetector(
            onTap: () {
              _hideKeyboard(context);
            },
            child: child,
          )
        : Listener(
            onPointerUp: (_) {
              _hideKeyboard(context);
            },
            behavior: HitTestBehavior.translucent,
            child: child,
          );
  }
}

/// Prevent click on child to remove focus
class IgnoreKeyboardDismiss extends StatelessWidget {
  final Widget? child;

  const IgnoreKeyboardDismiss({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerUp: (_) {
        KeyboardDismissOnTap._dismissible = false;
      },
      behavior: HitTestBehavior.translucent,
      child: child,
    );
  }
}
