#!/usr/bin/env bash
(cd flutter_keyboard_visibility_platform_interface && flutter analyze)
(cd flutter_keyboard_visibility_web && flutter analyze)
(cd flutter_keyboard_visibility && flutter analyze)
(cd flutter_keyboard_visibility/example && flutter analyze)
(cd flutter_keyboard_visibility/example_old && flutter analyze)
(cd flutter_keyboard_visibility && flutter test --no-sound-null-safety --coverage)
