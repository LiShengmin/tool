//
//  UINavigationBar+Helper.m
//  实用工具包
//
//  Created by Ghoul on 16/1/8.
//  Copyright © 2016年 Ghoul. All rights reserved.
//

#import "UINavigationBar+Helper.h"
#import "AppDelegate+Helper.h"
#import <objc/runtime.h>

@implementation UINavigationBar (Helper)

static char overlayKey;

- (UIView *)overlay
{
    return objc_getAssociatedObject(self, &overlayKey);
}

- (void)setOverlay:(UIView *)overlay
{
    objc_setAssociatedObject(self, &overlayKey, overlay, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setNavBackgroundColor:(UIColor *)backgroundColor
{
    [self setBackIndicatorImage:[UIImage new]];
    [self setBackIndicatorTransitionMaskImage:[UIImage new]];
    [self setShadowImage:[UIImage new]];
    [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    
    self.overlay = [[UIView alloc] initWithFrame:CGRectMake(0, -20, SCREEN_WIDTH, CGRectGetHeight(self.bounds) + 20)];
    self.overlay.userInteractionEnabled = NO;
    self.overlay.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self insertSubview:self.overlay atIndex:0];
    
    self.overlay.backgroundColor = backgroundColor;
}

- (void)setTransformProgress:(CGFloat)progress
{
    
    if (!self.overlay) {
        [self setNavBackgroundColor:[UIColor navBGColor]];
    }
    
    self.transform = CGAffineTransformMakeTranslation(0, -44 * progress);
    [self setAlpha:(1 - progress) forSubviewsOfView:self];
}

- (void)setAlpha:(CGFloat)alpha forSubviewsOfView:(UIView *)view
{
    for (UIView *subview in view.subviews) {
        if (subview == self.overlay) {
            continue;
        }
        subview.alpha = alpha;
        [self setAlpha:alpha forSubviewsOfView:subview];
    }
}

- (void)reset
{
    [self setTransformProgress:0];
    [self setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self setShadowImage:nil];
    
    [self.overlay removeFromSuperview];
    self.overlay = nil;
}

@end
