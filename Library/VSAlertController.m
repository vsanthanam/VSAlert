//
//  VSAlertController.m
//  VSAlertController
//
//  Created by Varun Santhanam on 10/8/17.
//

@import CoreGraphics;

#import "VSAlertController.h"

NSString * const VSAlertActionNotImplementedException = @"VSAlertActionNotImplementedException";

@interface VSAlertController ()<UITextFieldDelegate>

@property (NS_NONATOMIC_IOSONLY, strong) UIImageView *alertMaskBackground;
@property (NS_NONATOMIC_IOSONLY, strong) UIView *alertView;
@property (NS_NONATOMIC_IOSONLY, strong) NSLayoutConstraint *alertViewWidthConstraint;
@property (NS_NONATOMIC_IOSONLY, strong) UIView *headerView;
@property (NS_NONATOMIC_IOSONLY, strong) NSLayoutConstraint *headerViewHeightConstraint;
@property (NS_NONATOMIC_IOSONLY, strong) UIImageView *alertImage;
@property (NS_NONATOMIC_IOSONLY, strong) UILabel *alertTitle;
@property (NS_NONATOMIC_IOSONLY, strong) UILabel *alertDescription;
@property (NS_NONATOMIC_IOSONLY, strong) UIStackView *alertActionStackView;
@property (NS_NONATOMIC_IOSONLY, strong) NSLayoutConstraint *alertStackViewHeightConstraint;
@property (NS_NONATOMIC_IOSONLY, strong) UITapGestureRecognizer *tapRecognizer;

@property (NS_NONATOMIC_IOSONLY, readonly) CGFloat alertStackViewHeight;
@property (NS_NONATOMIC_IOSONLY, readonly) BOOL hasTextFieldAdded;

@end

@implementation VSAlertController {
    
    NSString *_title;
    NSString *_description;
    UIImage *_image;
    VSAlertControllerStyle _style;
    
    UIDynamicAnimator *_animator;
    NSArray<VSAlertAction *> *_defaultActions;
    NSArray<VSAlertAction *> *_destructiveActions;
    NSArray<VSAlertAction *> *_cancelActions;
    BOOL _gravityDismissAnimation;
    BOOL _dismissWithBackgroundTouch;
    
    CGPoint _tempFrameOrigin;
    BOOL _keyboardHasBeenShown;
    
}

@synthesize textFields = _textFields;

#pragma mark - Public Class Methods

+ (instancetype)alertControllerWithTitle:(NSString *)title description:(NSString *)description image:(UIImage *)image style:(VSAlertControllerStyle)style {
    
    VSAlertController *alertController = [[self alloc] initWithTitle:title
                                                         description:description
                                                               image:image
                                                               style:style];

    return alertController;
    
}

#pragma mark - Overridden Instance Methods

- (void)viewDidLoad {

    if (_style == VSAlertControllerStyleActionSheet) {
        
        [NSException raise:VSAlertActionNotImplementedException format:@"Action Sheet Style Not Yet Implemented"];
        
        return;
        
    }
    
    [self _setUpAlertControllerUI];
    
    // Configure Text
    self.alertTitle.text = _title;
    self.alertDescription.text = _description;
    _title = nil;
    _description = nil;
    
    // Configure Image
    self.alertImage.image = _image;
    _image = nil;
    
    // Configure Constraints
    self.headerViewHeightConstraint.constant = (BOOL)self.alertImage.image ? self.headerViewHeightConstraint.constant : 0.0f;
    self.alertViewWidthConstraint.constant = _style == VSAlertControllerStyleAlert ? 270.0f : [UIScreen mainScreen].bounds.size.width - 36.0f;
    
    // Set Up Background Tap Gesture Recognizer
    self.tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                 action:@selector(_dismissAlertControllerFromBackgroundTap)];
    [self.alertMaskBackground addGestureRecognizer:self.tapRecognizer];
    
    // Process Text Fields
    [self _processTextFields];
    
    // Process Actions
    [self _processActions];
    
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(_keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(_keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    NSLog(@"%@", NSStringFromCGRect(self.alertActionStackView.frame));
}

- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
}

