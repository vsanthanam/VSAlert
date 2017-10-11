//
//  VSAlertControllerTransition.h
//  VSAlertController
//
//  Created by Varun Santhanam on 10/9/17.
//

@import UIKit;

#import "VSAlertController.h"

extern NSString * _Nonnull const VSAlertControllerTransitionAnimatorNotImplementedException;
extern NSString * _Nonnull const VSAlertControllerTransitionAnimatorInvalidUsageException;

@interface VSAlertControllerTransitionAnimator : NSObject<UIViewControllerAnimatedTransitioning>

- (nullable instancetype)initWithActionStyle:(VSAlertActionStyle)actionStyle NS_DESIGNATED_INITIALIZER;

@end
