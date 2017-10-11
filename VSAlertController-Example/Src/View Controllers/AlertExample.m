//
//  AlertExample.m
//  VSAlertController-Example
//
//  Created by Varun Santhanam on 10/11/17.
//

#import "AlertExample.h"

@implementation AlertExample

@synthesize animationStyle = _animationStyle;

+ (instancetype)sharedExample {
    
    static AlertExample *alertExample;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        alertExample = [[self alloc] init];
        
    });
    
    return alertExample;
    
}

- (instancetype)init {
    
    self = [super init];
    
    if (self) {
        
        self.animationStyle = VSAlertControllerAnimationStyleAutomatic;
        
    }
    
    return self;
    
}

- (NSArray<NSNumber *> *)examples {
    
    return @[@(AlertExampleTypeBasic)];
    
}

- (NSString *)exampleNameForExampleType:(AlertExampleType)exampleType {
    
    if (exampleType == AlertExampleTypeBasic) {
        
        return NSLocalizedString(@"Basic", nil);
        
    }
    
    return nil;
    
}

- (void)presentAlertForExampleType:(AlertExampleType)exampleType onViewController:(UIViewController *)viewController {
    
    VSAlertController *controller;
    
    if (exampleType == AlertExampleTypeBasic) {
        
        controller = [VSAlertController alertControllerWithTitle:NSLocalizedString(@"Running Low On Supplied", nil)
                                                     description:NSLocalizedString(@"Please you're going to have to refil soon or you'll be totally out.", nil)
                                                           image:nil
                                                           style:VSAlertControllerStyleAlert];
        VSAlertAction *action = [VSAlertAction alertActionWithTitle:NSLocalizedString(@"Close", nil)
                                                              style:VSAlertActionStyleDefault
                                                             action:nil];
        [controller addAction:action];
        
    }
    
    controller.animationStyle = self.animationStyle;
    
    [viewController presentViewController:controller
                                 animated:YES
                               completion:nil];
    
}

@end