#pragma mark - Property Access Methods

- (BOOL)hasTextFieldAdded {
    
    return self.textFields.count > 0;
    
}

- (CGFloat)alertStackViewHeight {
    
    return [UIScreen mainScreen].bounds.size.height < 580.0f ? 40.0f : 62.0f;
    
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return YES;
    
}

#pragma mark - Public Instance Methods

- (instancetype)initWithTitle:(NSString *)title description:(NSString *)description image:(UIImage *)image style:(VSAlertControllerStyle)style {
    
    self = [super init];
    
    if (self) {
        
        [self _setUpAlertController];
        
        _keyboardHasBeenShown = NO;
        _gravityDismissAnimation = YES;
        _dismissWithBackgroundTouch = NO;
        _tempFrameOrigin = CGPointMake(0.0f, 0.0f);
        _textFields = [[NSArray<UITextField *> alloc] init];
        _defaultActions = [[NSArray<VSAlertAction *> alloc] init];
        _destructiveActions = [[NSArray<VSAlertAction *> alloc] init];
        _cancelActions = [[NSArray<VSAlertAction *> alloc] init];
        
        _title = title;
        _description = description;
        _image = image;
        _style = style;
        
    }
    
    return self;
    
}

- (void)addAction:(VSAlertAction *)alertAction {
    
    if (alertAction.style == VSAlertActionStyleDefault) {
        
        _defaultActions = [_defaultActions arrayByAddingObject:alertAction];
        
    } else if (alertAction.style == VSAlertActionStyleDestructive) {
        
        _destructiveActions = [_destructiveActions arrayByAddingObject:alertAction];
        
    } else if (alertAction.style == VSAlertActionStyleCancel) {
        
        _cancelActions = [_cancelActions arrayByAddingObject:alertAction];
        
    }

}

- (void)addTextField:(void (^)(UITextField *))configuration {
    
    UITextField *textField = [[UITextField alloc] init];
    textField.delegate = self;
    textField.returnKeyType = UIReturnKeyDone;
    textField.font = [UIFont systemFontOfSize:17.0f];
    textField.textAlignment = NSTextAlignmentCenter;
    configuration(textField);
    
    _textFields = [_textFields arrayByAddingObject:textField];
    
//    [self _addTextField:textField];
    
}

#pragma mark - Private Instance Methods

- (void)_setUpAlertController {
    
    self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
}

- (void)_setUpAlertControllerUI {
    
    [self _setUpAlertMaskBackground];
    [self _setUpAlertView];
    [self _setUpHeaderView];
    [self _setUpAlertImage];
    [self _setUpAlertTitle];
    [self _setUpAlertDescription];
    [self _setUpAlertActionStackView];
    
}

- (void)_setUpAlertMaskBackground {
    
    self.alertMaskBackground = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.alertMaskBackground.backgroundColor = [UIColor colorWithRed:(85.0f/255.0f) green:(85.0f/255.0f) blue:(85.0f/255.0f) alpha:0.15f];
    self.alertMaskBackground.translatesAutoresizingMaskIntoConstraints = NO;
    self.alertMaskBackground.userInteractionEnabled = YES;
    
    [self.view addSubview:self.alertMaskBackground];
    
    [self.view addConstraints:@[[NSLayoutConstraint constraintWithItem:self.alertMaskBackground
                                                             attribute:NSLayoutAttributeWidth
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.view
                                                             attribute:NSLayoutAttributeWidth
                                                            multiplier:1.0f
                                                              constant:0.0f],
                                [NSLayoutConstraint constraintWithItem:self.alertMaskBackground
                                                             attribute:NSLayoutAttributeHeight
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.view
                                                             attribute:NSLayoutAttributeHeight
                                                            multiplier:1.0f
                                                              constant:0.0f],
                                [NSLayoutConstraint constraintWithItem:self.alertMaskBackground
                                                             attribute:NSLayoutAttributeCenterX
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.view
                                                             attribute:NSLayoutAttributeCenterX
                                                            multiplier:1.0f
                                                              constant:0.0f],
                                [NSLayoutConstraint constraintWithItem:self.alertMaskBackground
                                                             attribute:NSLayoutAttributeCenterY
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.view
                                                             attribute:NSLayoutAttributeCenterY
                                                            multiplier:1.0f
                                                              constant:0.0f]]];
    
}

