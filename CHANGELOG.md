## [2.0.0] - 04-07-2020

* Redesigned public API to be stream based.

## [0.8.0] - 04-07-2020

* Fixed visibility value not changing in Kotlin based Flutter apps

## [0.7.0] - 19-09-2019

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
