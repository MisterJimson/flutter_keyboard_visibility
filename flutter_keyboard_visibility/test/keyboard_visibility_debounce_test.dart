import 'dart:async';

import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_keyboard_visibility_platform_interface/flutter_keyboard_visibility_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class _FakePlatform extends FlutterKeyboardVisibilityPlatform
    with MockPlatformInterfaceMixin {
  final changes = StreamController<bool>();

  @override
  Stream<bool> get onChange => changes.stream;
}

void main() {
  // KeyboardVisibilityHandler subscribes to the platform once, statically, so
  // every test shares this platform and the values the previous one left.
  final platform = _FakePlatform();
  FlutterKeyboardVisibilityPlatform.instance = platform;
  final controller = KeyboardVisibilityController();
  final reported = <bool>[];
  controller.onChange.listen(reported.add);

  setUp(reported.clear);

  // The handler's timers belong to the zone it subscribed in, so these wait
  // for real rather than pumping fake time.
  Future<void> wait(int ms) => Future.delayed(Duration(milliseconds: ms));

  test('A shown keyboard is reported after 25 ms', () async {
    platform.changes.add(true);
    await wait(5);
    expect(reported, isEmpty);

    await wait(60);
    expect(reported, [true]);
    expect(controller.isVisible, isTrue);
  });

  test('A hidden keyboard is reported after 250 ms', () async {
    platform.changes.add(false);
    await wait(150);
    expect(reported, isEmpty);
    expect(controller.isVisible, isTrue);

    await wait(250);
    expect(reported, [false]);
    expect(controller.isVisible, isFalse);
  });

  test('A keyboard that hides and shows again is not reported', () async {
    platform.changes.add(true);
    await wait(60);
    expect(reported, [true]);
    reported.clear();

    // Hidden and shown again within 250 ms, as when switching modes.
    platform.changes.add(false);
    await wait(100);
    platform.changes.add(true);
    await wait(400);

    expect(reported, isEmpty);
    expect(controller.isVisible, isTrue);
  });
}