- (void)_setUpAlertView {
    
    self.alertView = [[UIView alloc] initWithFrame:CGRectZero];
    self.alertView.backgroundColor = [UIColor whiteColor];
    self.alertView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.alertMaskBackground addSubview:self.alertView];
    
    self.alertView.layer.cornerRadius = 5.0f;
    self.alertView.layer.masksToBounds = NO;
    self.alertView.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    self.alertView.layer.shadowRadius = 8.0f;
    self.alertView.layer.shadowOpacity = 0.3f;
    
    [self.view addConstraints:@[[NSLayoutConstraint constraintWithItem:self.alertView
                                                             attribute:NSLayoutAttributeCenterX
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.view
                                                             attribute:NSLayoutAttributeCenterX
                                                            multiplier:1.0f
                                                              constant:0.0f],
                                [NSLayoutConstraint constraintWithItem:self.alertView
                                                             attribute:NSLayoutAttributeCenterY
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.view
                                                             attribute:NSLayoutAttributeCenterY
                                                            multiplier:1.0f
                                                              constant:0.0f],
                                [NSLayoutConstraint constraintWithItem:self.alertView
                                                             attribute:NSLayoutAttributeHeight
                                                             relatedBy:NSLayoutRelationGreaterThanOrEqual
                                                                toItem:nil
                                                             attribute:NSLayoutAttributeHeight
                                                            multiplier:0.0f
                                                              constant:100.0f]]];
    
    self.alertViewWidthConstraint = [NSLayoutConstraint constraintWithItem:self.alertView
                                                                 attribute:NSLayoutAttributeWidth
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:nil
                                                                 attribute:NSLayoutAttributeWidth
                                                                multiplier:0.0f
                                                                  constant:357.0f];
    
    [self.view addConstraint:self.alertViewWidthConstraint];
    
}

- (void)_setUpHeaderView {
    
    self.headerView = [[UIView alloc] initWithFrame:CGRectZero];
    self.headerView.backgroundColor = [UIColor whiteColor];
    self.headerView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.alertView addSubview:self.headerView];
    
    [self.alertView addConstraints:@[[NSLayoutConstraint constraintWithItem:self.headerView
                                                                  attribute:NSLayoutAttributeTop
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:self.alertView
                                                                  attribute:NSLayoutAttributeTop
                                                                 multiplier:1.0f
                                                                   constant:8.0f],
                                     [NSLayoutConstraint constraintWithItem:self.headerView
                                                                  attribute:NSLayoutAttributeLeft
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:self.alertView
                                                                  attribute:NSLayoutAttributeLeft
                                                                 multiplier:1.0f
                                                                   constant:0.0f],
                                     [NSLayoutConstraint constraintWithItem:self.headerView
                                                                  attribute:NSLayoutAttributeRight
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:self.alertView
                                                                  attribute:NSLayoutAttributeRight
                                                                 multiplier:1.0f
                                                                   constant:0.0f]]];
    self.headerViewHeightConstraint = [NSLayoutConstraint constraintWithItem:self.headerView
                                                                   attribute:NSLayoutAttributeHeight
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:nil
                                                                   attribute:NSLayoutAttributeHeight
                                                                  multiplier:0.0f
                                                                    constant:180.0f];
    
    [self.alertView addConstraint:self.headerViewHeightConstraint];
    
}

