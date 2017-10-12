//
//  VSAlertControllerTransition.h
//  VSAlertController
//
//  Created by Varun Santhanam on 10/9/17.
//

@import UIKit;

#import "VSAlertController.h"
/**
 Exception thrown when a transition that has yet to be implemented is triggered at runtime.
 */
extern NSString * _Nonnull const VSAlertControllerTransitionAnimatorNotImplementedException;

/**
 An exception thrown when a transition that doesn't work for a given controller is triggered at runttime
 */
extern NSString * _Nonnull const VSAlertControllerTransitionAnimatorInvalidUsageException;

/**
 VSAlertControllerTransitionAnimator is a class used to manage modal transitions to and from VSAlertController objects. The class's interface is described in a project header, and thus does not appear in the library's documentation/
 */
@interface VSAlertControllerTransitionAnimator : NSObject<UIViewControllerAnimatedTransitioning>

/**
 Create a transition animator

 @param actionStyle The style of the action that trigged the animation, during dismissal transitions
 @return The instantiated animator object.
 */
- (nullable instancetype)initWithActionStyle:(VSAlertActionStyle)actionStyle NS_DESIGNATED_INITIALIZER;

@end
