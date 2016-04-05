//
//  AppString.h
//  实用工具包
//
//  Created by Ghoul on 15/12/23.
//  Copyright © 2015年 Ghoul. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppString : NSObject

//边框
#define SCREEN_FRAME ([UIScreen mainScreen].applicationFrame)
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

/**单例.m文件实现*/
#define DEFINE_SINGLETON_FOR_CLASS(className)\
+ (instancetype)shared##className {\
static dispatch_once_t onceToken;\
static className* shared##className;\
dispatch_once(&onceToken, ^{\
shared##className = [[self alloc] init];\
});\
return shared##className;\
}
/**单例.h文件实现*/
#define DEFINE_SINGLETON_FOR_HEADER(className)\
+ (instancetype)shared##className;

/**颜色 灰度 透明度*/
#define UIColorFromRGB(rgbValue, a) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]
/**颜色 R:red G:green B:blue Alpha:透明度*/
#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

//字体
/**系统字体 字号:S*/
#define Font(S)        [UIFont systemFontOfSize:S]
/**加粗字体 字号:S*/
#define BoldFont(S)    [UIFont boldSystemFontOfSize:S]
/**字体：FontAwesome 字体大小:S*/
#define AwesomeFont(S) [UIFont fontWithName:@"FontAwesome" size:S]

/**保存文件 到单例方式*/
#define Save(a,b) [[NSUserDefaults standardUserDefaults] setObject:a forKey:b]; [[NSUserDefaults standardUserDefaults] synchronize]

/**image便捷初始化*/
#define MyImage(imageName)  [UIImage imageNamed:imageName]

//weakSelf
#define WS(weakSelf)     __weak typeof(self) weakSelf = self
//strongSelf
#define StrS(strongSelf)   __strong typeof(self) strongSelf = weakSelf;

/**弧度*/
#define degreesToRadians(x) (M_PI*(x)/180.0)

/**mas_make*/
#define MAS_MAKE_ZERO(view) make.top.left.bottom.and.right.equalTo(view).with.insets(UIEdgeInsetsMake(0, 0, 0, 0))
#define MAS_MAKE_INSETS(view, t, l, b, r) make.top.left.bottom.and.right.equalTo(view).with.insets(UIEdgeInsetsMake(t, l, b, r))
/**mas_宏*/
//#define MAS_SHORTHAND
////define this constant if you want to enable auto-boxing for default syntax
//#define MAS_SHORTHAND_GLOBALS


@end
