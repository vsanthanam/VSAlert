//
//  AlertExample.m
//  VSAlertController-Example
//
//  Created by Varun Santhanam on 10/11/17.
//

#import <os/log.h>

#import "AlertExample.h"

@implementation AlertExample

@synthesize animationStyle = _animationStyle;
@synthesize dismissOnBackgroundTap = _dismissOnBackgroundTap;

static os_log_t example_alert;

+ (void)initialize {
    
    example_alert = os_log_create("com.varunsanthanam.VSAlertController-Example", "AlertExample");
    
}

#pragma mark - Public Class Methods

+ (instancetype)sharedExample {
    
    static AlertExample *alertExample;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        alertExample = [[self alloc] init];
        
    });
    
    return alertExample;
    
}

#pragma mark - Overridden Instance Methods

- (instancetype)init {
    
    self = [super init];
    
    if (self) {
        
        self.animationStyle = VSAlertControllerAnimationStyleAutomatic;
        self.dismissOnBackgroundTap = NO;
        
    }
    
    return self;
    
}

#pragma mark - Property Access Methods

- (NSArray<NSNumber *> *)alertExamples {
    
    return @[@(AlertExampleTypeBasic),
             @(AlertExampleTypeCancel),
             @(AlertExampleTypeDestructive),
             @(AlertExampleTypeMultiChoice),
             @(AlertExampleTypeTextField1),
             @(AlertExampleTypeTextField2),
             @(AlertExampleTypeImage),
             @(AlertExampleTypeStyled)];
    
}

- (NSArray<NSNumber *> *)walkthroughExamples {
    
    return @[@(AlertExampleTypeWalkthroughBasic),
             @(AlertExampleTypeWalkthroughCancel),
             @(AlertExampleTypeWalkthroughDestructive),
             @(AlertExampleTypeWalkthroughMultiChoice),
             @(AlertExampleTypeWalkthroughTextField1),
             @(AlertExampleTypeWalkthroughTextField2),
             @(AlertExampleTypeWalkthroughImage),
             @(AlertExampleTypeWalkthroughStyled)];
    
}

- (NSArray<NSNumber *> *)actionSheetExamples {
    
    return @[@(AlertExampleTypeActionSheetBasic),
             @(AlertExampleTypeActionSheetCancel),
             @(AlertExampleTypeActionSheetDestructive),
             @(AlertExampleTypeActionSheetMultiChoice),
             @(AlertExampleTypeActionSheetImage),
             @(AlertExampleTypeActionSheetStyled)];
    
}

#pragma mark - Public Instance Methods

