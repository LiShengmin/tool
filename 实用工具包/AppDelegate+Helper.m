//
//  AppDelegate+Helper.m
//  实用工具包
//
//  Created by Ghoul on 16/1/8.
//  Copyright © 2016年 Ghoul. All rights reserved.
//

#import "AppDelegate+Helper.h"

@implementation AppDelegate (Helper)

- (UIViewController*) topMostController {
    UIViewController *topController = [self.window rootViewController];
    
    while ([topController presentedViewController])	topController = [topController presentedViewController];
    
    return topController;
}

- (UIViewController*)currentViewController {
    UIViewController *currentViewController = [self topMostController];
    
    while ([currentViewController isKindOfClass:[UINavigationController class]] && [(UINavigationController*)currentViewController topViewController])
        
        currentViewController = [(UINavigationController*)currentViewController topViewController];
    
    return currentViewController;
}

@end
