//
//  AlertExampleViewController.m
//  VSAlertController-Example
//
//  Created by Varun Santhanam on 10/8/17.
//

#import "AlertExampleViewController.h"

#import "AlertExample.h"
#import "VSAlertController.h"

@interface AlertExampleViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation AlertExampleViewController

- (void)viewDidLoad {
 
    [super viewDidLoad];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        
        return [AlertExample sharedExample].alertExamples.count;
        
    } else if (section == 1) {
        
        return [AlertExample sharedExample].walkthroughExamples.count;
        
    } else if (section == 2) {
        
        return [AlertExample sharedExample].actionSheetExamples.count;
        
    }
    
    return 0;
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        
        return NSLocalizedString(@"Normal Alerts", nil);
        
    }
    
    if (section == 1) {
        
        return NSLocalizedString(@"Walkthrough Alerts", nil);
        
    }
    
    if (section == 2) {
        
        return NSLocalizedString(@"Action Sheets", nil);
        
    }
    
    return @"";
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"CellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];;
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    
    AlertExampleType example;
    
    if (indexPath.section == 0) {
     
        example = (AlertExampleType)[AlertExample sharedExample].alertExamples[indexPath.row].integerValue;
        
    } else if (indexPath.section == 1) {
        
        example = (AlertExampleType)[AlertExample sharedExample].walkthroughExamples[indexPath.row].integerValue;

    } else if (indexPath.section == 2) {
        
        example = (AlertExampleType)[AlertExample sharedExample].actionSheetExamples[indexPath.row].integerValue;
        
    } else {
        
        example = AlertExampleTypeBasic;
        
    }
    
    cell.textLabel.text = [[AlertExample sharedExample] exampleNameForExampleType:example];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    AlertExampleType example;
    
    if (indexPath.section == 0) {
        
        example = (AlertExampleType)[AlertExample sharedExample].alertExamples[indexPath.row].integerValue;
        
    } else if (indexPath.section == 1) {
        
        example = (AlertExampleType)[AlertExample sharedExample].walkthroughExamples[indexPath.row].integerValue;
        
    } else if (indexPath.section == 2) {
        
        example = (AlertExampleType)[AlertExample sharedExample].actionSheetExamples[indexPath.row].integerValue;
        
    } else {
        
        example = AlertExampleTypeBasic;
        
    }
    
    [[AlertExample sharedExample] presentAlertForExampleType:example onViewController:self];
    
}

@end