- (void)_setUpAlertImage {
    
    self.alertImage = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.alertImage.translatesAutoresizingMaskIntoConstraints = NO;

    [self.headerView addSubview:self.alertImage];
    
    [self.headerView addConstraints:@[[NSLayoutConstraint constraintWithItem:self.alertImage
                                                                   attribute:NSLayoutAttributeTop
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self.headerView
                                                                   attribute:NSLayoutAttributeTop
                                                                  multiplier:1.0f
                                                                    constant:0.0f],
                                      [NSLayoutConstraint constraintWithItem:self.alertImage
                                                                   attribute:NSLayoutAttributeLeft
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self.headerView
                                                                   attribute:NSLayoutAttributeLeft
                                                                  multiplier:1.0f
                                                                    constant:0.0f],
                                      [NSLayoutConstraint constraintWithItem:self.alertImage
                                                                   attribute:NSLayoutAttributeRight
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self.headerView
                                                                   attribute:NSLayoutAttributeRight
                                                                  multiplier:1.0f
                                                                    constant:0.0f],
                                      [NSLayoutConstraint constraintWithItem:self.alertImage
                                                                   attribute:NSLayoutAttributeBottom
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self.headerView
                                                                   attribute:NSLayoutAttributeBottom
                                                                  multiplier:1.0f
                                                                    constant:0.0f]]];
    
}

- (void)_setUpAlertTitle {
 
    self.alertTitle = [[UILabel alloc] init];
    self.alertTitle.font = [UIFont systemFontOfSize:17.0f weight:UIFontWeightBold];
    self.alertTitle.textColor = [UIColor blackColor];
    self.alertTitle.numberOfLines = 0;
    self.alertTitle.textAlignment = NSTextAlignmentCenter;
    self.alertTitle.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.alertView addSubview:self.alertTitle];
    
    [self.alertView addConstraints:@[[NSLayoutConstraint constraintWithItem:self.alertTitle
                                                                  attribute:NSLayoutAttributeTop
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:self.headerView
                                                                  attribute:NSLayoutAttributeBottom
                                                                 multiplier:1.0f
                                                                   constant:10.0f],
                                     [NSLayoutConstraint constraintWithItem:self.alertTitle
                                                                  attribute:NSLayoutAttributeLeft
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:self.alertView
                                                                  attribute:NSLayoutAttributeLeft
                                                                 multiplier:1.0f
                                                                   constant:8.0f],
                                     [NSLayoutConstraint constraintWithItem:self.alertTitle
                                                                  attribute:NSLayoutAttributeRight
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:self.alertView
                                                                  attribute:NSLayoutAttributeRight
                                                                 multiplier:1.0f
                                                                   constant:-8.0f],
                                     [NSLayoutConstraint constraintWithItem:self.alertTitle
                                                                  attribute:NSLayoutAttributeHeight
                                                                  relatedBy:NSLayoutRelationGreaterThanOrEqual
                                                                     toItem:nil
                                                                  attribute:NSLayoutAttributeHeight
                                                                 multiplier:0.0f
                                                                   constant:23.0f]]];
    
}

- (void)_setUpAlertDescription {
    
    self.alertDescription = [[UILabel alloc] init];
    self.alertDescription.font = [UIFont systemFontOfSize:15.0f weight:UIFontWeightRegular];
    self.alertDescription.textColor = [UIColor blackColor];
    self.alertDescription.numberOfLines = 0;
    self.alertDescription.textAlignment = NSTextAlignmentCenter;
    self.alertDescription.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.alertView addSubview:self.alertDescription];
    
    [self.alertView addConstraints:@[[NSLayoutConstraint constraintWithItem:self.alertDescription
                                                                  attribute:NSLayoutAttributeTop
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:self.alertTitle
                                                                  attribute:NSLayoutAttributeBottom
                                                                 multiplier:1.0f
                                                                   constant:8.0f],
                                     [NSLayoutConstraint constraintWithItem:self.alertDescription
                                                                  attribute:NSLayoutAttributeLeft
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:self.alertView
                                                                  attribute:NSLayoutAttributeLeft
                                                                 multiplier:1.0f
                                                                   constant:0.0f],
                                     [NSLayoutConstraint constraintWithItem:self.alertDescription
                                                                  attribute:NSLayoutAttributeRight
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:self.alertView
                                                                  attribute:NSLayoutAttributeRight
                                                                 multiplier:1.0f
                                                                   constant:0.0f],
                                     [NSLayoutConstraint constraintWithItem:self.alertDescription
                                                                  attribute:NSLayoutAttributeHeight
                                                                  relatedBy:NSLayoutRelationGreaterThanOrEqual
                                                                     toItem:nil
                                                                  attribute:NSLayoutAttributeHeight
                                                                 multiplier:0.0f
                                                                   constant:21.0f]]];
    
}

