//
//  VSAlertAction.h
//  VSAlertController
//
//  Created by Varun Santhanam on 10/8/17.
//

@import UIKit;

/**
 An enuration for the various UI styles of VSAlertAction

 - VSAlertActionStyleDefault: Standard action UI
 - VSAlertActionStyleCancel: Slightly bolder action UI, use for actions that will "cancel"
 - VSAlertActionStyleDestructive: Red action UI, use for actions that will break or ireversably cahgne something
 */
typedef NS_ENUM(NSInteger, VSAlertActionStyle) {
    
    /**
     Standard action UI
     */
    VSAlertActionStyleDefault,
    
    /**
     Slightly bolder action UI, use for actions that will "cancel"
     */
    VSAlertActionStyleCancel,
    
    /**
     Red action UI, use for actions that will break or ireversably cahgne something
     */
    VSAlertActionStyleDestructive
    
};

/**
 VSAlertAction is a specialized subclass used to configure a VSAlertController.
 */
@interface VSAlertAction : UIButton

/**
 The font used by alert actions that are not styled as "cancel". If none is provided, the system font at regular weight and size 17.0f is used. (Class property, applies to all instances created after change)
 */
@property (class, strong, nullable) UIFont *actionTitleTextFont;

/**
 The font used by alert actions that are styled as "cancel". If none is provided, the system font at semibold weight and size 17.0f is used. (Class property, applies to all instances created after change)
 */
@property (class, strong, nullable) UIFont *cancelActionTitleTextFont;

/**
 The text color used by alert actinos that are not styled as "destructive". If none is provided, UIColor's `+redColor` is used. (Class property, applies to all instances created after change).
 */
@property (class, strong, nullable) UIColor *actionTextColor;

/**
 The text color used by alert actions that are not styled as "destructive". If none is provided, the button's `.tintColor` is used.
 */
@property (class, strong, nullable) UIColor *destructiveActionTextColor;

/**
 The block to be executed when the action is selected by the user
 */
@property (NS_NONATOMIC_IOSONLY, copy, nullable) void (^action)(VSAlertAction * _Nonnull action);

/**
 The the UI style of the action
 */
@property (NS_NONATOMIC_IOSONLY, assign, readonly) VSAlertActionStyle style;

/**
 Factory method to create an alert action

 @param title Title of the action
 @param style The style of the action
 @param action The block to be executed when the user taps on an action
 @return The action
 */
+ (nullable instancetype)alertActionWithTitle:(nonnull NSString *)title style:(VSAlertActionStyle)style action:(void (^_Nullable)(VSAlertAction * _Nonnull action))action;

/**
 Reset class property customization to its default settings
 */
+ (void)resetStyleToDefaults;

/**
 Create an action

 @param title Title of the action
 @param style The style of the action
 @param action The block to be executed when the user taps on an action
 @return The action
 */
- (nullable instancetype)initWithTitle:(nonnull NSString *)title style:(VSAlertActionStyle)style action:(void (^_Nullable)(VSAlertAction *_Nonnull))action NS_DESIGNATED_INITIALIZER;

@end
