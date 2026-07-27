# Releasing

This repository is a Dart pub workspace containing six publishable packages.
All packages are published through GitHub Actions with pub.dev's short-lived
OpenID Connect credentials.

## One-time setup

1. Create a protected GitHub environment named `pub.dev`.
2. On the **Admin** tab for each package on pub.dev, enable automated publishing
   from `MisterJimson/flutter_keyboard_visibility`.
3. Require the `pub.dev` GitHub environment and configure the matching tag
   pattern listed below.
4. Add required reviewers to the GitHub environment.

| Package | Tag pattern |
| --- | --- |
| `flutter_keyboard_visibility_platform_interface` | `flutter_keyboard_visibility_platform_interface-v{{version}}` |
| `flutter_keyboard_visibility_web` | `flutter_keyboard_visibility_web-v{{version}}` |
| `flutter_keyboard_visibility_linux` | `flutter_keyboard_visibility_linux-v{{version}}` |
| `flutter_keyboard_visibility_macos` | `flutter_keyboard_visibility_macos-v{{version}}` |
| `flutter_keyboard_visibility_windows` | `flutter_keyboard_visibility_windows-v{{version}}` |
| `flutter_keyboard_visibility` | `flutter_keyboard_visibility-v{{version}}` |

## Release process

1. Update package versions, dependency constraints, and changelogs.
2. Run CI and require every job to pass.
3. Publish in dependency order by pushing one tag at a time:

   1. `flutter_keyboard_visibility_platform_interface`
   2. `flutter_keyboard_visibility_web`
   3. `flutter_keyboard_visibility_linux`
   4. `flutter_keyboard_visibility_macos`
   5. `flutter_keyboard_visibility_windows`
   6. `flutter_keyboard_visibility`

4. Wait for each version to become available on pub.dev before pushing the next
   dependent package tag.
5. Create a GitHub release for the main-package tag with the main changelog
   entry as its release notes.

For the versions prepared in this repository, the tags are:

```text
flutter_keyboard_visibility_platform_interface-v3.0.0
flutter_keyboard_visibility_web-v3.0.0
flutter_keyboard_visibility_linux-v2.0.0
flutter_keyboard_visibility_macos-v2.0.0
flutter_keyboard_visibility_windows-v2.0.0
flutter_keyboard_visibility-v7.0.0
```