- (NSString *)exampleNameForExampleType:(AlertExampleType)exampleType {
    
    if (exampleType == AlertExampleTypeBasic) {
        
        return NSLocalizedString(@"Basic (Alert)", nil);
        
    }
    
    if (exampleType == AlertExampleTypeCancel) {
        
        return NSLocalizedString(@"Cancel (Alert)", nil);
        
    }
    
    if (exampleType == AlertExampleTypeDestructive) {
        
        return NSLocalizedString(@"Destructive (Alert)", nil);
        
    }
    
    if (exampleType == AlertExampleTypeMultiChoice) {
        
        return NSLocalizedString(@"Multi-Choice (Alert)", nil);
        
    }
    
    if (exampleType == AlertExampleTypeTextField1) {
        
        return NSLocalizedString(@"Text Field 1 (Alert)", nil);
        
    }
    
    if (exampleType == AlertExampleTypeTextField2) {
        
        return NSLocalizedString(@"Text Field 2 (Alert)", nil);
        
    }
    
    if (exampleType == AlertExampleTypeImage) {
        
        return NSLocalizedString(@"Image (Alert)", nil);
        
    }
    
    if (exampleType == AlertExampleTypeStyled) {
        
        return NSLocalizedString(@"Styled (Alert)", nil);
        
    }
    
    if (exampleType == AlertExampleTypeWalkthroughBasic) {
        
        return NSLocalizedString(@"Basic (Walkthrough)", nil);
        
    }
    
    if (exampleType == AlertExampleTypeWalkthroughCancel) {
        
        return NSLocalizedString(@"Cancel (Walkthrough)", nil);
        
    }
    
    if (exampleType == AlertExampleTypeWalkthroughDestructive) {
        
        return NSLocalizedString(@"Destructive (Walkthrough)", nil);
        
    }
    
    if (exampleType == AlertExampleTypeWalkthroughMultiChoice) {
        
        return NSLocalizedString(@"Multi-Choice (Walkthrough)", nil);
        
    }
    
    if (exampleType == AlertExampleTypeWalkthroughTextField1) {
        
        return NSLocalizedString(@"Text Field 1 (Walkthrough)", nil);
        
    }
    
    if (exampleType == AlertExampleTypeWalkthroughTextField2) {
        
        return NSLocalizedString(@"Text Field 2 (Walkthrough)", nil);
        
    }
    
    if (exampleType == AlertExampleTypeWalkthroughImage) {
        
        return NSLocalizedString(@"Image (Walkthrough)", nil);
        
    }
    
    if (exampleType == AlertExampleTypeWalkthroughStyled) {
        
        return NSLocalizedString(@"Styled (Walkthrough)", nil);
        
    }
    
    if (exampleType == AlertExampleTypeActionSheetBasic) {
        
        return NSLocalizedString(@"Basic (Action Sheet)", nil);
        
    }
    
    if (exampleType == AlertExampleTypeActionSheetCancel) {
        
        return NSLocalizedString(@"Cancel (Action Sheet)", nil);
        
    }
    
    if (exampleType == AlertExampleTypeActionSheetDestructive) {
        
        return NSLocalizedString(@"Destructive (Action Sheet)", nil);
        
    }
    
    if (exampleType == AlertExampleTypeActionSheetMultiChoice) {
        
        return NSLocalizedString(@"Multi-Choice (Action Sheet)", nil);
        
    }
    
    if (exampleType == AlertExampleTypeActionSheetImage) {
        
        return NSLocalizedString(@"Image (Action Sheet)", nil);
        
    }
    
    if (exampleType == AlertExampleTypeActionSheetStyled) {
        
        return NSLocalizedString(@"Styled (Action Sheet)", nil);
        
    }
    
    return nil;
    
}

