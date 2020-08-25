import 'package:flutter/services.dart';
import 'dart:async';

import 'package:flutter/widgets.dart';

/// Provides access to the current keyboard visibility state and emits
/// changes as they happen.
class KeyboardVisibility {
  static const _keyboardVisibilityStream =
      EventChannel('flutter_keyboard_visibility');

  static bool _isInitialized = false;
  static final _onChangeController = StreamController<bool>();
  static final _onChange = _onChangeController.stream.asBroadcastStream();

  /// Emits true every time the keyboard is shown, and false every time the
  /// keyboard is dismissed.
  static Stream<bool> get onChange {
    // If _testIsVisible set, don't try to create the EventChannel
    if (!_isInitialized && _testIsVisible == null) {
      _keyboardVisibilityStream
          .receiveBroadcastStream()
          .listen(_onKeyboardEvent);
      _isInitialized = true;
    }
    return _onChange;
  }

  /// Returns true if the keyboard is currently visible, false if not.
  static bool get isVisible => _testIsVisible ?? _isVisible;
  static bool _isVisible = false;

  /// Fake representation of whether or not the keyboard is visible
  /// for testing purposes. When this value is non-null, it will be
  /// reported exclusively by the `isVisible` getter.
  static bool _testIsVisible;

  /// Forces `KeyboardVisibility` to report `isKeyboardVisible`
  /// for testing purposes.
  ///
  /// `KeyboardVisibility` will continue reporting `isKeyboardVisible`
  /// until the value is changed again with this method. To stop
  /// using fake values altogether, set `isKeyboardVisible` to null.
  @visibleForTesting
  static void setVisibilityForTesting(bool isKeyboardVisible) {
    _testIsVisible = isKeyboardVisible;
    _onChangeController.add(_testIsVisible);
  }

  KeyboardVisibility._();

  static void _onKeyboardEvent(dynamic arg) {
    _isVisible = (arg as int) == 1;
    _onChangeController.add(isVisible);
  }
}

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

/// Removes the current focus and hides the keyboard when
/// the user taps on this widget.
///
/// Place this widget somewhere near the top of your widget
/// tree and when the user taps outside of a focused widget,
/// the focus will be removed and the keyboard will be hidden.
class KeyboardDismissOnTap extends StatelessWidget {
  const KeyboardDismissOnTap({
    Key key,
    this.child,
  }) : super(key: key);

  final Widget child;

  void _hideKeyboard(BuildContext context) {
    final currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus && currentFocus.hasFocus) {
      FocusManager.instance.primaryFocus.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _hideKeyboard(context);
      },
      child: child,
    );
  }
}
