//
//  VSAlertController.h
//  VSAlertController
//
//  Created by Varun Santhanam on 10/8/17.
//

@import UIKit;

#import "VSAlertAction.h"

extern NSString * _Nonnull const VSAlertControllerNotImplementedException;
extern NSString * _Nonnull const VSAlertControllerTextFieldInvalidException;

typedef NS_ENUM(NSInteger, VSAlertControllerStyle) {

    VSAlertControllerStyleAlert,
    VSAlertControllerStyleWalkthroughAlert,
    VSAlertControllerStyleActionSheet
    
};


typedef NS_ENUM(NSInteger, VSAlertControllerAnimationStyle) {
    
    VSAlertControllerAnimationStyleRise,
    VSAlertControllerAnimationStyleFall,
    VSAlertControllerAnimationStyleSlide,
    VSAlertControllerAnimationStyleFlip
    
};


@interface VSAlertController : UIViewController

@property (class, strong, nullable) UIColor *titleTextColor;
@property (class, strong, nonnull) UIColor *textColor;
@property (class, strong, nonnull) UIFont *titleTextFont;
@property (class, strong, nonnull) UIFont *textFont;

@property (NS_NONATOMIC_IOSONLY, strong, readonly, nonnull) NSArray<UITextField *> *textFields;
@property (NS_NONATOMIC_IOSONLY, assign, getter=shouldDismissOnBackgroundTap) BOOL dismissOnBackgroundTap;
@property (NS_NONATOMIC_IOSONLY, assign) VSAlertControllerAnimationStyle animationStyle;

+ (nullable instancetype)alertControllerWithTitle:(nullable NSString *)title description:(nullable NSString *)description image:(nullable UIImage *)image style:(VSAlertControllerStyle)style;

+ (void)resetStyleToDefaults;


- (nullable instancetype)initWithTitle:(nullable NSString *)title description:(nullable NSString *)description image:(nullable UIImage *)image style:(VSAlertControllerStyle)style NS_DESIGNATED_INITIALIZER;

- (void)addAction:(nonnull VSAlertAction *)alertAction;
- (void)addTextField:(void (^_Nullable)(UITextField * _Nonnull textField))configuration;

@end
