---
title: Quick Start
homepage: true
description: a drop-in replacement in VSAlertController
layout: page
navorder: 0
---

# Overview

VSAlertController is a drop-in replacement for UIAlertController. It's designed to mimic UIAlertController's API as closely as possible, while adding addtional styling & behaviorial customization options. VSAlertController is loosely inspired by codeio's [PMAlertController](https://github.com/pmusolino/PMAlertController), but is written in Objective-C rather than Swift and does not use IB files to build its UI. VSAlertController adds the following additional features

* In addition to 'Alert' and 'Action Sheet' styles, VSAlert also provides a 'Walkthrough Alert' style, which is similar to an alert, but is significantly wider.
* Alerts can be optionally displayed with an image
* The background color, text color, text alignment, and text color of your alerts can be configured.
* The animation that is used to show / hide the alert can be configured
* Appearance of alerts can be configured at the per instance level, or globally via [UIAppearance](https://developer.apple.com/documentation/uikit/uiappearance?language=objc).

# Setup

VSAlert is packaged as a **static framework**. Using the compiled static framework is the recommended setup option, but you can also use CocoaPods, or include the source code directly in your target.

## Static Framework

1. Download the latest stable release [from GitHub](https://github.com/vsanthanam/VSAlert/releases). It contains a compiled static framework as well as a copy of the relevent documentation.
2. Add  `VSAlert.framework`, and have your target link against the framework during the build process.
3. Reference the library by importing the clang module in relevent files with `@import VSAlert;`.

## CocoaPods

1. If you haven't already, download & install [Ruby](https://www.ruby-lang.org/en/) and [CocoaPods](https://cocoapods.org) on your machine, and setup your project for use with CocoaPods with:

```
$ pod init
```

2. Add `pod 'VSAlert', '~> 1.2'` to your podfile for the appropriate targets.

3. Install the depedency by running:

```
$ pod install
```

4. Reference the library in the releventing files with `#import <VSAlert/VSAlert.h>`.

More information about the pod is available [here](https://cocoapods.org/pods/VSAlert).

## Direct Source

1. Clone the repository:

```
$ git clone https://github.com/vsanthanam/VSAlert.git
```

2. Add `VSAlertController.h`, `VSAlertController.m`, `VSAlertAction.h`, and `VSAlertAction.m` to your project.
3. Reference the library in the relevent files with `#import "VSAlertController.h"`.



<div class="alert alert-warning" markdown="1">
**Warning:** Using the version of the code on the master branch isn't always production ready. Use one of the other two installation options for production ready releases.
</div>


# Usage

## Basics

VSAlertController is designed to mimic the UIAlertController API as closely as possible. Its usage pattern is identical.

1. Create & configure an instance of `VSAlertController`.
2. Create & configure instances of `VSAlertAction` and add them to your alert controller by using it's `-addAction:` instance method.
3. Present your alert by calling UIViewController's `-presentViewController:animated:completion:` instance method on a view controller of your choice.

```objective-c

- (void)showAlert:(id)sender {

    VSAlertController *controller = [VSAlertController alertControllerWithTitle:@"Title" message:@"Message" style:VSAlertControllerStyleAlert];
                                                                          
    VSAlertAction *action = [VSAlertAction actionWithTitle:@"OK" style:VSAlertActionStyleCancel action:nil];
    
    [controller addAction:action];
    
    [self presentViewController:controller
                       animated:YES
                     completion:nil];

}

```

## Documentation

VSAlert is highly customizable, both at the per instance level, as well as globally via UIAppearance. Take a look at the [full documentation](https://code.vsanthanam.com/VSAlert/Documentation/index.html) for more detailed information on customizing your alerts and their actions.
