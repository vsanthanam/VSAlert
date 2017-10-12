//
//  AlertExampleSettingsViewController.m
//  VSAlertController-Example
//
//  Created by Varun Santhanam on 10/11/17.
//

#import "AlertExampleSettingsViewController.h"

#import "AlertExample.h"

@interface AlertExampleSettingsViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation AlertExampleSettingsViewController

#pragma mark - Overridden Instance Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        
        return 1;
        
    }
    
    if (section == 1) {
     
        return 7;
        
    }
    
    return 0;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *SettingsSwitchCell = @"SettingsSwitchCell";
    static NSString *AnimationCell = @"AnimationCell";
    
    if (indexPath.section == 0) {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SettingsSwitchCell];
        
        if (!cell) {
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SettingsSwitchCell];
            cell.accessoryView = [[UISwitch alloc] init];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        
        UISwitch *switchControl = (UISwitch *)cell.accessoryView;
        
        if (indexPath.row == 0) {
            
            cell.textLabel.text = NSLocalizedString(@"Backgroud Tap Dismiss", nil);
            switchControl.on = [AlertExample sharedExample].dismissOnBackgroundTap;
            [switchControl addTarget:self
                              action:@selector(_editBackgroundTap:)
                    forControlEvents:UIControlEventValueChanged];
            
        }
        
        return cell;
        
    } else if (indexPath.section == 1) {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SettingsSwitchCell];
        
        if (!cell) {
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:AnimationCell];
            
        }
        
        if (indexPath.row == 0) {
            
            cell.textLabel.text = NSLocalizedString(@"Automatic", nil);
            cell.accessoryType = [AlertExample sharedExample].animationStyle == VSAlertControllerAnimationStyleAutomatic ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
            
        }
        
        if (indexPath.row == 1) {
            
            cell.textLabel.text = NSLocalizedString(@"Rise", nil);
            cell.accessoryType = [AlertExample sharedExample].animationStyle == VSAlertControllerAnimationStyleRise ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
            
        }
        
        if (indexPath.row == 2) {
            
            cell.textLabel.text = NSLocalizedString(@"Fall", nil);
            cell.accessoryType = [AlertExample sharedExample].animationStyle == VSAlertControllerAnimationStyleFall ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
            
        }
        
        if (indexPath.row == 3) {
            
            cell.textLabel.text = NSLocalizedString(@"Slide", nil);
            cell.accessoryType = [AlertExample sharedExample].animationStyle == VSAlertControllerAnimationStyleSlide ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
            
        }
        
        if (indexPath.row == 4) {
            
            cell.textLabel.text = NSLocalizedString(@"Flip", nil);
            cell.accessoryType = [AlertExample sharedExample].animationStyle == VSAlertControllerAnimationStyleFlip ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
            
        }
        
        if (indexPath.row == 5) {
            
            cell.textLabel.text = NSLocalizedString(@"Sticker", nil);
            cell.accessoryType = [AlertExample sharedExample].animationStyle == VSAlertControllerAnimationStyleSticker ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
            
        }
        
        if (indexPath.row == 6) {
            
            cell.textLabel.text = NSLocalizedString(@"Cross Disolve", nil);
            cell.accessoryType = [AlertExample sharedExample].animationStyle == VSAlertControllerAnimationStyleCrossDisolve ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
            
        }
        
        return cell;
        
    }
    
    return nil;
    
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 1) {
        
        if (indexPath.row == 0) {
            
            [AlertExample sharedExample].animationStyle = VSAlertControllerAnimationStyleAutomatic;
            
        }
        
        if (indexPath.row == 1) {
            
            [AlertExample sharedExample].animationStyle = VSAlertControllerAnimationStyleRise;
            
        }
        
        if (indexPath.row == 2) {
            
            [AlertExample sharedExample].animationStyle = VSAlertControllerAnimationStyleFlip;
            
        }
        
        if (indexPath.row == 3) {
            
            [AlertExample sharedExample].animationStyle = VSAlertControllerAnimationStyleSlide;
            
        }
        
        if (indexPath.row == 4) {
            
            [AlertExample sharedExample].animationStyle = VSAlertControllerAnimationStyleFlip;
            
        }
        
        if (indexPath.row == 5) {
            
            [AlertExample sharedExample].animationStyle = VSAlertControllerAnimationStyleSticker;
            
        }
        
        if (indexPath.row == 6) {
            
            [AlertExample sharedExample].animationStyle = VSAlertControllerAnimationStyleCrossDisolve;
            
        }
        
    }
    
    [tableView reloadData];
    
}


- (void)_editBackgroundTap:(UISwitch *)switchControl {
    
    [AlertExample sharedExample].dismissOnBackgroundTap = switchControl.on;
    [self.tableView reloadData];
    
}

#pragma mark - Actions

- (IBAction)close:(id)sender {
    
    [self.navigationController dismissViewControllerAnimated:YES
                                                  completion:nil];
    
}
@end
