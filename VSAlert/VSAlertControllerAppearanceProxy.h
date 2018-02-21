//
//  VSAlertControllerAppearanceProxy.h
//  VSAlert
//
//  Created by Varun Santhanam on 10/12/17.
//

@import UIKit;

/**
 VSAlertControllerAppearanceProxy is a class used to support the UIAppearance protocol in VSAlertController, because VSAlertController does not inherit from an object that includes this support. This classes interface is described in a project header, and thus does not appear in the library documentation.
 */
@interface VSAlertControllerAppearanceProxy : UIView<UIAppearance>

/**
 The color of the alert's title
 */
@property (NS_NONATOMIC_IOSONLY, strong, nonnull) UIColor *alertTitleTextColor UI_APPEARANCE_SELECTOR;

/**
 The color of the alert's message
 */
@property (NS_NONATOMIC_IOSONLY, strong, nonnull) UIColor *alertMessageTextColor UI_APPEARANCE_SELECTOR;

/**
 The font of the alert's title
 */
@property (NS_NONATOMIC_IOSONLY, strong, nonnull) UIFont *alertTitleTextFont UI_APPEARANCE_SELECTOR;

/**
 The font of the aler's message
 */
@property (NS_NONATOMIC_IOSONLY, strong, nonnull) UIFont *alertMessageTextFont UI_APPEARANCE_SELECTOR;

@end
