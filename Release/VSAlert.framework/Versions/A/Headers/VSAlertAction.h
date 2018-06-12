//
//  VSAlertAction.h
//  VSAlertController
//
//  Created by Varun Santhanam on 10/8/17.
//

@import UIKit;

/**
 An enumeration for the kinds of actions that can be created

 - VSAlertActionStyleDefault: A normal action
 - VSAlertActionStyleCancel: An action that indicates to the user that the current process wil be cancelled
 - VSAlertActionStyleDestructive: An action indicates to the user that an irreversible process is about to happen.
 */
typedef NS_ENUM(NSInteger, VSAlertActionStyle) {
    
    /**
     A normal action
     */
    VSAlertActionStyleDefault,
    
    /**
     An action that indicates to the user that the current process wil be cancelled
     */
    VSAlertActionStyleCancel,
    
    /**
     An action indicates to the user that an irreversible process is about to happen.
     */
    VSAlertActionStyleDestructive
    
};

/**
 VSAlertAction is a specialized subclass of UIButton that is used to populate and provide interactive controls to an instance of VSAlertController.
 */
@interface VSAlertAction : UIButton<UIAppearance>

/**
 @name Creating Actions
 */

/**
 A factory method to create an instance of UIAlertAction. This is the prefered way to create alert actions.

 @param title The title of the action
 @param style The style of the action
 @param action The block to be executed when the user interacts with the action, but before the alert is dismissed
 @return The instantiaed action
 */
+ (nullable instancetype)alertActionWithTitle:(nonnull NSString *)title style:(VSAlertActionStyle)style action:(void (^_Nullable)(VSAlertAction * _Nonnull action))action;

/**
 Create an instance of UIAlertAction

 @param title The title of the action
 @param style The style of the action
 @param action The block to be executed when the user interacts with the action, but before the alert is dismissed
 @return The instantiaed action
 */
- (nullable instancetype)initWithTitle:(nonnull NSString *)title style:(VSAlertActionStyle)style action:(void (^_Nullable)(VSAlertAction *_Nonnull))action NS_DESIGNATED_INITIALIZER;

/**
 @name Configuring Action Appearance
 */

/**
 The color of the title text used in non-desctructive actions
 */
@property (NS_NONATOMIC_IOSONLY, strong, nonnull) UIColor *actionTextColor UI_APPEARANCE_SELECTOR;

/**
 The color of the title text used in destructive actions
 */
@property (NS_NONATOMIC_IOSONLY, strong, nonnull) UIColor *destructiveActionTextColor UI_APPEARANCE_SELECTOR;

/**
 The font of the title used in non-cancel actions
 */
@property (NS_NONATOMIC_IOSONLY, strong, nonnull) UIFont *actionTextFont UI_APPEARANCE_SELECTOR;

/**
 The font of the title used in cancel actions
 */
@property (NS_NONATOMIC_IOSONLY, strong, nonnull) UIFont *cancelActionTextFont UI_APPEARANCE_SELECTOR;

/**
 @name Interacting with Actions
 */

/**
 The title of the alert
 */
@property (NS_NONATOMIC_IOSONLY, copy, readonly, nullable) NSString *alertTitle;

/**
 The display style of the alert
 */
@property (NS_NONATOMIC_IOSONLY, assign, readonly) VSAlertActionStyle style;

/**
 The block that will be executed when the user interacts with the action. The block is called on the main thread always, and begins executed before the alert is dismissed
 */
@property (NS_NONATOMIC_IOSONLY, copy, readonly, nullable) void (^action)(VSAlertAction * _Nonnull action);

@end
