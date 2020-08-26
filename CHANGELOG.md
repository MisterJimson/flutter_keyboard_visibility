## [3.2.2] - August 26, 2020

* MissingPluginException if no longer thrown during `flutter test` if you first call `KeyboardVisibility.setVisibilityForTesting(value)` in your test

## [3.2.1] - June 22, 2020

Thanks to ram231 for this fix

* Fixed KeyboardDismissOnTap sometimes reopening the keyboard

## [3.2.0] - June 16, 2020

Thanks to matthew-carroll for this feature

* KeyboardDismissOnTap to allow for tapping outside of the focused field to dismiss the keyboard

## [3.1.0] - June 16, 2020

Thanks to matthew-carroll for these features and helping fix the bug

* KeyboardVisibilityProvider for InheritedWidget style access to keyboard visibility within the Widget tree
* Added setVisibilityForTesting to assist for testing with fake values
* Fixed visibility not being reporting on Android for apps with pre Flutter 1.12 Android projects

## [3.0.0] - June 2, 2020

* Migrated to new Android plugin APIs

## [2.0.0] - April 7, 2020

* Redesigned public API to be stream based.

## [0.8.0] - April 7, 2020

* Fixed visibility value not changing in Kotlin based Flutter apps

## [0.7.0] - September 19, 2019

* Forked the project as original repo stopped being updated
* Fix: ViewTreeObserver is unregister when start second Activity because onStop call delay
* Fix: Activity() returns null when using backgrounding flutter plugins
* AndroidX migration
* Remove reachability dependency

### The below changelog is from the original package 
## [0.5.6] - 13-05-2019

* added null check in Android layout callback
* changed behavior on dispose
* catching exceptions if callbacks are not unsubscribed properly

## [0.5.5] - 11-05-2019

* Changed README.md and formatted Dart code

## [0.5.4] - 11-05-2019

* Fixed plugin registration bug

## [0.5.3] - 09-05-2019

* Fixed exception call bug on dispose
* Change behavior of plugin registration

## [0.5.2] - 12-03-2019

* Fixed possible bug on dispose
* On iOS the keyboard pop up message is already being sent when keyboard starts popping up

## [0.5.1] - 06-01-2019

* Fixed bug when using multiple listeners on same page

## [0.5.0] - 06-12-2018

* Initial release, working on Android and iOS
