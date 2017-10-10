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

// Class variables
static UIFont *_actionTitleTextFont;
static UIFont *_cancelActionTitleTextFont;
static UIColor *_actionTextColor;
static UIColor *_destructiveActionTextColor;

// Explicitly synthesize ivars from header
@synthesize style = _style;
@synthesize action = _action;

// Explicitly syenthesize ivars from extension
@synthesize separator = _separator;

#pragma mark - Overridden Class Methods

+ (void)initialize {
    
}

#pragma mark - Class Property Access Methods

+ (UIFont *)actionTitleTextFont {
    
    return _actionTitleTextFont;
    
}

+ (void)setActionTitleTextFont:(UIFont *)actionTitleTextFont {
    
    _actionTitleTextFont = actionTitleTextFont;
    
}

+ (UIFont *)cancelActionTitleTextFont {
    
    return _cancelActionTitleTextFont;
    
}

+ (void)setCancelActionTitleTextFont:(UIFont *)cancelActionTitleTextFont {
    
    _cancelActionTitleTextFont = cancelActionTitleTextFont;
    
}

+ (UIColor *)actionTextColor {
    
    return _actionTextColor;
    
}

+ (void)setActionTextColor:(UIColor *)actionTextColor {
    
    _actionTextColor = actionTextColor;
    
}

+ (UIColor *)destructiveActionTextColor {
    
    return _destructiveActionTextColor;
    
}

+ (void)setDestructiveActionTextColor:(UIColor *)destructiveActionTextColor {
    
    _destructiveActionTextColor = destructiveActionTextColor;
    
}

#pragma mark - Public Class Methods

+ (instancetype)alertActionWithTitle:(NSString *)title style:(VSAlertActionStyle)style action:(void (^)(VSAlertAction * _Nonnull))action {
    
    return [[self alloc] initWithTitle:title
                                 style:style
                                action:action];
    
}

+ (void)resetStyleToDefaults {
    
    self.actionTitleTextFont = nil;
    self.cancelActionTitleTextFont = nil;
    self.actionTextColor = nil;
    self.destructiveActionTextColor = nil;
    
}

#pragma mark - Overridden Instance Methods

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    return self;
    
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super initWithCoder:aDecoder];
    
    return self;
    
}

#pragma mark - Public Instance Methods

- (instancetype)initWithTitle:(NSString *)title style:(VSAlertActionStyle)style action:(void (^)(VSAlertAction * _Nonnull))action {
    
    self = [super initWithFrame:CGRectZero];
    
    if (self) {
        
        _style = style;
        _action = action;
        
        [self setTitle:title forState:UIControlStateNormal];
        
        UIColor *color = [self class].actionTextColor ? [self class].actionTextColor : self.tintColor;
        UIColor *destructiveColor = [self class].destructiveActionTextColor ? [self class].destructiveActionTextColor : [UIColor redColor];
        [self setTitleColor:self.style == VSAlertActionStyleDestructive ? destructiveColor : color forState:UIControlStateNormal];
        
        UIFont *font = [self class].actionTitleTextFont ? [self class].actionTitleTextFont : [UIFont systemFontOfSize:17.0f weight:UIFontWeightRegular];
        UIFont *cancelFont = [self class].cancelActionTitleTextFont ? [self class].cancelActionTitleTextFont : [UIFont systemFontOfSize:17.0f weight:UIFontWeightSemibold];
        self.titleLabel.font = self.style == VSAlertActionStyleCancel ? cancelFont : font;
        
        [self _addSeparator];
        
    }
    
    return self;
    
}

#pragma mark - Private Instance Methods

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
