//
//  VSAlertController.h
//  VSAlertController
//
//  Created by Varun Santhanam on 10/8/17.
//

@import UIKit;

#import "VSAlertAction.h"

extern NSString * _Nonnull const VSAlertActionNotImplementedException;

typedef NS_ENUM(NSInteger, VSAlertControllerStyle) {
  
    VSAlertControllerStyleAlert,
    VSAlertControllerStyleWalkthroughAlert,
    VSAlertControllerStyleActionSheet
    
};

@interface VSAlertController : UIViewController

@property (NS_NONATOMIC_IOSONLY, strong, readonly, nonnull) NSArray<UITextField *> *textFields;

+ (nullable instancetype)alertControllerWithTitle:(nullable NSString *)title description:(nullable NSString *)description image:(nullable UIImage *)image style:(VSAlertControllerStyle)style;

- (nullable instancetype)initWithTitle:(nullable NSString *)title description:(nullable NSString *)description image:(nullable UIImage *)image style:(VSAlertControllerStyle)style;

- (void)addAction:(nonnull VSAlertAction *)alertAction;
- (void)addTextField:(void (^_Nullable)(UITextField * _Nonnull textField))configuration;

@end
