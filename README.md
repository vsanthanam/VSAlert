# VSAlert

[![language](https://img.shields.io/badge/language-Objective--C-blue.svg)](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/ProgrammingWithObjectiveC/Introduction/Introduction.html)
[![license](https://img.shields.io/github/license/vsanthanam/vsalert.svg)](https://en.wikipedia.org/wiki/MIT_License)
[![GitHub release](https://img.shields.io/github/release/vsanthanam/VSAlert.svg)](https://github.com/vsanthanam/VSAlert/releases)
[![GitHub Release Date](https://img.shields.io/github/release-date/vsanthanam/VSAlert.svg)](https://github.com/vsanthanam/VSAlert/releases)
[![documentation](https://code.vsanthanam.com/VSAlert/Documentation/badge.svg)](https://code.vsanthanam.com/VSAlert/Documentation/)

## Set Up

For detailed instructions, see the [library website](https://vsalert.vsanthanam.com)

### Static Framework (Preferred)

1. Clone the repo and build the `Framework` target or download the latest release from the Releases tab.
2. Link against `VSAlert.framework`
3. Include the library using `@import VSAlert;` where relevent.

### CocoaPods

1. add `pod 'VSAlert', '~> 1.2'` to your project's podfile and run `pod install`. See the [project's page on CocoaPods.org](https://cocoapods.org/pods/VSAlert) for more information.
2. Include the library using `#import <VSAlert/VSAlert.h>` wherever relevent

### Source

1. Copy `VSAlertAction.h, VSAlertAction.m, VSAlertController.h, and VSAlertController.m`

## Usage & Docs

VSAlertController's API is designed to mimic UIAlertController virtually identically. Full documention is available at the [library website](https://vsalert.vsanthanam.com), as well as in the repo itself.

## Contributing

See the code of conduct.

