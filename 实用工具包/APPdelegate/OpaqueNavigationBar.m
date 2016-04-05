//
//  OpaqueNavigationBar.m
//  实用工具包
//
//  Created by Ghoul on 16/1/8.
//  Copyright © 2016年 Ghoul. All rights reserved.
//

#import "OpaqueNavigationBar.h"
#import "AppDelegate+Helper.h"

static NSInteger const kLabWidth = 100;


@interface OpaqueNavigationBar ()

@property (strong, nonatomic) UINavigationItem *navItem;
@property (strong, nonatomic) UILabel *titleLab;
@property (strong, nonatomic) UIView *overlay;

@end

@implementation OpaqueNavigationBar

#pragma mark -
#pragma mark init methods
- (UIView *)overlay
{
    if (!_overlay) {
        _overlay = [[UIView alloc] initWithFrame:CGRectMake(0, -20, SCREEN_WIDTH, CGRectGetHeight(self.bounds) + 20)];
        _overlay.userInteractionEnabled = NO;
        _overlay.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    return _overlay;
}

- (UILabel *)titleLab
{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - kLabWidth)/2.0, 40, kLabWidth, 44)];
        _titleLab.textColor = [UIColor whiteColor];
        _titleLab.font = [UIFont systemFontOfSize:20];
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.backgroundColor = [UIColor clearColor];
    }
    return _titleLab;
}

#pragma mark -
#pragma mark lifecycle
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.navItem = [[UINavigationItem alloc] init];
        
        [self setShadowImage:[UIImage new]];
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        [self insertSubview:self.overlay atIndex:0];
        [self.overlay addSubview:self.titleLab];
        
        AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        UIViewController *controller = [delegate currentViewController];
        
        self.titleLab.text = controller.title;
    }
    return self;
}

- (void)setFrame:(CGRect)frame
{
    frame = CGRectMake(0, 0, SCREEN_WIDTH, 64);
    [super setFrame:frame];
}

- (void)setBarTintColor:(UIColor *)barTintColor
{
    [super setBarTintColor:barTintColor];
    
    self.overlay.backgroundColor = barTintColor;
}

- (void)setLeftItem:(UIBarButtonItem *)leftItem
{
    _leftItem = leftItem;
    [self.navItem setLeftBarButtonItem:_leftItem animated:YES];
    [self pushNavigationItem:self.navItem animated:YES];
}

- (void)setRightItem:(UIBarButtonItem *)rightItem
{
    _rightItem = rightItem;
    [self.navItem setRightBarButtonItem:_rightItem animated:YES];
    [self pushNavigationItem:self.navItem animated:YES];
}

#pragma mark -
#pragma mark action
- (void)setBackgroundAlpha:(CGFloat)alpha
{
    self.overlay.alpha = alpha;
//    NSLog(@"%@",self.overlay);
}

@end
