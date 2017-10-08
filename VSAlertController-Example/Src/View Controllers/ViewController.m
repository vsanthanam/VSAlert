//
//  ViewController.m
//  VSAlertController-Example
//
//  Created by Varun Santhanam on 10/8/17.
//

#import "ViewController.h"

#import "VSAlertController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    VSAlertController *controller = [VSAlertController alertControllerWithTitle:NSLocalizedString(@"Enter Your Password", nil)
                                                                    description:NSLocalizedString(@"It's Really Important", nil)
                                                                          image:nil
                                                                          style:VSAlertControllerStyleAlert];
    
    [controller addTextField:^(UITextField *textField) {
       
        textField.secureTextEntry = YES;
        textField.placeholder = NSLocalizedString(@"Password", nil);
        
    }];
    
    VSAlertAction *action = [VSAlertAction alertActionWithTitle:NSLocalizedString(@"Cancel", nil)
                                                          style:VSAlertActionStyleCancel
                                                         action:^(VSAlertAction *action) {
                                                             
                                                             NSLog(@"Cancelled");
                                                             
                                                         }];
    
    VSAlertAction *action2 = [VSAlertAction alertActionWithTitle:NSLocalizedString(@"Confirm", nil)
                                                           style:VSAlertActionStyleDefault
                                                          action:^(VSAlertAction *action) {
                                                              
                                                              NSLog(@"%@", controller.textFields[0].text);
                                                              
                                                          }];
    [controller addAction:action];
    [controller addAction:action2];
    [self presentViewController:controller
                       animated:YES
                     completion:nil];
    
}


@end
