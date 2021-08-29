import 'package:flutter/widgets.dart';

/// Removes the current focus and hides the keyboard when
/// the user drags or taps this widget.
///
/// Place this widget somewhere near the top of your widget
/// tree and when the user drags or taps outside of a focused widget,
/// the focus will be removed and the keyboard will be hidden.
class KeyboardDismissOnTap extends StatelessWidget {
  final Widget child;
  final bool dismissOnTap;
  final bool dismissOnDrag;

  const KeyboardDismissOnTap({
    Key? key,
    required this.child,
    this.dismissOnTap = true,
    this.dismissOnDrag = false,
  }) : super(key: key);

  void _hideKeyboard(BuildContext context) {
    final currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus && currentFocus.hasFocus) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollUpdateNotification>(
      onNotification: (ScrollUpdateNotification notification) {
        final focusScope = FocusScope.of(context);
        if (dismissOnDrag && notification.dragDetails != null && focusScope.hasFocus) {
          focusScope.unfocus();
        }
        return false;
      },
      child: GestureDetector(
        onTap: dismissOnTap ? () => _hideKeyboard(context) : null,
        child: child,
      ),
    );
  }
}
