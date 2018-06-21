//
//  VSAlertController.h
//  VSAlertController
//
//  Created by Varun Santhanam on 10/8/17.
//

@import UIKit;

#import "VSAlertAction.h"

/**
 An exception thrown when an unimplemented feature is encountered at runtime.
 */
extern NSString * _Nonnull const VSAlertControllerNotImplementedException;

/**
 An exception thrown when a text field is added to an alert controller which doesn't support text fields
 */
extern NSString * _Nonnull const VSAlertControllerTextFieldInvalidException;

/**
 An exception thrown when a view controller presentation animation fails
 */
extern NSString * _Nonnull const VSAlertControllerPresentationAnimationException;

/**
 An enumeration describing the kinds of alerts that VSAlertController can display

 - VSAlertControllerStyleAlert: A standard alert, 270pt wide, variable height. Supports texts fields.
 - VSAlertControllerStyleWalkthroughAlert: A wider alert that stretches to the margins of the device - 18pt in either direction. Supports text fields, useful for onboarding. 500pt wide on iPad.
 - VSAlertControllerStyleActionSheet: An alert that appears at the bottom of the display, similar to Apple's action sheet stlye. Does NOT support text fields.
 */
typedef NS_ENUM(NSInteger, VSAlertControllerStyle) {

    /**
     A standard alert, 270pt wide, variable height. Supports text fields
     */
    VSAlertControllerStyleAlert,
    
    /**
     A wider alert that stretches to the margins of the device - 18pt in either direction. Supports text fields, useful for onboarding. 500pt wide on iPad.
     */
    VSAlertControllerStyleWalkthroughAlert,
    
    /**
     An alert that appears at the bottom of the display, similar to Apple's action sheet stlye. Does NOT support text fields.
     */
    VSAlertControllerStyleActionSheet
    
};

/**
 An enumeration describing the kinds of animations that can be used to present and hide an alert

 - VSAlertControllerAnimationStyleRise: The alert rises from the bottom of the screen and falls down when dismissed.
 - VSAlertControllerAnimationStyleFall: The alert falls from the top of the screen and rises up when dismissed.
 - VSAlertControllerAnimationStyleSlide: The alert slides from the left of the screen and slides to the right when dismissed.
 - VSAlertControllerAnimationStyleFlip: The alert flips from the right, and flips to the left when dismissed.
 - VSAlertControllerAnimationStyleSticker: The alert page flips from the top, then again from the bottom when dismissed.
 - VSAlertControllerAnimationStyleCrossDisolve: The alert page fades in, then fades out dismissed.
 - VSAlertControllerAnimationStyleAutomatic: The alert chooses its presentation and dismissal styles automatically.
 */
typedef NS_ENUM(NSInteger, VSAlertControllerAnimationStyle) {
    
    /**
     The alert rises from the bottom of the screen and falls down when dismissed.
     */
    VSAlertControllerAnimationStyleRise,
    
    /**
     The alert falls from the top of the screen and rises up when dismissed.
     */
    VSAlertControllerAnimationStyleFall,
    
    /**
     The alert slides from the left of the screen and slides to the right when dismissed.
     */
    VSAlertControllerAnimationStyleSlide,
    
    /**
     The alert flips from the right, and flips to the left when dismissed.
     */
    VSAlertControllerAnimationStyleFlip,
    
    /**
     The alert page flips from the top, then again from the bottom when dismissed.
     */
    VSAlertControllerAnimationStyleSticker,
    
    /**
     The alert page fades in, then fades out dismissed.
     */
    VSAlertControllerAnimationStyleCrossDisolve,
    
    /**
     The alert chooses its presentation and dismissal styles automatically.
     */
    VSAlertControllerAnimationStyleAutomatic
    
};

@class VSAlertController;

/**
 VSAlertControllerDelegate is a protocol used to inform an object about user intractions with alerts
 */
@protocol VSAlertControllerDelegate <NSObject>

@optional

/**
 Sent to the delegate just before the view controller appears.

 @param alertController The alert controller
 */
- (void)alertControllerWillAppear:(nonnull VSAlertController *)alertController;

/**
 Sent to teh delegate just after the view controller appears.

 @param alertController The alert controller
 */
- (void)alertControllerDidAppear:(nonnull VSAlertController *)alertController;

/**
 Sent to the delegate just before the view controller disappears.

 @param alertController The alert controller
 */
- (void)alertControllerWillDisappear:(nonnull VSAlertController *)alertController;

/**
 Sent to teh delegate just after the view controller disappears.

 @param alertController The alert controller
 */
- (void)alertControllerDidDisappear:(nonnull VSAlertController *)alertController;

/**
 Sent to the delegate when the user taps on an action. Message is sent *before* the action block is executed.

 @param alertController The alert controller that houses the action.
 @param action The action that was interacted with.
 */
- (void)alertController:(nonnull VSAlertController *)alertController didSelectAction:(nonnull VSAlertAction *)action;

@end

