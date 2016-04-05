//
//  UIBarButtonItem+Helper.h
//  实用工具包
//
//  Created by Ghoul on 16/1/8.
//  Copyright © 2016年 Ghoul. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Helper)

- (id)initWithIcon:(NSString *)icon highlightedIcon:(NSString *)highlighted target:(id)target action:(SEL)action;
+ (id)itemWithIcon:(NSString *)icon highlightedIcon:(NSString *)highlighted target:(id)target action:(SEL)action;

- (id)initWithTitle:(NSString *)title target:(id)target action:(SEL)action;
+ (id)itemWithTitle:(NSString *)title target:(id)target action:(SEL)action;

+ (id)itemWithTitle:(NSString *)title target:(id)target action:(SEL)action textColor:(UIColor *)color;


@end
