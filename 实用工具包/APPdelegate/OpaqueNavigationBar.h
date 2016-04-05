//
//  OpaqueNavigationBar.h
//  实用工具包
//
//  Created by Ghoul on 16/1/8.
//  Copyright © 2016年 Ghoul. All rights reserved.
//

#import <UIKit/UIKit.h>
//调用这个类的时候都会使用这两个类，提前加载好。。省的调用麻烦。。
#import "UINavigationBar+Helper.h"
#import "UIBarButtonItem+Helper.h"

@interface OpaqueNavigationBar : UINavigationBar

@property (strong, nonatomic) UIBarButtonItem *leftItem;
@property (strong, nonatomic) UIBarButtonItem *rightItem;

- (void)setBackgroundAlpha:(CGFloat)alpha;

@end