- (void)_setUpAlertActionStackView {
    
    self.alertActionStackView = [[UIStackView alloc] initWithFrame:CGRectZero];
    self.alertActionStackView.distribution = UIStackViewDistributionFillEqually;
    self.alertActionStackView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.alertView addSubview:self.alertActionStackView];
    
    [self.alertView addConstraints:@[[NSLayoutConstraint constraintWithItem:self.alertActionStackView
                                                                  attribute:NSLayoutAttributeTop
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:self.alertDescription
                                                                  attribute:NSLayoutAttributeBottom
                                                                 multiplier:1.0f
                                                                   constant:8.0f],
                                     [NSLayoutConstraint constraintWithItem:self.alertActionStackView
                                                                  attribute:NSLayoutAttributeRight
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:self.alertView
                                                                  attribute:NSLayoutAttributeRight
                                                                 multiplier:1.0f
                                                                   constant:0.0f],
                                     [NSLayoutConstraint constraintWithItem:self.alertActionStackView
                                                                  attribute:NSLayoutAttributeLeft
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:self.alertView
                                                                  attribute:NSLayoutAttributeLeft
                                                                 multiplier:1.0f
                                                                   constant:0.0f],
                                     [NSLayoutConstraint constraintWithItem:self.alertActionStackView
                                                                  attribute:NSLayoutAttributeBottom
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:self.alertView
                                                                  attribute:NSLayoutAttributeBottom
                                                                 multiplier:1.0f
                                                                   constant:0.0f]]];
    
    self.alertStackViewHeightConstraint = [NSLayoutConstraint constraintWithItem:self.alertActionStackView
                                                                       attribute:NSLayoutAttributeHeight
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:nil
                                                                       attribute:NSLayoutAttributeHeight
                                                                      multiplier:0.0f
                                                                        constant:60.0f];
    [self.alertView addConstraint:self.alertStackViewHeightConstraint];
    
}

- (void)_dismissAlertController:(VSAlertAction *)sender {
    
    [self _animateDismissWithGravityForStyle:sender.style];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)_dismissAlertControllerFromBackgroundTap {
    
    if (!_dismissWithBackgroundTouch) {
        
        return;
        
    }
    
    [self _animateDismissWithGravityForStyle:VSAlertActionStyleCancel];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)_addTextField:(UITextField *)textField {
    
    [self.alertActionStackView addArrangedSubview:textField];
    self.alertStackViewHeightConstraint.constant = self.alertStackViewHeight * ((CGFloat)self.alertActionStackView.arrangedSubviews.count);
    self.alertActionStackView.axis = UILayoutConstraintAxisVertical;
    
//    _textFields = [_textFields arrayByAddingObject:textField];
    
}

- (void)_animateDismissWithGravityForStyle:(VSAlertActionStyle)style {
    
    if (_gravityDismissAnimation) {
        
        double radian = (style == VSAlertActionStyleCancel) ? (-2.0f * M_PI) : (2.0f * M_PI);
        
        _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
        
        UIGravityBehavior *gravityBehavior = [[UIGravityBehavior alloc] initWithItems:@[self.alertView]];
        gravityBehavior.gravityDirection = CGVectorMake(0.0f, 10.0f);
        
        [_animator addBehavior:gravityBehavior];
        
        UIDynamicItemBehavior *itemBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[self.alertView]];
        [itemBehavior addAngularVelocity:radian forItem:self.alertView];
        [_animator addBehavior:itemBehavior];

    }
    
}

