//
//  VSAlertAction.m
//  VSAlertController
//
//  Created by Varun Santhanam on 10/8/17.
//

#import "VSAlertAction.h"

@interface VSAlertAction ()

@property (nonatomic, strong) UIImageView *separator;

@end

@implementation VSAlertAction

@synthesize style = _style;
@synthesize action = _action;

@synthesize separator = _separator;

#pragma mark - Public Class Methods

+ (instancetype)alertActionWithTitle:(NSString *)title style:(VSAlertActionStyle)style action:(void (^)(VSAlertAction * _Nonnull))action {
    
    return [[self alloc] initWithTitle:title
                                 style:style
                                action:action];
    
}

#pragma mark - Public Instance Methods

- (instancetype)initWithTitle:(NSString *)title style:(VSAlertActionStyle)style action:(void (^)(VSAlertAction * _Nonnull))action {
    
    self = [super init];
    
    if (self) {
        
        _style = style;
        _action = action;
        
        [self setTitle:title forState:UIControlStateNormal];
        [self setTitleColor:self.style == VSAlertActionStyleDestructive ? [UIColor redColor] : self.tintColor forState:UIControlStateNormal];
        self.titleLabel.font = self.style == VSAlertActionStyleCancel ? [UIFont systemFontOfSize:17.0f weight:UIFontWeightSemibold] : [UIFont systemFontOfSize:17.0f weight:UIFontWeightRegular];
        
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
