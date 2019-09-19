import 'package:flutter/services.dart';
import 'dart:async';

/// A base class to handle the subscribing events
class KeyboardVisibilitySubscriber {
  /// Called when a keyboard visibility event occurs
  /// Is only called when the state changes
  /// The [visible] parameter reflects the new visibility
  final Function(bool visible) onChange;

  /// Called when the keyboard appears
  final Function onShow;

  /// Called when the keyboard closes
  final Function onHide;

  /// Constructs a new [KeyboardVisibilitySubscriber]
  KeyboardVisibilitySubscriber({this.onChange, this.onShow, this.onHide});
}

/// The notification class that handles all information
class KeyboardVisibilityNotification {
  static const EventChannel _keyboardVisibilityStream =
      const EventChannel('flutter_keyboard_visibility');
  static Map<int, KeyboardVisibilitySubscriber> _list =
      Map<int, KeyboardVisibilitySubscriber>();
  static StreamSubscription _keyboardVisibilitySubscription;
  static int _currentIndex = 0;

  /// The current state of the keyboard visibility. Can be used without subscribing
  bool isKeyboardVisible = false;

  /// Constructs a new [KeyboardVisibilityNotification]
  KeyboardVisibilityNotification() {
    _keyboardVisibilitySubscription ??= _keyboardVisibilityStream
        .receiveBroadcastStream()
        .listen(onKeyboardEvent);
  }

  /// Internal function to handle native code channel communication
  void onKeyboardEvent(dynamic arg) {
    isKeyboardVisible = (arg as int) == 1;

    // send a message to all subscribers notifying them about the new state
    _list.forEach((subscriber, s) {
      try {
        if (s.onChange != null) {
          s.onChange(isKeyboardVisible);
        }
        if ((s.onShow != null) && isKeyboardVisible) {
          s.onShow();
        }
        if ((s.onHide != null) && !isKeyboardVisible) {
          s.onHide();
        }
      } catch (_) {}
    });
  }

  /// Subscribe to a keyboard visibility event
  /// [onChange] is called when a change of the visibility occurs
  /// [onShow] is called when the keyboard appears
  /// [onHide] is called when the keyboard disappears
  /// Returns a subscribing id that can be used to unsubscribe
  int addNewListener(
      {Function(bool) onChange, Function onShow, Function onHide}) {
    _list[_currentIndex] = KeyboardVisibilitySubscriber(
        onChange: onChange, onShow: onShow, onHide: onHide);
    return _currentIndex++;
  }

  /// Subscribe to a keyboard visibility event using a subscribing class [subscriber]
  /// Returns a subscribing id that can be used to unsubscribe
  int addNewSubscriber(KeyboardVisibilitySubscriber subscriber) {
    _list[_currentIndex] = subscriber;
    return _currentIndex++;
  }

  /// Unsubscribe from the keyboard visibility events
  /// [subscribingId] has to contain an id previously returned on add
  void removeListener(int subscribingId) {
    _list.remove(subscribingId);
  }

  /// Internal function to clear class on dispose
  dispose() {
    if (_list.length == 0) {
      _keyboardVisibilitySubscription?.cancel()?.catchError((e) {});
      _keyboardVisibilitySubscription = null;
    }
  }
}