- (void)_keyboardWillShow:(NSNotification *)notif {
    
    _keyboardHasBeenShown = YES;
    
    NSDictionary *userInfo = notif.userInfo;
    double endKeyBoardFrame = CGRectGetMinY(((NSValue *)userInfo[UIKeyboardFrameEndUserInfoKey]).CGRectValue);
    
    if (_tempFrameOrigin.x == 0.0f && _tempFrameOrigin.y == 0.0f) {
        
        _tempFrameOrigin = self.alertView.frame.origin;
        
    }
    
    double newContentFrameY = CGRectGetMaxY(self.alertView.frame) - endKeyBoardFrame;
    
    if (newContentFrameY < 0.0f) {
        
        newContentFrameY = 0.0f;
        
    }
    
    self.alertView.frame = CGRectMake(self.alertView.frame.origin.x,
                                      self.alertView.frame.origin.y - newContentFrameY,
                                      self.alertView.frame.size.width,
                                      self.alertView.frame.size.height);
    
}

- (void)_keyboardWillHide:(NSNotification *)notif {
    
    if (_keyboardHasBeenShown) {
        
        if (_tempFrameOrigin.x != 0.0f || _tempFrameOrigin.y != 0.0f) {
            
            self.alertView.frame = CGRectMake(self.alertView.frame.origin.x,
                                              _tempFrameOrigin.y,
                                              self.alertView.frame.size.width,
                                              self.alertView.frame.size.height);
            
            _tempFrameOrigin = CGPointMake(0.0f, 0.0f);
            
        }
        
        _keyboardHasBeenShown = NO;
        
    }
    
}

- (void)_processTextFields {
    
    for (UITextField *textField in self.textFields) {
        
        [self _addTextField:textField];
        
    }

}

- (void)_processActions {
    
    for (VSAlertAction *alertAction in _defaultActions) {
        
        [self.alertActionStackView addArrangedSubview:alertAction];
        
        if (self.alertActionStackView.arrangedSubviews.count > 2 || self.hasTextFieldAdded) {
            
            self.alertStackViewHeightConstraint.constant = self.alertStackViewHeight * ((CGFloat)self.alertActionStackView.arrangedSubviews.count);
            self.alertActionStackView.axis = UILayoutConstraintAxisVertical;
            
        } else {
            
            self.alertStackViewHeightConstraint.constant= self.alertStackViewHeight;
            self.alertActionStackView.axis = UILayoutConstraintAxisHorizontal;
            
        }
        
        [alertAction addTarget:self
                        action:@selector(_tappedAction:)
              forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    for (VSAlertAction *alertAction in _destructiveActions) {
        
        [self.alertActionStackView addArrangedSubview:alertAction];
        
        if (self.alertActionStackView.arrangedSubviews.count > 2 || self.hasTextFieldAdded) {
            
            self.alertStackViewHeightConstraint.constant = self.alertStackViewHeight * ((CGFloat)self.alertActionStackView.arrangedSubviews.count);
            self.alertActionStackView.axis = UILayoutConstraintAxisVertical;
            
        } else {
            
            self.alertStackViewHeightConstraint.constant= self.alertStackViewHeight;
            self.alertActionStackView.axis = UILayoutConstraintAxisHorizontal;
            
        }
        
        [alertAction addTarget:self
                        action:@selector(_tappedAction:)
              forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    for (VSAlertAction *alertAction in _cancelActions) {
        
        [self.alertActionStackView addArrangedSubview:alertAction];
        
        if (self.alertActionStackView.arrangedSubviews.count > 2 || self.hasTextFieldAdded) {
            
            self.alertStackViewHeightConstraint.constant = self.alertStackViewHeight * ((CGFloat)self.alertActionStackView.arrangedSubviews.count);
            self.alertActionStackView.axis = UILayoutConstraintAxisVertical;
            
        } else {
            
            self.alertStackViewHeightConstraint.constant= self.alertStackViewHeight;
            self.alertActionStackView.axis = UILayoutConstraintAxisHorizontal;
    
        }
        
        [alertAction addTarget:self
                        action:@selector(_tappedAction:)
              forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    _defaultActions = nil;
    _destructiveActions = nil;
    _cancelActions = nil;
    
}

- (void)_tappedAction:(VSAlertAction *)sender {
    
    if (sender.action) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            sender.action(sender);
            
        });
        
    }
    
    [self _dismissAlertController:sender];
    
}

@end
