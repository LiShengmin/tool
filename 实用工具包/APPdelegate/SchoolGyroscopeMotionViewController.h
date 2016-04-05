//
//  SchoolGyroscopeMotionViewController.h
//  实用工具包
//
//  Created by Lcvem on 16/3/26.
//  Copyright © 2016年 Ghoul. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SchoolGyroscopeMotionView.h"

typedef void (^Changcolor)(UIColor *colorEnum); //定义一个block返回值void参数为颜色值

@interface SchoolGyroscopeMotionViewController : UIViewController

@property (nonatomic, strong) SchoolGyroscopeMotionView *mutView;

@end


@interface ShowBtnColor : NSObject

//回调函数改变btn的颜色值
+ (void)ChangeRootViewBtnRect:(CGRect)rect blockcompletion:(Changcolor)Changcolorblock;

@end