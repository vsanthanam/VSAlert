//
//  VSAlertAction.m
//  VSAlertController
//
//  Created by Varun Santhanam on 10/8/17.
//

#import "VSAlertAction.h"

@implementation VSAlertAction

@synthesize style = _style;
@synthesize action = _action;

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
        
    }
    
    return self;
    
}

@end
