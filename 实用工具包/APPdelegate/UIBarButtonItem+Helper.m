//
//  UIBarButtonItem+Helper.m
//  实用工具包
//
//  Created by Ghoul on 16/1/8.
//  Copyright © 2016年 Ghoul. All rights reserved.
//

#import "UIBarButtonItem+Helper.h"

@implementation UIBarButtonItem (Helper)

- (id)initWithIcon:(NSString *)icon highlightedIcon:(NSString *)highlighted target:(id)target action:(SEL)action
{
    UIImage *image = [UIImage imageNamed:icon];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:image forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:highlighted] forState:UIControlStateHighlighted];
    btn.bounds = (CGRect){CGPointZero, image.size};
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [self initWithCustomView:btn];
}

+ (id)itemWithIcon:(NSString *)icon highlightedIcon:(NSString *)highlighted target:(id)target action:(SEL)action
{
    return [[self alloc] initWithIcon:icon highlightedIcon:highlighted target:target action:action];
}

- (id)initWithTitle:(NSString *)title target:(id)target action:(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btn.backgroundColor = [UIColor clearColor];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    
//    CGSize size = [title sizeWithFont:btn.titleLabel.font constrainedToSize:CGSizeMake(100, 200) lineBreakMode:NSLineBreakByCharWrapping | NSLineBreakByWordWrapping];
    NSDictionary *attribute = @{NSFontAttributeName: btn.titleLabel.font};
    CGSize size =  [title boundingRectWithSize:CGSizeMake(100, 200) options:NSStringDrawingTruncatesLastVisibleLine attributes:attribute context:nil].size;
    btn.frame = CGRectMake(0, 0, size.width, size.height);
    
    return [self initWithCustomView:btn];
}

+ (id)itemWithTitle:(NSString *)title target:(id)target action:(SEL)action
{
    return [[self alloc] initWithTitle:title target:target action:action];
}

+ (id)itemWithTitle:(NSString *)title target:(id)target action:(SEL)action textColor:(UIColor *)color
{
    return [[self alloc] initWithTitle:title target:target action:action textCOlor:color];
}

- (id)initWithTitle:(NSString *)title target:(id)target action:(SEL)action textCOlor:(UIColor *)color
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btn.backgroundColor = [UIColor clearColor];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:color forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font=[UIFont systemFontOfSize:16];
    //
    NSDictionary *attribute = @{NSFontAttributeName: btn.titleLabel.font};
    CGSize size =  [title boundingRectWithSize:CGSizeMake(100, 200) options:NSStringDrawingTruncatesLastVisibleLine attributes:attribute context:nil].size;
    btn.frame = CGRectMake(0, 0, size.width, size.height);
    
    return [self initWithCustomView:btn];
}

@end
