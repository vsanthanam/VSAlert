//
//  VSAlertControllerTransition.m
//  VSAlertController
//
//  Created by Varun Santhanam on 10/9/17.
//

#import "VSAlertControllerTransitionAnimator.h"

#import "VSAlertController.h"

NSString * const VSAlertControllerTransitionAnimatorNotImplementedException = @"VSAlertControllerTransitionAnimatorNotImplementedException";
NSString * const VSAlertControllerTransitionAnimatorInvalidUsageException = @"VSAlertControllerTransitionAnimatorInvalidUsageException";

@interface VSAlertControllerTransitionAnimator ()

@property (NS_NONATOMIC_IOSONLY, weak) id<UIViewControllerContextTransitioning> transitionContext;

@end

@implementation VSAlertControllerTransitionAnimator

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIViewController *toController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    if (toController.isBeingPresented) {
        
        if (![toController isKindOfClass:[VSAlertController class]]) {
            
            // VSAlertControllerTransitinAnimator can only be used to present or dismiss VSAlertController objects
            [transitionContext completeTransition:NO];
            
            // Throw Exception
            [NSException raise:VSAlertControllerTransitionAnimatorInvalidUsageException format:@"VSAlertControllerTransitionAnimator can only be used with VSAlertController objects"];
            
            return;
            
        }
        
        if (!transitionContext.animated) {
         
            // No animation needed, dismiss immediately
            [transitionContext.containerView addSubview:toController.view];
            [transitionContext completeTransition:YES];

        } else {
         
            // Find AlertController
            VSAlertController *alertController = (VSAlertController *)toController;
            
            // Create Shadow
            UIView *shadowView = [[UIView alloc] initWithFrame:transitionContext.containerView.frame];
            shadowView.layer.backgroundColor = [UIColor clearColor].CGColor;
            [transitionContext.containerView addSubview:shadowView];
            
            if (alertController.animationStyle == VSAlertControllerAnimationStyleRise || alertController.animationStyle == VSAlertControllerAnimationStyleFall) {
            
                // Rise & Fall Animations
                
                CGFloat dy = alertController.animationStyle == VSAlertControllerAnimationStyleRise ? fromController.view.frame.size.height : -1.0f * fromController.view.frame.size.height;
                
                CGRect initialFrame = CGRectOffset(fromController.view.frame, 0.0f, dy);
                
                alertController.view.frame = initialFrame;
                
                [transitionContext.containerView addSubview:alertController.view];
                
                [UIView animateWithDuration:[self transitionDuration:transitionContext]
                                 animations:^{
                                     
                                     alertController.view.frame = fromController.view.frame;
                                     shadowView.layer.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5f].CGColor;
                                     
                                 }
                                 completion:^(BOOL finished) {
                                     
                                     [transitionContext completeTransition:finished];
                                     
                                 }];
                
            } else if (alertController.animationStyle == VSAlertControllerAnimationStyleSlide) {
                
                // Slide From Left Animation
                
                CGRect initialFrame = CGRectOffset(fromController.view.frame, - 1.0f * fromController.view.frame.size.width, 0.0f);
                
                alertController.view.frame = initialFrame;
                
                [transitionContext.containerView addSubview:alertController.view];
                
                [UIView animateWithDuration:[self transitionDuration:transitionContext]
                                 animations:^{
                                    
                                     alertController.view.frame = fromController.view.frame;
                                     shadowView.layer.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5f].CGColor;
                                     
                                 }
                                 completion:^(BOOL finished) {
                                     

                                     [transitionContext completeTransition:finished];
                                     
                                 }];
                
            } else if (alertController.animationStyle == VSAlertControllerAnimationStyleFlip) {
                
                // Flip Animation
                
                alertController.view.alpha = 0.0f;
                [transitionContext.containerView addSubview:alertController.view];
                
                NSTimeInterval flipDuration = [self transitionDuration:transitionContext] - 0.1f;
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                   
                        [UIView transitionWithView:alertController.view
                                          duration:flipDuration
                                           options:UIViewAnimationOptionTransitionFlipFromLeft
                                        animations:^{
                                            
                                            shadowView.layer.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5f].CGColor;
                                            alertController.view.alpha = 1.0f;
                                            
                                        }
                                        completion:^(BOOL finished) {
                                            
                                            [transitionContext completeTransition:finished];
                                            
                                        }];
                        
                    });
                    
                });
                
            } else {
                
                [transitionContext completeTransition:NO];
                
                [NSException raise:VSAlertControllerTransitionAnimatorNotImplementedException format:@"Present animation style not yet implemented"];
                
            }

        }
        
    } else if (fromController.isBeingDismissed) {

        if (![fromController isKindOfClass:[VSAlertController class]]) {
            
            // VSAlertControllerTransitinAnimator can only be used to present or dismiss VSAlertController objects
            [transitionContext completeTransition:NO];
            
            // Throw Exception
            [NSException raise:VSAlertControllerTransitionAnimatorInvalidUsageException format:@"VSalertControllerTransitionAnimator can only be used with VSAlertController objects"];
            
            return;
            
        }
        
        if (!transitionContext.animated) {
            
            [fromController.view removeFromSuperview];
            [transitionContext completeTransition:YES];
            
            return;
            
        } else {
         
            // Find Alert Controller
            VSAlertController *alertController = (VSAlertController *)fromController;
            
            // Find Shadow
            UIView *shadowView = transitionContext.containerView.subviews[0];
            
            if (alertController.animationStyle == VSAlertControllerAnimationStyleRise || alertController.animationStyle == VSAlertControllerAnimationStyleFall) {
            
                // Fall & Rise Animation
                
                CGFloat dy = alertController.animationStyle == VSAlertControllerAnimationStyleRise ? toController.view.frame.size.height : -1.0f * toController.view.frame.size.height;
                
                CGRect destinationFrame = CGRectOffset(toController.view.frame, 0.0f, dy);
                [UIView animateWithDuration:[self transitionDuration:transitionContext]
                                 animations:^{
                                     
                                     shadowView.layer.backgroundColor = [UIColor clearColor].CGColor;
                                     alertController.view.frame = destinationFrame;
                                     
                                 }
                                 completion:^(BOOL finished) {
                                     
                                     [alertController.view removeFromSuperview];
                                     [shadowView removeFromSuperview];
                                     [transitionContext completeTransition:finished];
                                     
                                 }];
                
            } else if (alertController.animationStyle == VSAlertControllerAnimationStyleSlide) {
                
                // Slide To Right Animation
                
                CGRect destinationFrame = CGRectOffset(toController.view.frame, toController.view.frame.size.width, 0.0f);
                
                [UIView animateWithDuration:[self transitionDuration:transitionContext]
                                 animations:^{
                                 
                                     shadowView.layer.backgroundColor = [UIColor clearColor].CGColor;
                                     alertController.view.frame = destinationFrame;
                                     
                                 }
                                 completion:^(BOOL finished) {
                                    
                                     [alertController.view removeFromSuperview];
                                     [shadowView removeFromSuperview];
                                     [transitionContext completeTransition:finished];
                                     
                                 }];
                
            } else if (alertController.animationStyle == VSAlertControllerAnimationStyleFlip) {
            
                // Flip Animation
                
                [UIView transitionWithView:alertController.view
                                  duration:[self transitionDuration:transitionContext]
                                   options:UIViewAnimationOptionTransitionFlipFromRight
                                animations:^{
                                
                                    alertController.view.alpha = 0.0f;
                                    shadowView.layer.backgroundColor = [UIColor clearColor].CGColor;
                                    
                                }
                                completion:^(BOOL finished) {
                                   
                                    [alertController.view removeFromSuperview];
                                    [shadowView removeFromSuperview];
                                    [transitionContext completeTransition:finished];
                                    
                                }];
                
            } else {
                
                [transitionContext completeTransition:NO];
                
                [NSException raise:VSAlertControllerTransitionAnimatorNotImplementedException format:@"Dismiss animation style not yet implemented"];
                
            }
            
        }
        
    }
    
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIViewController *toController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    VSAlertController *controller;
    
    if (toController.isBeingPresented) {
        
        controller = (VSAlertController *)toController;
        
        if (controller.animationStyle == VSAlertControllerAnimationStyleFlip) {
            
            return 0.5f;
            
        }
        
        return 0.3f;
        
    } else if (fromController.isBeingDismissed) {
        
        controller = (VSAlertController *)fromController;
        
        if (controller.animationStyle == VSAlertControllerAnimationStyleFlip) {
            
            return 0.4f;
            
        }
        
        return 0.3f;
        
    }
    
    return 0.0f;
               
               
}

@end
