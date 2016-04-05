//
//  SchoolGyroscopeMotionCurveView.h
//  实用工具包
//
//  Created by Lcvem on 16/3/27.
//  Copyright © 2016年 Ghoul. All rights reserved.
//

#import <UIKit/UIKit.h>

struct WavePeak {
    int firstZero;
    int middlePick;
    int lastZero;
};

@protocol SchoolGyroscopeMotionCurveDelegate <NSObject>

@optional
- (void)oneStep;

@end

@interface SchoolGyroscopeMotionCurveView : UIView

@property (nonatomic, assign) CGFloat inputData;
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) UILabel *titleLabel;
@property (readwrite) CGFloat velocity;



@property (nonatomic, assign) id <SchoolGyroscopeMotionCurveDelegate>delegate;
@property (nonatomic, assign)  NSInteger  firstZero;
@property (nonatomic, assign)  NSInteger middlePick;
@property (nonatomic, assign)  NSInteger lastZero;

@end
