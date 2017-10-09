//
//  VSAlertController.h
//  VSAlertController
//
//  Created by Varun Santhanam on 10/8/17.
//

@import UIKit;

#import "VSAlertAction.h"
/**
 An exception thrown when an unimplemented feature is used at runtime.
 */
extern NSString * _Nonnull const VSAlertControllerNotImplementedException;

/**
 An exceptino thrown when a textfield is added in an alertcontroller style which doesn't support text fields
 */
extern NSString * _Nonnull const VSAlertControllerTextFieldInvalidException;

/**
 An enuration for the various UI styles of VSAlertController

 - VSAlertControllerStyleAlert: A pop up alert that displays at 270px wide (like Apple's UIAlertController)
 - VSAlertControllerStyleWalkthroughAlert: A wider popup that stretches it's to fit the width of the device (minus some padding)
 - VSAlertControllerStyleActionSheet: A bottom of the screen alert (NOT IMPLEMENTED)
 */
typedef NS_ENUM(NSInteger, VSAlertControllerStyle) {

    /**
     A pop up alert that displays at 270px wide (like Apple's UIAlertController)
     */
    VSAlertControllerStyleAlert,
    
    /**
     A wider popup that stretches it's to fit the width of the device (minus some padding)
     */
    VSAlertControllerStyleWalkthroughAlert,
    
    /**
     A bottom of the screen alert, similar to Apple's Action sheet style
     */
    VSAlertControllerStyleActionSheet
    
};

/**
 VSAlertController is a drop-in replacement for UIAlertController with a bit more customization and better looks. It's largely based on Codeido's PMAlertController, but has been re-written in Objective-C rather than Swift, and supports a few more features like dynamically sorted alert actions and a "destructive" action style that was missing in PMAlertController. It doesn't requrie a separate XIB file for better potability, and uses the system font by default for a more vanilla look. VSAlertController can can be customized at the class level, so you can make any/all UI changes once.
 */
@interface VSAlertController : UIViewController

/**
 @name Class Properties
 */

/**
The color of the title text used by alert controllers. The default value is nil. If nil is specified when an alert controller is displayed, VSAlertController.textColor's value is used instead. (Class property, applies to all instances created after change)
*/
@property (class, strong, nullable) UIColor *titleTextColor;

/**
 The color of the text used by alert controllers. (Class property, applies to all instances created after change)
 */
@property (class, strong, nonnull) UIColor *textColor;

/**
 The font of the title used by alert controllers. The default value is the system font at size 17.0f. (Class property, applies to all instances created after change)
 */
@property (class, strong, nonnull) UIFont *titleTextFont;

/**
 The font of the text used by alert controllers. The default value is the the system font at size 15.0f (Class property, applies to all instances created after change)
 */
@property (class, strong, nonnull) UIFont *textFont;

/**
 @name Instance Properties
 */

/**
 An array of UITextFields visible on the alert
 */
@property (NS_NONATOMIC_IOSONLY, strong, readonly, nonnull) NSArray<UITextField *> *textFields;


/**
 The background view of the alert. It's default image is set to nil, and its default background color is set to #FFFFFF with an alpha component of 0.5. You can change it's background color or assign an image if you prefer an different background for your alert.
 */
@property (NS_NONATOMIC_IOSONLY, strong, readonly, nonnull) UIImageView *alertMaskBackground;

/**
 @name Class Methods
 */

/**
 A factory method to create a new alert. The alert is dynamically sized based on your initialization paramaters

 @param title The title of the alert.
 @param description The message or body of the alert.
 @param image The image to show on the alert, if any. See the provided image template for details.
 @param style The UI style of the alert
 @return The initialized alert controller.
 */
+ (nullable instancetype)alertControllerWithTitle:(nullable NSString *)title description:(nullable NSString *)description image:(nullable UIImage *)image style:(VSAlertControllerStyle)style;

/**
 Reset class property customization to its default settings
 */
+ (void)resetStyleToDefaults;

/**
 @name Instance Methods
 */

/**
 Create a new alert controller

 @param title The title of the alert.
 @param description The message or body of the alert.
 @param image The image to show on the alert, if any. See the provided image template for details.
 @param style The UI style of the alert
 @return The initialized alert controller.
 */
- (nullable instancetype)initWithTitle:(nullable NSString *)title description:(nullable NSString *)description image:(nullable UIImage *)image style:(VSAlertControllerStyle)style;

/**
 Add an action to the alert controller. See VSAlertAction's documentation for more information

 @param alertAction The action to add to the controller
 */
- (void)addAction:(nonnull VSAlertAction *)alertAction;

/**
 Add a text field to the alert controller. Rather than instantiating the UITextField yourself, use the configuration block (which provides you an already initialized UITextField, and make your customizations there. Unlike in PMAlertController, you can re-assign the the UITextField's delegate property -- VSAlertController does not make use of UITextField to infer when to dismiss and show the keyboard.

 @param configuration the block used to configure or style the textfield
 */
- (void)addTextField:(void (^_Nullable)(UITextField * _Nonnull textField))configuration;

@end
