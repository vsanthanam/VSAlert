//
//  AlertExampleViewController.m
//  VSAlertController-Example
//
//  Created by Varun Santhanam on 10/8/17.
//

#import "AlertExampleViewController.h"

#import "VSAlertController.h"
#import "AlertExample.h"

@interface AlertExampleViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation AlertExampleViewController

- (void)viewDidLoad {
 
    [super viewDidLoad];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [AlertExample sharedExample].examples.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"CellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];;
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    
    AlertExampleType example = (AlertExampleType)[AlertExample sharedExample].examples[indexPath.row].integerValue;
    
    cell.textLabel.text = [[AlertExample sharedExample] exampleNameForExampleType:example];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    AlertExampleType example = (AlertExampleType)[AlertExample sharedExample].examples[indexPath.row].integerValue;
    
    [[AlertExample sharedExample] presentAlertForExampleType:example onViewController:self];
    
}

@end