/**
 VSAlertController is a drop-in replacement for UIAlertController with more features. It is created using the `+alertControllerWithTitle:message:image:style:` class method, and configured using instances of VSAlertAction. You can add text fields by calling `-addTextField:` on an instance of VSAlertController. Instantiate the controller, add your actions and textfieds. and any other configuration you might need. Present the controller modally using UIViewController's `-presentViewController:animated:completion:` method. VSAlertController respects the animation paramater of this call, and you configure the animation in question by setting your instances animationStyle property before presentation. You can also change this property in the handler of an action to use a different animation on dismissal.
 */
@interface VSAlertController : UIViewController<UIAppearance>

/**
 @name Creating Alerts
 */

/**
 A factory method to create an instance of VSAlertController. This is the preffered way to instantiate alerts

 @param title The title of the alert
 @param message The message of the alert
 @param image The image to be displayed in the header of the alert.
 @param preferredStyle The style of the alert
 @return The instantiated alert object
 */
+ (nullable instancetype)alertControllerWithTitle:(nullable NSString *)title message:(nullable NSString *)message image:(nullable UIImage *)image preferredStyle:(VSAlertControllerStyle)preferredStyle;


/**
 A factory method to create an instance of VSAlertController.

 @param title The title of the alert
 @param message The message of the alert
 @param preferredStyle The style of the alert
 @return The instantiated alert object
 */
+ (nullable instancetype)alertControllerWithTitle:(nullable NSString *)title message:(nullable NSString *)message preferredStyle:(VSAlertControllerStyle)preferredStyle;

/** Create an instance of VSAlertController
 
 @param title The title of the alert
 @param message The message of the alert
 @param image The image to be displayed in the header of the alert.
 @param preferredStyle The style of the alert
 @return The instantiated alert object
 */
- (nullable instancetype)initWithTitle:(nullable NSString *)title message:(nullable NSString *)message image:(nullable UIImage *)image preferredStyle:(VSAlertControllerStyle)preferredStyle NS_DESIGNATED_INITIALIZER;

/**
 @name Configuring Alert Appearance
 */

/**
 The color of the alert title. The default value is black.
 */
@property (NS_NONATOMIC_IOSONLY, strong, nonnull) UIColor *alertTitleTextColor UI_APPEARANCE_SELECTOR;

/**
 The color of the alert message (description). The default value is black.
 */
@property (NS_NONATOMIC_IOSONLY, strong, nonnull) UIColor *alertMessageTextColor UI_APPEARANCE_SELECTOR;

/**
 The font of the alert title. The default value is the system font size 17 weight medium.
 */
@property (NS_NONATOMIC_IOSONLY, strong, nonnull) UIFont *alertTitleTextFont UI_APPEARANCE_SELECTOR;

/**
 The font of the alert message (description). The default value is the system font size 15 weight regular.
 */
@property (NS_NONATOMIC_IOSONLY, strong, nonnull) UIFont *alertMessageTextFont UI_APPEARANCE_SELECTOR;

/**
 The text alignment of the alert message
 */
@property (NS_NONATOMIC_IOSONLY, assign) NSTextAlignment alertMessageTextAlignment;

/**
 The background color of the alert
 */
@property (NS_NONATOMIC_IOSONLY, strong, nonnull) UIColor *alertBackgroundColor UI_APPEARANCE_SELECTOR;

/**
 @name Configuring Interactive Alert Content
 */

/**
 Add an action to an alert

 @param alertAction The action to add to the alert.
 */
- (void)addAction:(nonnull VSAlertAction *)alertAction;

/**
 Add a text field to the alert. Rather than instantiating a UITextField object yourself, VSAlertController instantiates one for you. You can configure it using the optional configuration block

 @param configuration The block used to configure the text field.
 */
- (void)addTextField:(void (^_Nullable)(UITextField * _Nonnull textField))configuration;

/**
 @name Configure Alert Behavior
 */

/**
 Set to YES if you want the alert to dismiss itself when the user taps on the background of the alert. Default is NO.
 */
@property (NS_NONATOMIC_IOSONLY, assign, getter=shouldDismissOnBackgroundTap) BOOL dismissOnBackgroundTap;

/**
 Change the animation used when the alert is presented AND dismissed. Default is VSAlertControllerAnimationStyleRise.
 */
@property (NS_NONATOMIC_IOSONLY, assign) VSAlertControllerAnimationStyle animationStyle;

/**
 @name Interacting with Alerts
 */

/**
 The delegate object to handle alert action interactions
 */
@property (weak, nullable) id<VSAlertControllerDelegate> delegate;

/**
 Returns the array of text field objects that are displayed in the alert, so you can interact with the user's inputs.
 */
@property (NS_NONATOMIC_IOSONLY, strong, readonly, nonnull) NSArray<UITextField *> *textFields;

/**
 The style of the alert
 */
@property (NS_NONATOMIC_IOSONLY, assign, readonly) VSAlertControllerStyle style;

/**
 The message of the alert
 */
@property (NS_NONATOMIC_IOSONLY, copy, readonly, nonnull) NSString *message;

/**
 The image of the alert
 */
@property (NS_NONATOMIC_IOSONLY, strong, readonly, nullable) UIImage *image;

@end
