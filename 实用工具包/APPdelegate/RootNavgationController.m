//
//  RootNavgationController.m
//  实用工具包
//
//  Created by Ghoul on 16/1/8.
//  Copyright © 2016年 Ghoul. All rights reserved.
//

#import "RootNavgationController.h"

#define iOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)

@implementation RootNavgationController

#pragma mark 一个类只会调用一次
+ (void)initialize
{
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setBarTintColor:[UIColor navBGColor]];
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                           [UIColor whiteColor], NSForegroundColorAttributeName, [UIFont systemFontOfSize:20], NSFontAttributeName, nil]];
}

#pragma mark 控制状态栏的样式
#ifdef __IPHONE_7_0

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (BOOL)prefersStatusBarHidden
{
    return NO;
}
#endif

/**滑动隐藏时候实现的方法*/
//#define NAVBAR_CHANGE_POINT 64
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    CGFloat offsetY = scrollView.contentOffset.y;
//    
//    if (offsetY > NAVBAR_CHANGE_POINT) {
//        CGFloat alpha = 1 - ((NAVBAR_CHANGE_POINT + 64 - offsetY) / 64);
//        [self.navBar setBackgroundAlpha:alpha];
//    } else {
//        [self.navBar setBackgroundAlpha:0];
//    }
//}

/**需要收起的时候实现的方法*/
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    if (flag) {
//        return;
//    }
//    
//    CGFloat offsetY = scrollView.contentOffset.y;
//    
//    if (offsetY > 0) {
//        if (offsetY >= 44) {
//            [self.navigationController.navigationBar setTransformProgress:1];
//        } else {
//            [self.navigationController.navigationBar setTransformProgress:(offsetY / 44)];
//        }
//    } else {
//        [self.navigationController.navigationBar setTransformProgress:0];
//    }
//}

@end
