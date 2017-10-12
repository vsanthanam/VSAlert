//
//  VSAlertAction.m
//  VSAlertController
//
//  Created by Varun Santhanam on 10/8/17.
//

#import "VSAlertAction.h"

@interface VSAlertAction ()

@property (NS_NONATOMIC_IOSONLY, strong) UIImageView *separator;

// Redesignate initializers so you can call 'super'
- (instancetype)initWithFrame:(CGRect)frame NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_DESIGNATED_INITIALIZER;

@end

@implementation VSAlertAction

// Explicitly synthesize ivars from header
@synthesize actionTextColor = _actionTextColor;
@synthesize destructiveActionTextColor = _destructiveActionTextColor;
@synthesize actionTextFont = _actionTextFont;
@synthesize cancelActionTextFont = _cancelActionTextFont;
@synthesize alertTitle = _alertTitle;
@synthesize style = _style;
@synthesize action = _action;

// Explicitly syenthesize ivars from extension
@synthesize separator = _separator;

#pragma mark - Public Class Methods

+ (instancetype)alertActionWithTitle:(NSString *)title style:(VSAlertActionStyle)style action:(void (^)(VSAlertAction * _Nonnull))action {
    
    return [[self alloc] initWithTitle:title
                                 style:style
                                action:action];
    
}

#pragma mark - Overridden Instance Methods

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        _style = VSAlertActionStyleDefault;
        _action = nil;
        _alertTitle = @"";
        
        [self _setUpAlertAction];
        
    }
    
    return self;
    
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        
        _style = VSAlertActionStyleDefault;
        _action = nil;
        _alertTitle = @"";
        
        [self _setUpAlertAction];
        
    }
    
    return self;
    
}

#pragma mark - Property Access Methods

- (UIColor *)actionTextColor {
    
    return _actionTextColor;
    
}

- (void)setActionTextColor:(UIColor * _Nonnull)actionTextColor {
    
    _actionTextColor = actionTextColor;
    
    if (self.style != VSAlertActionStyleDestructive) {
        
        [self setTitleColor:self.actionTextColor forState:UIControlStateNormal];
        [self setTitleColor:[self.actionTextColor colorWithAlphaComponent:0.5f] forState:UIControlStateHighlighted];
        
    }
    
}

- (UIColor *)destructiveActionTextColor {
    
    return _destructiveActionTextColor;
    
}

- (void)setDestructiveActionTextColor:(UIColor * _Nonnull)destructiveActionTextColor {
 
    _destructiveActionTextColor = destructiveActionTextColor;
    
    if (self.style == VSAlertActionStyleDestructive) {
        
        [self setTitleColor:self.destructiveActionTextColor forState:UIControlStateNormal];
        [self setTitleColor:[self.destructiveActionTextColor colorWithAlphaComponent:0.5f] forState:UIControlStateHighlighted];
        
    }
    
}

- (UIFont *)actionTextFont {
    
    return _actionTextFont;
    
}

- (void)setActionTextFont:(UIFont *)actionTextFont {
    
    _actionTextFont = actionTextFont;
    
    if (self.style != VSAlertActionStyleCancel) {
        
        self.titleLabel.font = self.actionTextFont;
        
    }
    
}

- (UIFont *)cancelActionTextFont {
    
    return _cancelActionTextFont;
    
}

- (void)setCancelActionTextFont:(UIFont *)cancelActionTextFont {
    
    _cancelActionTextFont = cancelActionTextFont;
    
    if (self.style == VSAlertActionStyleCancel) {
        
        self.titleLabel.font = self.cancelActionTextFont;
        
    }
    
}

#pragma mark - Public Instance Methods

- (instancetype)initWithTitle:(NSString *)title style:(VSAlertActionStyle)style action:(void (^)(VSAlertAction * _Nonnull))action {
    
    self = [super initWithFrame:CGRectZero];
    
    if (self) {

        _style = style;
        _action = action;
        _alertTitle = title;
        
        [self _setUpAlertAction];
        
    }
    
    return self;
    
}

#pragma mark - Private Instance Methods

- (void)_setUpAlertAction {
    
    _actionTextColor = self.tintColor;
    _destructiveActionTextColor = [UIColor redColor];
    _actionTextFont = [UIFont systemFontOfSize:17.0f weight:UIFontWeightRegular];
    
    [self setTitle:self.alertTitle forState:UIControlStateNormal];
    
    [self setTitleColor:self.style == VSAlertActionStyleDestructive ? _destructiveActionTextColor : _actionTextColor forState:UIControlStateNormal];
    [self setTitleColor:self.style == VSAlertActionStyleDestructive ? [_destructiveActionTextColor colorWithAlphaComponent:0.5f] : [_actionTextColor colorWithAlphaComponent:0.5f] forState:UIControlStateHighlighted];

    self.titleLabel.font = self.style == VSAlertActionStyleCancel ? [UIFont systemFontOfSize:17.0f weight:UIFontWeightSemibold] : _actionTextFont;
    
    [self _addSeparator];
    
}

- (void)_addSeparator {
    
    self.separator = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.separator.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.2f];
    self.separator.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addSubview:self.separator];
    
    [self addConstraints:@[[NSLayoutConstraint constraintWithItem:self.separator
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeTop
                                                       multiplier:1.0f
                                                         constant:0.0f],
                           [NSLayoutConstraint constraintWithItem:self.separator
                                                        attribute:NSLayoutAttributeLeft
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeLeft
                                                       multiplier:1.0f
                                                         constant:8.0f],
                           [NSLayoutConstraint constraintWithItem:self.separator
                                                        attribute:NSLayoutAttributeRight
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeRight
                                                       multiplier:1.0f
                                                         constant:-8.0f],
                           [NSLayoutConstraint constraintWithItem:self.separator
                                                        attribute:NSLayoutAttributeHeight
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:nil
                                                        attribute:NSLayoutAttributeHeight
                                                       multiplier:0.0f
                                                         constant:1.0f]]];
    
    
}

@end