- (void)presentAlertForExampleType:(AlertExampleType)exampleType onViewController:(UIViewController *)viewController withSourceView:(nullable UIView *)view {
    
    VSAlertController *controller;
    
    if (exampleType == AlertExampleTypeBasic) {
        
        controller = [VSAlertController alertControllerWithTitle:NSLocalizedString(@"Basic Alert", nil)
                                                         message:NSLocalizedString(@"Nothing but a title, a message, and a button.", nil)
                                                           image:nil
                                                           style:VSAlertControllerStyleAlert];
        controller.alertMessageTextAlignment = NSTextAlignmentLeft;
        VSAlertAction *action = [VSAlertAction alertActionWithTitle:NSLocalizedString(@"Close", nil)
                                                              style:VSAlertActionStyleCancel
                                                             action:nil];
        [controller addAction:action];
        
    } else if (exampleType == AlertExampleTypeCancel) {
        
        controller = [VSAlertController alertControllerWithTitle:NSLocalizedString(@"Would you like to continue?", nil)
                                                         message:NSLocalizedString(@"You can change your mind at any time", nil)
                                                           image:nil
                                                           style:VSAlertControllerStyleAlert];
        VSAlertAction *action1 = [VSAlertAction alertActionWithTitle:NSLocalizedString(@"Cancel", nil)
                                                               style:VSAlertActionStyleCancel
                                                              action:nil];
        [controller addAction:action1];
        VSAlertAction *action2 = [VSAlertAction alertActionWithTitle:NSLocalizedString(@"Continue", nil)
                                                               style:VSAlertActionStyleDefault
                                                              action:nil];
        [controller addAction:action2];
        
    } else if (exampleType == AlertExampleTypeDestructive) {
        
        controller = [VSAlertController alertControllerWithTitle:NSLocalizedString(@"Would you like to continue?", nil)
                                                         message:NSLocalizedString(@"This change is permanent", nil)
                                                           image:nil
                                                           style:VSAlertControllerStyleAlert];
        VSAlertAction *action1 = [VSAlertAction alertActionWithTitle:NSLocalizedString(@"Cancel", nil)
                                                               style:VSAlertActionStyleCancel
                                                              action:nil];
        [controller addAction:action1];
        VSAlertAction *action2 = [VSAlertAction alertActionWithTitle:NSLocalizedString(@"Continue", nil)
                                                               style:VSAlertActionStyleDestructive
                                                              action:nil];
        [controller addAction:action2];
        
    } else if (exampleType == AlertExampleTypeMultiChoice) {
        
        controller = [VSAlertController alertControllerWithTitle:NSLocalizedString(@"Make a Choice", nil)
                                                         message:NSLocalizedString(@"Some are better than others", nil)
                                                           image:nil
                                                           style:VSAlertControllerStyleAlert];
        VSAlertAction *action1 = [VSAlertAction alertActionWithTitle:NSLocalizedString(@"Cancel", nil)
                                                               style:VSAlertActionStyleCancel
                                                              action:nil];
        [controller addAction:action1];
        VSAlertAction *action2 = [VSAlertAction alertActionWithTitle:NSLocalizedString(@"Dangerous Choice", nil)
                                                               style:VSAlertActionStyleDestructive
                                                              action:nil];
        [controller addAction:action2];
        VSAlertAction *action3 = [VSAlertAction alertActionWithTitle:NSLocalizedString(@"Choice 1", nil)
                                                               style:VSAlertActionStyleDefault
                                                              action:nil];
        [controller addAction:action3];
        VSAlertAction *action4 = [VSAlertAction alertActionWithTitle:NSLocalizedString(@"Choice 2", nil)
                                                               style:VSAlertActionStyleDefault
                                                              action:nil];
        [controller addAction:action4];
        
    } else if (exampleType == AlertExampleTypeTextField1) {
        
        controller = [VSAlertController alertControllerWithTitle:NSLocalizedString(@"Enter Zipcode", nil)
                                                         message:NSLocalizedString(@"Some featuers are only available in certain areas", nil)
                                                           image:nil
                                                           style:VSAlertControllerStyleAlert];
        [controller addTextField:^(UITextField *textfield) {
           
            textfield.placeholder = NSLocalizedString(@"Zipcode", nil);
            
        }];
        
        VSAlertAction *action1 = [VSAlertAction alertActionWithTitle:NSLocalizedString(@"Continue", nil)
                                                               style:VSAlertActionStyleDefault
                                                              action:^(VSAlertAction *action) {
                                                                  
                                                                  os_log_info(example_alert, "%@", controller.textFields[0].text);
                                                                  
                                                              }];
        [controller addAction:action1];
        VSAlertAction *action2 = [VSAlertAction alertActionWithTitle:NSLocalizedString(@"Cancel", nil)
                                                               style:VSAlertActionStyleCancel
                                                              action:nil];
        [controller addAction:action2];
        
    } else if (exampleType == AlertExampleTypeTextField2) {
        
        controller = [VSAlertController alertControllerWithTitle:NSLocalizedString(@"Log In", nil)
                                                     message:nil
                                                           image:nil
                                                           style:VSAlertControllerStyleAlert];
        [controller addTextField:^(UITextField *textfield) {
            
            textfield.placeholder = NSLocalizedString(@"Email Address", nil);
            textfield.keyboardType = UIKeyboardTypeEmailAddress;
            
        }];
        
        [controller addTextField:^(UITextField *textfield) {
           
            textfield.placeholder = NSLocalizedString(@"Password", nil);
            textfield.secureTextEntry = YES;
            
        }];
        
        VSAlertAction *action1 = [VSAlertAction alertActionWithTitle:NSLocalizedString(@"Log In", nil)
                                                               style:VSAlertActionStyleDefault
                                                              action:^(VSAlertAction *action) {
                                                                  
                                                                  os_log_info(example_alert, "Email: %@", controller.textFields[0].text);
                                                                  os_log_info(example_alert, "Password: %@", controller.textFields[1].text);
                                                                  
                                                              }];
        [controller addAction:action1];
        VSAlertAction *action2 = [VSAlertAction alertActionWithTitle:NSLocalizedString(@"Cancel", nil)
                                                               style:VSAlertActionStyleCancel
                                                              action:nil];
        [controller addAction:action2];
        action1.tintColor = [UIColor redColor];
        
    } else if (exampleType == AlertExampleTypeImage) {
        
        controller = [VSAlertController alertControllerWithTitle:NSLocalizedString(@"Subscription Required", nil)
                                                         message:NSLocalizedString(@"Visit our website for available plan information.", nil)
                                                           image:[UIImage imageNamed:@"news-alert"]
                                                           style:VSAlertControllerStyleAlert];
        VSAlertAction *action = [VSAlertAction alertActionWithTitle:NSLocalizedString(@"Close", nil)
                                                              style:VSAlertActionStyleCancel
                                                             action:nil];
        [controller addAction:action];
        
    } else if (exampleType == AlertExampleTypeStyled) {
        
        controller = [VSAlertController alertControllerWithTitle:NSLocalizedString(@"Locate your device", nil)
                                                         message:NSLocalizedString(@"Enables access to your location: discover what you can do when you're traveling and what is available near you.", nil)
                                                           image:[UIImage imageNamed:@"flag.png"]
                                                           style:VSAlertControllerStyleAlert];
        controller.alertTitleTextColor = [UIColor colorWithRed:0.929f green:0.596f blue:0.082f alpha:1.0f];
        controller.alertTitleTextFont = [UIFont fontWithName:@"Avenir-Roman" size:17.0f];
        controller.alertMessageTextColor = [UIColor colorWithRed:1.0f/3.0f
                                                               green:1.0f/3.0f
                                                                blue:1.0f/3.0f
                                                               alpha:1.0f];
        controller.alertMessageTextFont = [UIFont fontWithName:@"Avenir-Medium" size:15.0f];
        
        VSAlertAction *action1 = [VSAlertAction alertActionWithTitle:NSLocalizedString(@"Cancel", nil)
                                                               style:VSAlertActionStyleCancel
                                                              action:nil];
        action1.cancelActionTextFont = [UIFont fontWithName:@"Avenir-Heavy" size:17.0f];
        action1.actionTextColor = [UIColor grayColor];
        [controller addAction:action1];
        
        VSAlertAction *action2 = [VSAlertAction alertActionWithTitle:NSLocalizedString(@"Allow", nil)
                                                               style:VSAlertActionStyleDestructive
                                                              action:nil];
        action2.destructiveActionTextColor = [UIColor colorWithRed:191.0f/255.0f green:51.0f/255.0f blue:98.0f/255.0f alpha:1.0f];
        action2.actionTextFont = [UIFont fontWithName:@"Avenir-Heavy" size:17.0f];
        [controller addAction:action2];
        
    } else if (exampleType == AlertExampleTypeWalkthroughBasic) {
        
        controller = [VSAlertController alertControllerWithTitle:NSLocalizedString(@"Walkthrough Alert", nil)
                                                         message:NSLocalizedString(@"Like a basic alert, but wider. Basic alerts are 270pt wide, walkthrough alerts stretch to fill the display. They can be useful for onboarding and set-up screen.", nil)
                                                           image:nil
                                                           style:VSAlertControllerStyleWalkthroughAlert];
        VSAlertAction *action = [VSAlertAction alertActionWithTitle:NSLocalizedString(@"Close", nil)
                                                              style:VSAlertActionStyleCancel
                                                             action:nil];
        [controller addAction:action];
        
    } else if (exampleType == AlertExampleTypeWalkthroughCancel) {
        
        controller = [VSAlertController alertControllerWithTitle:NSLocalizedString(@"Would you like to continue?", nil)
                                                         message:NSLocalizedString(@"You can change your mind at any time", nil)
                                                           image:nil
                                                           style:VSAlertControllerStyleWalkthroughAlert];
        VSAlertAction *action1 = [VSAlertAction alertActionWithTitle:NSLocalizedString(@"Cancel", nil)
                                                               style:VSAlertActionStyleCancel
                                                              action:nil];
        [controller addAction:action1];
        VSAlertAction *action2 = [VSAlertAction alertActionWithTitle:NSLocalizedString(@"Continue", nil)
                                                               style:VSAlertActionStyleDefault
                                                              action:nil];
        [controller addAction:action2];
        
    } else if (exampleType == AlertExampleTypeWalkthroughDestructive) {
        
        controller = [VSAlertController alertControllerWithTitle:NSLocalizedString(@"Would you like to continue?", nil)
                                                         message:NSLocalizedString(@"This change is permanent", nil)
                                                           image:nil
                                                           style:VSAlertControllerStyleWalkthroughAlert];
        VSAlertAction *action1 = [VSAlertAction alertActionWithTitle:NSLocalizedString(@"Cancel", nil)
                                                               style:VSAlertActionStyleCancel
                                                              action:nil];
        [controller addAction:action1];
        VSAlertAction *action2 = [VSAlertAction alertActionWithTitle:NSLocalizedString(@"Continue", nil)
                                                               style:VSAlertActionStyleDestructive
                                                              action:nil];
        [controller addAction:action2];
        
    } else if (exampleType == AlertExampleTypeWalkthroughMultiChoice) {
        
        controller = [VSAlertController alertControllerWithTitle:NSLocalizedString(@"Make a Choice", nil)
                                                         message:NSLocalizedString(@"Some are better than others", nil)
                                                           image:nil
                                                           style:VSAlertControllerStyleWalkthroughAlert];
        VSAlertAction *action1 = [VSAlertAction alertActionWithTitle:NSLocalizedString(@"Cancel", nil)
                                                               style:VSAlertActionStyleCancel
                                                              action:nil];
        [controller addAction:action1];
        VSAlertAction *action2 = [VSAlertAction alertActionWithTitle:NSLocalizedString(@"Dangerous Choice", nil)
                                                               style:VSAlertActionStyleDestructive
                                                              action:nil];
        [controller addAction:action2];
        VSAlertAction *action3 = [VSAlertAction alertActionWithTitle:NSLocalizedString(@"Choice 1", nil)
                                                               style:VSAlertActionStyleDefault
                                                              action:nil];
        [controller addAction:action3];
        VSAlertAction *action4 = [VSAlertAction alertActionWithTitle:NSLocalizedString(@"Choice 2", nil)
                                                               style:VSAlertActionStyleDefault
                                                              action:nil];
        [controller addAction:action4];
        
    } else if (exampleType == AlertExampleTypeWalkthroughTextField1) {
        
        controller = [VSAlertController alertControllerWithTitle:NSLocalizedString(@"Enter Zipcode", nil)
                                                         message:NSLocalizedString(@"Some featuers are only available in certain areas", nil)
                                                           image:nil
                                                           style:VSAlertControllerStyleWalkthroughAlert];
        [controller addTextField:^(UITextField *textfield) {
            
            textfield.placeholder = NSLocalizedString(@"Zipcode", nil);
            
        }];
        
        VSAlertAction *action1 = [VSAlertAction alertActionWithTitle:NSLocalizedString(@"Continue", nil)
                                                               style:VSAlertActionStyleDefault
                                                              action:^(VSAlertAction *action) {
                                                                  
                                                                  os_log_info(example_alert, "%@", controller.textFields[0].text);
                                                                  
                                                              }];
        [controller addAction:action1];
        VSAlertAction *action2 = [VSAlertAction alertActionWithTitle:NSLocalizedString(@"Cancel", nil)
                                                               style:VSAlertActionStyleCancel
                                                              action:nil];
        [controller addAction:action2];
        
    } else if (exampleType == AlertExampleTypeWalkthroughTextField2) {
        
        controller = [VSAlertController alertControllerWithTitle:NSLocalizedString(@"Log In", nil)
                                                         message:nil
                                                           image:nil
                                                           style:VSAlertControllerStyleWalkthroughAlert];
        [controller addTextField:^(UITextField *textfield) {
            
            textfield.placeholder = NSLocalizedString(@"Email Address", nil);
            textfield.keyboardType = UIKeyboardTypeEmailAddress;
            
        }];
        
        [controller addTextField:^(UITextField *textfield) {
            
            textfield.placeholder = NSLocalizedString(@"Password", nil);
            textfield.secureTextEntry = YES;
            
        }];
        
        VSAlertAction *action1 = [VSAlertAction alertActionWithTitle:NSLocalizedString(@"Log In", nil)
                                                               style:VSAlertActionStyleDefault
                                                              action:^(VSAlertAction *action) {
                                                                  
                                                                  os_log_info(example_alert, "Email: %@", controller.textFields[0].text);
                                                                  os_log_info(example_alert, "Password: %@", controller.textFields[1].text);
                                                                  
                                                              }];
        [controller addAction:action1];
        VSAlertAction *action2 = [VSAlertAction alertActionWithTitle:NSLocalizedString(@"Cancel", nil)
                                                               style:VSAlertActionStyleCancel
                                                              action:nil];
        [controller addAction:action2];
        action1.tintColor = [UIColor redColor];
        
    } else if (exampleType == AlertExampleTypeWalkthroughImage) {
        
        controller = [VSAlertController alertControllerWithTitle:NSLocalizedString(@"Subscription Required", nil)
                                                         message:NSLocalizedString(@"Visit our website for available plan information.", nil)
                                                           image:[UIImage imageNamed:@"news-alert"]
                                                           style:VSAlertControllerStyleWalkthroughAlert];
        VSAlertAction *action = [VSAlertAction alertActionWithTitle:NSLocalizedString(@"Close", nil)
                                                              style:VSAlertActionStyleCancel
                                                             action:nil];
        [controller addAction:action];
        
    } else if (exampleType == AlertExampleTypeWalkthroughStyled) {
        
        controller = [VSAlertController alertControllerWithTitle:NSLocalizedString(@"Locate your device", nil)
                                                         message:NSLocalizedString(@"Enables access to your location: discover what you can do when you're traveling and what is available near you.", nil)
                                                           image:[UIImage imageNamed:@"flag.png"]
                                                           style:VSAlertControllerStyleWalkthroughAlert];
        controller.alertTitleTextColor = [UIColor colorWithRed:0.929f green:0.596f blue:0.082f alpha:1.0f];
        controller.alertTitleTextFont = [UIFont fontWithName:@"Avenir-Roman" size:17.0f];
        controller.alertMessageTextColor = [UIColor colorWithRed:1.0f/3.0f
                                                               green:1.0f/3.0f
                                                                blue:1.0f/3.0f
                                                               alpha:1.0f];
        controller.alertMessageTextFont = [UIFont fontWithName:@"Avenir-Medium" size:15.0f];
        
        VSAlertAction *action1 = [VSAlertAction alertActionWithTitle:NSLocalizedString(@"Cancel", nil)
                                                               style:VSAlertActionStyleCancel
                                                              action:nil];
        action1.cancelActionTextFont = [UIFont fontWithName:@"Avenir-Heavy" size:17.0f];
        action1.actionTextColor = [UIColor grayColor];
        [controller addAction:action1];
        
        VSAlertAction *action2 = [VSAlertAction alertActionWithTitle:NSLocalizedString(@"Allow", nil)
                                                               style:VSAlertActionStyleDestructive
                                                              action:nil];
        action2.destructiveActionTextColor = [UIColor colorWithRed:191.0f/255.0f green:51.0f/255.0f blue:98.0f/255.0f alpha:1.0f];
        action2.actionTextFont = [UIFont fontWithName:@"Avenir-Heavy" size:17.0f];
        [controller addAction:action2];
        
    } else if (exampleType == AlertExampleTypeActionSheetBasic) {
        
        controller = [VSAlertController alertControllerWithTitle:NSLocalizedString(@"Action Sheet", nil)
                                                         message:NSLocalizedString(@"These alerts fire from the bottom of the screen. They're useful for having a user make a choice", nil)
                                                           image:nil
                                                           style:VSAlertControllerStyleActionSheet];
        VSAlertAction *action = [VSAlertAction alertActionWithTitle:NSLocalizedString(@"Close", nil)
                                                              style:VSAlertActionStyleCancel
                                                             action:nil];
        [controller addAction:action];
        
    } else if (exampleType == AlertExampleTypeActionSheetCancel) {
        
        controller = [VSAlertController alertControllerWithTitle:NSLocalizedString(@"Would you like to continue?", nil)
                                                         message:NSLocalizedString(@"You can change your mind at any time", nil)
                                                           image:nil
                                                           style:VSAlertControllerStyleActionSheet];
        VSAlertAction *action1 = [VSAlertAction alertActionWithTitle:NSLocalizedString(@"Cancel", nil)
                                                               style:VSAlertActionStyleCancel
                                                              action:nil];
        [controller addAction:action1];
        VSAlertAction *action2 = [VSAlertAction alertActionWithTitle:NSLocalizedString(@"Continue", nil)
                                                               style:VSAlertActionStyleDefault
                                                              action:nil];
        [controller addAction:action2];
        
    } else if (exampleType == AlertExampleTypeActionSheetDestructive) {
        
        controller = [VSAlertController alertControllerWithTitle:NSLocalizedString(@"Would you like to continue?", nil)
                                                         message:NSLocalizedString(@"This change is permanent", nil)
                                                           image:nil
                                                           style:VSAlertControllerStyleActionSheet];
        VSAlertAction *action1 = [VSAlertAction alertActionWithTitle:NSLocalizedString(@"Cancel", nil)
                                                               style:VSAlertActionStyleCancel
                                                              action:nil];
        [controller addAction:action1];
        VSAlertAction *action2 = [VSAlertAction alertActionWithTitle:NSLocalizedString(@"Continue", nil)
                                                               style:VSAlertActionStyleDestructive
                                                              action:nil];
        [controller addAction:action2];
        
    } else if (exampleType == AlertExampleTypeActionSheetMultiChoice) {
        
        controller = [VSAlertController alertControllerWithTitle:NSLocalizedString(@"Make a Choice", nil)
                                                         message:NSLocalizedString(@"Some are better than others", nil)
                                                           image:nil
                                                           style:VSAlertControllerStyleActionSheet];
        VSAlertAction *action1 = [VSAlertAction alertActionWithTitle:NSLocalizedString(@"Cancel", nil)
                                                               style:VSAlertActionStyleCancel
                                                              action:nil];
        [controller addAction:action1];
        VSAlertAction *action2 = [VSAlertAction alertActionWithTitle:NSLocalizedString(@"Dangerous Choice", nil)
                                                               style:VSAlertActionStyleDestructive
                                                              action:nil];
        [controller addAction:action2];
        VSAlertAction *action3 = [VSAlertAction alertActionWithTitle:NSLocalizedString(@"Choice 1", nil)
                                                               style:VSAlertActionStyleDefault
                                                              action:nil];
        [controller addAction:action3];
        VSAlertAction *action4 = [VSAlertAction alertActionWithTitle:NSLocalizedString(@"Choice 2", nil)
                                                               style:VSAlertActionStyleDefault
                                                              action:nil];
        [controller addAction:action4];
        
    } else if (exampleType == AlertExampleTypeActionSheetImage) {
        
        controller = [VSAlertController alertControllerWithTitle:NSLocalizedString(@"Subscription Required", nil)
                                                         message:NSLocalizedString(@"Visit our website for available plan information.", nil)
                                                           image:[UIImage imageNamed:@"news-alert"]
                                                           style:VSAlertControllerStyleActionSheet];
        VSAlertAction *action = [VSAlertAction alertActionWithTitle:NSLocalizedString(@"Close", nil)
                                                              style:VSAlertActionStyleCancel
                                                             action:nil];
        [controller addAction:action];
        
    } else if (exampleType == AlertExampleTypeActionSheetStyled) {
        
        controller = [VSAlertController alertControllerWithTitle:NSLocalizedString(@"Locate your device", nil)
                                                         message:NSLocalizedString(@"Enables access to your location: discover what you can do when you're traveling and what is available near you.", nil)
                                                           image:[UIImage imageNamed:@"flag.png"]
                                                           style:VSAlertControllerStyleActionSheet];
        controller.alertTitleTextColor = [UIColor colorWithRed:0.929f green:0.596f blue:0.082f alpha:1.0f];
        controller.alertTitleTextFont = [UIFont fontWithName:@"Avenir-Roman" size:17.0f];
        controller.alertMessageTextColor = [UIColor colorWithRed:1.0f/3.0f
                                                               green:1.0f/3.0f
                                                                blue:1.0f/3.0f
                                                               alpha:1.0f];
        controller.alertMessageTextFont = [UIFont fontWithName:@"Avenir-Medium" size:15.0f];
        
        VSAlertAction *action1 = [VSAlertAction alertActionWithTitle:NSLocalizedString(@"Cancel", nil)
                                                               style:VSAlertActionStyleCancel
                                                              action:nil];
        action1.cancelActionTextFont = [UIFont fontWithName:@"Avenir-Heavy" size:17.0f];
        action1.actionTextColor = [UIColor grayColor];
        [controller addAction:action1];
        
        VSAlertAction *action2 = [VSAlertAction alertActionWithTitle:NSLocalizedString(@"Allow", nil)
                                                               style:VSAlertActionStyleDestructive
                                                              action:nil];
        action2.destructiveActionTextColor = [UIColor colorWithRed:191.0f/255.0f green:51.0f/255.0f blue:98.0f/255.0f alpha:1.0f];
        action2.actionTextFont = [UIFont fontWithName:@"Avenir-Heavy" size:17.0f];
        [controller addAction:action2];
        
    }
    
    controller.animationStyle = self.animationStyle;
    controller.dismissOnBackgroundTap = self.dismissOnBackgroundTap;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad && controller.style == VSAlertControllerStyleActionSheet) {
        
        controller.modalPresentationStyle = UIModalPresentationPopover;
        controller.popoverPresentationController.sourceView = view;
        controller.popoverPresentationController.sourceRect = view.bounds;
        
    }
    
    [viewController presentViewController:controller
                                 animated:YES
                               completion:nil];
    
}

@end
