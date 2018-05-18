# VSAlert

![Language](https://img.shields.io/badge/language-Objective--C-blue.svg)
![License](https://img.shields.io/badge/license-MIT-blue.svg)
![Documentation](https://code.vsanthanam.com/VSAlert/Documentation/badge.svg)
![GitHub last commit](https://img.shields.io/github/last-commit/vsanthanam/vsalert.svg)

An drop-in replacement for UIAlertController that looks a hell of a lot better, built in Objective-C. Based on Codedio's aweomse Swift library, [PMAlertController](https://github.com/Codeido/PMAlertController).

Like PMAlertController, VSAlert builds on the functionality of UIAlertController by adding:

* Built-in support for images in the heading of the alert
* Much better animation
* Much more flexible customization, because alert actions are subclasses of UIButton.

VSAlertController differs from PMAlertController in a few ways:

1. VSAlert doesn't build it's UI using a XIB file, which makes it a little bit more portable and easier to manage.
2. VSAlert is written in Objective-C rather than Swift (but is marked up using nullability for easy use in Swift)
3. VSAlert allows for a bit more customization at runtime.
4. VSAlert adds the "destructive" action style from Apple's UIAlertController that was missing in PMAlertController
5. VSAlert doesn't add actions and text fields in the order you create them, but rather in a dynamic order based on how many there are and what "style" they are (again, like Apple's UIAlertController)
6. VSAlert doesn't rely on UITextFieldDelegate, so you can freely assign your UITextField's `.delegate` property without fear and the library will continue to work as expected.
6. VSAlert executes action blocks on the main-thread, to allow for UI actions and not get caught up by the main thread checker in Xcode 9.
7. VSAlert adds the "Action Sheet" style from Apple's UIAlertController, missing from PMAlertController
8. VSAlert uses propertransition, and respects the `animated` parameter in UIViewController's `-presentViewController:animated:completion:` method

## Set Up

### Just Give Me The Code
All you need are `VSAlertController.h`, `VSAlertController.m`, `VSAlertAction.h`, and `VSAlertAction.m`.

### Getting Started (Static Framework)
1. Go to `(RepoDirectory)/Release/VSAlert.framework`, and add it to your project directory.
2. In your app target's settings, go to "General" --> "Linked Frameworks and Libraries", and add `VSAlert.framework`
3. In your target's build settings, go to "Other Linker Flags", and add `-all_load` and `-ObjC`.

### Getting Started (Using the source code directly)
1. Go to `(RepoDirectory)/VSALert`, and add all the files excepting the modulemap and the umbrella header to your project. Make sure to add all the implementation files to your target's `compile sources`  build phase, incase Xcode doesn't do this for you automatically when adding the files to the target's membership

## Usage

### Basics
The included Xcode project allows you to build the static library and an example application. Take a look at the example app to see all customization options, but here's a basic implementation:

```Objective-C

#import "MyViewController.h"

@import VSAlert; // replace with #import 'VSAlertController.h' if you're using the source rather than the static framework

@implementation MyViewController

- (void)showAlert:(id)sender {

    VSAlertController *alertController = [VSAlertController alertControllerWithTitle:NSLocalizedString(@"Alert!", nil) description:NSLocalizedString(@"This app needs your attention right now", nil) style:VSAlertControllerStyleAlert];
    VSAlertAction *action = [VSAlertAction actionWithTitle:NSLocalizedString(@"Close", nil) style:VSAlertActionStyleDefault action:^(VSAlertAction *action) {
    
        NSLog(@"Do Something");
    
    }
    
    [alertController addAction:action];
    [self presentViewController:alertController animated:YES completion:nil];

}

@end
```
### Documentation
Full documentation is [here](https://vsanthanam.github.io/VSAlert/Documentation/index.html), at https://code.vsanthanam.com/VSAlert/Documentation/index.html

Documentation with made with [Jazzy](https://github.com/realm/jazzy) by [Realm](https://realm.io), using the [Jony Theme](https://github.com/HarshilShah/Jony) by [Harshil Shah](https://github.com/HarshilShah/), and is hosted on GitHub Pages.

### Image Template
VSAlertController includes template images to help you size your images to make them look just right on an alert. I suggest using an Image that is 270pt tall and 180pt high, with your actual content centered in the middle at 116 x 116 pt. I've included PNGs with the appropriate outline, as well as a .sketch file

