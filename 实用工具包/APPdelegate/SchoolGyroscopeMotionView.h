//
//  SchoolGyroscopeMotionView.h
//  实用工具包
//
//  Created by Lcvem on 16/3/27.
//  Copyright © 2016年 Ghoul. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>
#import <CoreLocation/CoreLocation.h>

#import "SchoolGyroscopeMotionCurveView.h"

@interface SchoolGyroscopeMotionView : UIView<SchoolGyroscopeMotionCurveDelegate>
{
    CMMotionManager *motionManager;
    CLLocationManager *locationManager;
    CLLocation *location;
    CADisplayLink *displayLink;
    UISwitch *switchBtn;
    
    BOOL valiadCountStep; // 用于控制开关步数的控制
}
@property (nonatomic, strong) SchoolGyroscopeMotionCurveView * xCureV;
@property (nonatomic, strong) SchoolGyroscopeMotionCurveView * yCureV;
@property (nonatomic, strong) SchoolGyroscopeMotionCurveView * zCureV;
@property (nonatomic, strong) UILabel *stepLabel;

@end
