import 'package:flutter/widgets.dart';
import 'package:flutter_keyboard_visibility/src/keyboard_visibility.dart';

/// A convenience builder that exposes if the native keyboard is visible.
class KeyboardVisibilityBuilder extends StatelessWidget {
  const KeyboardVisibilityBuilder({Key key, this.builder}) : super(key: key);

  /// A builder method that exposes if the native keyboard is visible.
  final Widget Function(BuildContext, bool isKeyboardVisible) builder;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: KeyboardVisibility.onChange,
      initialData: KeyboardVisibility.isVisible,
      builder: (context, snapshot) {
        final isKeyboardVisible = snapshot.data;

        return builder(context, isKeyboardVisible);
      },
    );
  }
}
