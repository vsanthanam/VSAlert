//
//  AlertExampleViewController.m
//  VSAlertController-Example
//
//  Created by Varun Santhanam on 10/8/17.
//

#import <os/log.h>

#import "AlertExampleViewController.h"

#import "VSAlertController.h"

typedef NS_ENUM(NSInteger, AlertExampleViewControllerExampleType) {
    
    AlertExampleViewControllerExampleTypeStandard,
    AlertExampleViewControllerExampleTypeDestructive,
    AlertExampleViewControllerExampleTypeMultiChoice,
    AlertExampleViewControllerExampleTypeWalkthroughAlert,
    AlertExampleViewControllerExampleTypeTextField,
    AlertExampleViewControllerExampleTypeLogIn
    
};

@interface AlertExampleViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray<NSNumber *> *examples;

@end

@implementation AlertExampleViewController

static os_log_t example_log;

+ (void)initialize {
    
    example_log = os_log_create("com.VarunSanthanam.VSAlertController-Example", "ExampleLog");
    
}

- (void)viewDidLoad {
    
    self.examples = @[@(AlertExampleViewControllerExampleTypeStandard),
                      @(AlertExampleViewControllerExampleTypeDestructive),
                      @(AlertExampleViewControllerExampleTypeMultiChoice),
                      @(AlertExampleViewControllerExampleTypeWalkthroughAlert),
                      @(AlertExampleViewControllerExampleTypeTextField),
                      @(AlertExampleViewControllerExampleTypeLogIn)];
    
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self _showAlertForType:(AlertExampleViewControllerExampleType)self.examples[indexPath.row].integerValue];
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.examples.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *AlertCellIdentifier = @"AlertCellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:AlertCellIdentifier];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:AlertCellIdentifier];
        
    }
    
    AlertExampleViewControllerExampleType exampleType = (AlertExampleViewControllerExampleType)self.examples[indexPath.row].integerValue;
    
    if (exampleType == AlertExampleViewControllerExampleTypeStandard) {
        
        cell.textLabel.text = NSLocalizedString(@"Standard Alert", nil);
        
    }
    
    if (exampleType == AlertExampleViewControllerExampleTypeDestructive) {
        
        cell.textLabel.text = NSLocalizedString(@"Destructive Alert", nil);
        
    }
    
    if (exampleType == AlertExampleViewControllerExampleTypeMultiChoice) {
        
        cell.textLabel.text = NSLocalizedString(@"Multi Choice", nil);
        
    }
    
    if (exampleType == AlertExampleViewControllerExampleTypeWalkthroughAlert) {
        
        cell.textLabel.text = NSLocalizedString(@"Walkthrough (Wide)", nil);
        
    }
    
    if (exampleType == AlertExampleViewControllerExampleTypeTextField) {
        
        cell.textLabel.text = NSLocalizedString(@"Text Field", nil);
        
    }
    
    if (exampleType == AlertExampleViewControllerExampleTypeLogIn) {
        
        cell.textLabel.text = NSLocalizedString(@"Log In", nil);
        
    }
    
    return cell;
    
}

