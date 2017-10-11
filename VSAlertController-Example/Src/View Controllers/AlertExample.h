//
//  AlertExample.h
//  VSAlertController-Example
//
//  Created by Varun Santhanam on 10/11/17.
//

@import UIKit;

#import "VSAlertController.h"

typedef NS_ENUM(NSInteger, AlertExampleType) {
    
    AlertExampleTypeBasic
    
};

@interface AlertExample : NSObject

@property (NS_NONATOMIC_IOSONLY, assign) VSAlertControllerAnimationStyle animationStyle;
@property (NS_NONATOMIC_IOSONLY, strong, nonnull) NSArray<NSNumber *> *examples;

+ (nullable instancetype)sharedExample;

- (nullable NSString *)exampleNameForExampleType:(AlertExampleType)exampleType;
- (void)presentAlertForExampleType:(AlertExampleType)exampleType onViewController:(nonnull UIViewController *)viewController;

@end
