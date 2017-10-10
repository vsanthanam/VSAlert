# VSAlertController
An drop-in replacement for UIAlertController that looks a hell of a lot better, built in Objective-C. Based on Codedio's aweomse Swift library, PMAlertController (https://github.com/Codeido/PMAlertController).

Like PMAlertController, VSAlertController builds on the functionality of UIAlertController by adding:

* Built-in support for images in the heading of the alert
* Much better animation
* Much more flexible customization, because alert actions are subclasses of UIButton.

VSAlertController differs from PMAlertController in a few ways:

1. VSAlertController doesn't build it's UI using a XIB file, which makes it a little bit more portable and easier to manage.
2. VSAlertController is written in Objective-C rather than Swift (but is marked up using nullability for easy use in Swift)
3. VSAlertController allows for a bit more customization at runtime.
4. VSAlertController adds the "destructive" action style from Apple's UIAlertController that was missing in PMAlertController
5. VSAlertController doesn't add actions and text fields in the order you create them, but rather in a dynamic order based on how many there are and what "style" they are (again, like Apple's UIAlertController)
6. VSAlertController doesn't rely on UITextFieldDelegate, so you can freely assign your UITextField's `.delegate` property without fear and the library will continue to work as expected.
6. VSAlertController executes action blocks on the main-thread, to allow for UI actions and not get caught up by the main thread checker in Xcode 9.
7. VSAlertController adds the "Action Sheet" style from Apple's UIAlertController, missing from PMAlertController
8. VSAlertController uses propertransition, and respects the `animated` parameter in UIViewController's `-presentViewController:animated:completion:` method

## Just Give Me The Code
VSAlertController is packaged as a static library (with slices for all modern iPhones and the simulator), but the six files for the three classes that comprise the library are also available in the repo. Open the project, build the "Framework" targetfor "Generic iOS Device"  if you want to re-compile the static library. The framework is built as a clang module, so you can use the `@import module;` syntax. (More info here: https://clang.llvm.org/docs/Modules.html)

## Getting Started (Static Framework)

1. Go to `(RepoDirectory)/Release/VSAlert.framework`, and add it to your project directory.
2. In your app target's settings, go to "General" --> "Linked Frameworks and Libraries", and add `VSAlert.framework`

## Getting Started (Using the source code directly)
1. Go to `(RepoDirectory)/Library`, and add all six files to your project. Make sure to add both the implementation files to your target's `compile sources`  build phase.

## Usage
The included Xcode project allows you to build the static library and an example application. Take a look at the example app to see all customization options, but here's a basic implementation:

```Objective-C

#import "MyViewController.h"

@import VSAlert;

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

Full documentation is available at https://vsanthanam.github.io/VSAlertController/docs

## Image Template

VSAlertController includes template images to help you size your images to make them look just right on an alert. I suggest using an Image that is 270pt tall and 180pt high, with your actual content centered in the middle at 116 x 116 pt. I've included PNGs with the appropriate outline, as well as a .sketch file
