//
//  VSAlertControllerTransition.h
//  VSAlertController
//
//  Created by Varun Santhanam on 10/9/17.
//

@import UIKit;

extern NSString * _Nonnull const VSAlertControllerTransitionAnimatorNotImplementedException;
extern NSString * _Nonnull const VSAlertControllerTransitionAnimatorInvalidUsageException;

/**
 Project Header class -- not exposed in static framework. Used to handle custom modal transitions
 */
@interface VSAlertControllerTransitionAnimator : NSObject<UIViewControllerAnimatedTransitioning>

@end
