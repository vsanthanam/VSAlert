//
//  AlertExample.h
//  VSAlertController-Example
//
//  Created by Varun Santhanam on 10/11/17.
//

@import UIKit;

#import "VSAlertController.h"

typedef NS_ENUM(NSInteger, AlertExampleType) {
    
    AlertExampleTypeBasic,
    AlertExampleTypeCancel,
    AlertExampleTypeDestructive,
    AlertExampleTypeMultiChoice,
    AlertExampleTypeTextField1,
    AlertExampleTypeTextField2,
    AlertExampleTypeImage,
    AlertExampleTypeStyled,
    AlertExampleTypeWalkthroughBasic,
    AlertExampleTypeWalkthroughCancel,
    AlertExampleTypeWalkthroughDestructive,
    AlertExampleTypeWalkthroughMultiChoice,
    AlertExampleTypeWalkthroughTextField1,
    AlertExampleTypeWalkthroughTextField2,
    AlertExampleTypeWalkthroughImage,
    AlertExampleTypeWalkthroughStyled,
    AlertExampleTypeActionSheetBasic,
    AlertExampleTypeActionSheetCancel,
    AlertExampleTypeActionSheetDestructive,
    AlertExampleTypeActionSheetMultiChoice,
    AlertExampleTypeActionSheetImage,
    AlertExampleTypeActionSheetStyled,
    
};

@interface AlertExample : NSObject

@property (NS_NONATOMIC_IOSONLY, assign) VSAlertControllerAnimationStyle animationStyle;
@property (NS_NONATOMIC_IOSONLY, assign, getter=shouldDismissOnBackgroundTap) BOOL dismissOnBackgroundTap;

@property (NS_NONATOMIC_IOSONLY, strong, nonnull) NSArray<NSNumber *> *alertExamples;
@property (NS_NONATOMIC_IOSONLY, strong, nonnull) NSArray<NSNumber *> *walkthroughExamples;
@property (NS_NONATOMIC_IOSONLY, strong, nonnull) NSArray<NSNumber *> *actionSheetExamples;

+ (nullable instancetype)sharedExample;

- (nullable NSString *)exampleNameForExampleType:(AlertExampleType)exampleType;
- (void)presentAlertForExampleType:(AlertExampleType)exampleType onViewController:(nonnull UIViewController *)viewController;

@end
