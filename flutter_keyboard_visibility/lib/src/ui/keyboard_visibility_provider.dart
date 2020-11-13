import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:flutter_keyboard_visibility/src/keyboard_visibility.dart';

/// Widget that reports to its descendants whether or not
/// the keyboard is currently visible.
///
/// Example usage:
///
/// ```
/// // A Builder is used in this example solely for the purpose
/// // of demonstrating ancestor access from within a single
/// // build() method. You do not need to use a Builder if you
/// // access KeyboardVisibilityProvider from within a custom
/// // StatelessWidget or StatefulWidget.
/// return KeyboardVisibilityProvider(
///   child: Builder(
///     builder: (BuildContext context) {
///       final bool isKeyboardVisible = KeyboarVisibilityProvider.isKeyboardVisible(context);
///
///       return Text('Keyboard is visible: $isKeyboardVisible');
///     },
///   ),
/// );
/// ```
class KeyboardVisibilityProvider extends StatefulWidget {
  /// Returns `true` if the keyboard is currently visible, `false`
  /// if the keyboard is not currently visible, or `null` if
  /// the `flutter_keyboard_visibility` plugin does not yet
  /// know if the keyboard is visible.
  ///
  /// This method also establishes an `InheritedWidget` dependency
  /// with the given `context`, and therefore the given `context`
  /// will automatically rebuild if the keyboard visibility changes.
  static bool isKeyboardVisible(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<
            _KeyboardVisibilityInheritedWidget>()
        .isKeyboardVisible;
  }

  const KeyboardVisibilityProvider({
    Key key,
    this.child,
  }) : super(key: key);

  final Widget child;

  @override
  _KeyboardVisibilityProviderState createState() =>
      _KeyboardVisibilityProviderState();
}

class _KeyboardVisibilityProviderState
    extends State<KeyboardVisibilityProvider> {
  StreamSubscription _subscription;
  bool _isKeyboardVisible = false;

  @override
  void initState() {
    super.initState();
    _isKeyboardVisible = KeyboardVisibility.isVisible;
    _subscription =
        KeyboardVisibility.onChange.listen(_onKeyboardVisibilityChange);
  }

  void _onKeyboardVisibilityChange(bool isKeyboardVisible) {
    setState(() {
      _isKeyboardVisible = isKeyboardVisible;
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _KeyboardVisibilityInheritedWidget(
      isKeyboardVisible: _isKeyboardVisible,
      child: widget.child,
    );
  }
}

/// `InheritedWidget` that rebuilds descendants whenever
/// `isKeyboardVisible` changes.
class _KeyboardVisibilityInheritedWidget extends InheritedWidget {
  _KeyboardVisibilityInheritedWidget({
    Key key,
    @required this.isKeyboardVisible,
    Widget child,
  }) : super(key: key, child: child);

  final bool isKeyboardVisible;

  @override
  bool updateShouldNotify(_KeyboardVisibilityInheritedWidget oldWidget) {
    return isKeyboardVisible != oldWidget.isKeyboardVisible;
  }
}