- (void)_showAlertForType:(AlertExampleViewControllerExampleType)type {
    
    VSAlertController *alertController;
    
    if (type == AlertExampleViewControllerExampleTypeStandard) {
        
        alertController = [VSAlertController alertControllerWithTitle:NSLocalizedString(@"Error", nil)
                                                          description:NSLocalizedString(@"The operation couldn't be completed. Please try again later.", nil)
                                                                image:nil
                                                                style:VSAlertControllerStyleAlert];
        VSAlertAction *okCancelAction = [VSAlertAction alertActionWithTitle:NSLocalizedString(@"Close", nil)
                                                                      style:VSAlertActionStyleCancel
                                                                     action:nil];
        [alertController addAction:okCancelAction];
        
    }
    
    if (type == AlertExampleViewControllerExampleTypeDestructive) {
        
        alertController = [VSAlertController alertControllerWithTitle:NSLocalizedString(@"Are You Sure?", nil)
                                                          description:NSLocalizedString(@"Something bad is about to happen. You might want to to think about this before proceeding.", nil)
                                                                image:nil
                                                                style:VSAlertControllerStyleAlert];
        VSAlertAction *action = [VSAlertAction alertActionWithTitle:NSLocalizedString(@"Proceed", nil)
                                                              style:VSAlertActionStyleDestructive
                                                             action:nil];
        VSAlertAction *cancelAction = [VSAlertAction alertActionWithTitle:NSLocalizedString(@"Cancel", nil)
                                                                    style:VSAlertActionStyleCancel
                                                                   action:nil];
        [alertController addAction:action];
        [alertController addAction:cancelAction];
        
        
        
    }
    
    if (type == AlertExampleViewControllerExampleTypeMultiChoice) {
        
        alertController = [VSAlertController alertControllerWithTitle:NSLocalizedString(@"Pick An Option", nil)
                                                          description:NSLocalizedString(@"Or cancel, if you don't want any of them", nil)
                                                                image:nil
                                                                style:VSAlertControllerStyleAlert];
        VSAlertAction *action1 = [VSAlertAction alertActionWithTitle:NSLocalizedString(@"Choice 1", nil)
                                                               style:VSAlertActionStyleDefault
                                                              action:nil];
        VSAlertAction *action2 = [VSAlertAction alertActionWithTitle:NSLocalizedString(@"Choice 2", nil)
                                                               style:VSAlertActionStyleDefault
                                                              action:nil];
        VSAlertAction *cancelAction = [VSAlertAction alertActionWithTitle:NSLocalizedString(@"Cancel", nil)
                                                                    style:VSAlertActionStyleCancel
                                                                   action:nil];
        [alertController addAction:action1];
        [alertController addAction:action2];
        [alertController addAction:cancelAction];
        
        
    }
    
    if (type == AlertExampleViewControllerExampleTypeWalkthroughAlert) {
        
        alertController = [VSAlertController alertControllerWithTitle:NSLocalizedString(@"Welcome!", nil)
                                                          description:NSLocalizedString(@"Let's get you set up. This kind of alert is a little wider to allow for more content without stretching. Could be handy", nil)
                                                                image:nil
                                                                style:VSAlertControllerStyleWalkthroughAlert];
        VSAlertAction *action = [VSAlertAction alertActionWithTitle:NSLocalizedString(@"Continue", nil)
                                                              style:VSAlertActionStyleDefault
                                                             action:nil];
        [alertController addAction:action];
        
    }
    
    if (type == AlertExampleViewControllerExampleTypeTextField) {
        
        alertController = [VSAlertController alertControllerWithTitle:NSLocalizedString(@"Enter Your Zipcode", nil)
                                                          description:NSLocalizedString(@"Some services are only available regionally", nil)
                                                                image:nil
                                                                style:VSAlertControllerStyleAlert];
        [alertController addTextField:^(UITextField *textField) {
           
            textField.placeholder = NSLocalizedString(@"Zip Code", nil);
        
            if (@available(iOS 10.0, *)) {
                
                textField.textContentType = UITextContentTypeLocation;
                
            }
            
        }];
        
        VSAlertAction *action = [VSAlertAction alertActionWithTitle:NSLocalizedString(@"Cancel", nil)
                                                              style:VSAlertActionStyleCancel
                                                             action:nil];
        VSAlertAction *action2 = [VSAlertAction alertActionWithTitle:NSLocalizedString(@"Verify", nil)
                                                               style:VSAlertActionStyleDefault action:^(VSAlertAction *action) {
                                                                   
                                                                   os_log(example_log, "%@", alertController.textFields[0].text);
                                                                   
                                                               }];
        [alertController addAction:action];
        [alertController addAction:action2];
        
    }
    
    if (type == AlertExampleViewControllerExampleTypeLogIn) {
        
        alertController = [VSAlertController alertControllerWithTitle:NSLocalizedString(@"Log In", nil)
                                                          description:nil
                                                                image:nil
                                                                style:VSAlertControllerStyleAlert];
        [alertController addTextField:^(UITextField *textField) {
            
            textField.placeholder = NSLocalizedString(@"Email Address", nil);
            textField.keyboardType = UIKeyboardTypeEmailAddress;
            
            if (@available(iOS 10.0, *)) {
                
                textField.textContentType = UITextContentTypeEmailAddress;
                
            }
        
        }];
        
        [alertController addTextField:^(UITextField *textField) {
           
            textField.placeholder = NSLocalizedString(@"Password", nil);
            textField.secureTextEntry = YES;
            
            if (@available(iOS 11.0, *)) {
                
                textField.textContentType = UITextContentTypePassword;
                
            }
            
        }];
        
        VSAlertAction *action = [VSAlertAction alertActionWithTitle:NSLocalizedString(@"Log In", nil)
                                                              style:VSAlertActionStyleDefault
                                                             action:^(VSAlertAction *action){
                                                                 
                                                                 os_log(example_log, "Email Address: %@", alertController.textFields[0].text);
                                                                 os_log(example_log, "Password: %@", alertController.textFields[0].text);
                                                                 
                                                             }];

        [alertController addAction:action];
        
    }
    
    [self presentViewController:alertController
                       animated:YES
                     completion:nil];
    
}

@end
