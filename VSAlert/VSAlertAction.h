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
 Create an action

 @param title Title of the action
 @param style The style of the action
 @param action The block to be executed when the user taps on an action
 @return The action
 */
- (nullable instancetype)initWithTitle:(nonnull NSString *)title style:(VSAlertActionStyle)style action:(void (^_Nullable)(VSAlertAction *_Nonnull))action;


@end
