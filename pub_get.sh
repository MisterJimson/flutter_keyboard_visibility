#!/usr/bin/env bash
(cd flutter_keyboard_visibility_platform_interface && flutter pub get)
(cd flutter_keyboard_visibility_web && flutter pub get)
(cd flutter_keyboard_visibility && flutter pub get)
(cd flutter_keyboard_visibility/example_old && flutter pub get)
