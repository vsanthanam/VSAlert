//
//  VSAlertAction.h
//  VSAlertController
//
//  Created by Varun Santhanam on 10/8/17.
//

@import UIKit;

typedef NS_ENUM(NSInteger, VSAlertActionStyle) {
    
    VSAlertActionStyleDefault,
    VSAlertActionStyleCancel,
    VSAlertActionStyleDestructive
    
};

@interface VSAlertAction : UIButton

@property (NS_NONATOMIC_IOSONLY, copy, nullable) void (^action)(VSAlertAction * _Nonnull action);
@property (NS_NONATOMIC_IOSONLY, assign, readonly) VSAlertActionStyle style;

+ (nullable instancetype)alertActionWithTitle:(nonnull NSString *)title style:(VSAlertActionStyle)style action:(void (^_Nullable)(VSAlertAction * _Nonnull action))action;

- (nullable instancetype)initWithTitle:(nonnull NSString *)title style:(VSAlertActionStyle)style action:(void (^_Nullable)(VSAlertAction *_Nonnull))action;


@end
