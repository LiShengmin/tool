//
//  SchoolGyroscopeMotionView.m
//  实用工具包
//
//  Created by Lcvem on 16/3/27.
//  Copyright © 2016年 Ghoul. All rights reserved.
//

#import "SchoolGyroscopeMotionView.h"
#import "DBUtils.h"
#import "UIBezierPath+Arrow.h"

@implementation SchoolGyroscopeMotionView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        valiadCountStep = YES;
        // Initialization code
        [self drawCureView];
        [self startDeviceMotion];
        [self startUpdateAccelerometer];
        [self startDisplayLink];
    }
    return self;
}

- (void)drawCureView
{
//    SchoolGyroscopeMotionCurveView *xCurve = [[SchoolGyroscopeMotionCurveView alloc]initWithFrame:CGRectMake(20, 40, 280, 160)];
    SchoolGyroscopeMotionCurveView *xCurve = [[SchoolGyroscopeMotionCurveView alloc]init];
    xCurve.titleLabel.text = @"合力";
    xCurve.delegate = self;
    [self addSubview:xCurve];
    self.xCureV = xCurve;
    self.xCureV.userInteractionEnabled = NO;
    
//    MUTCurveView *yCurve = [[MUTCurveView alloc]initWithFrame:CGRectMake(20, 160, 280, 80)];
//    yCurve.titleLabel.text = @"y";
//    yCurve.delegate = self;
//    [self addSubview:yCurve];
//    self.yCureV = yCurve;
//    self.yCureV.userInteractionEnabled = NO;
//
//    MUTCurveView *zCurve = [[MUTCurveView alloc]initWithFrame:CGRectMake(20, 260, 280, 80)];
//    zCurve.titleLabel.text = @"z";
//    zCurve.delegate = self;
//    [self addSubview:zCurve];
//    self.zCureV = zCurve;
//    self.zCureV.userInteractionEnabled = NO;
    
    UILabel *collectLab = [[UILabel alloc]init];
//    collectLab.frame = CGRectMake(20, 260, 40, 20);
    [self addSubview:collectLab];
    collectLab.backgroundColor = [UIColor clearColor];
    collectLab.textColor = [UIColor blackColor];
    collectLab.text = @"采集";
    collectLab.textAlignment = NSTextAlignmentLeft;
    collectLab.font = [UIFont systemFontOfSize:14];
    
//    switchBtn = [[UISwitch alloc]initWithFrame:CGRectMake(60, 260, 30, 20)];
    switchBtn = [[UISwitch alloc] init];
    [switchBtn addTarget:self action:@selector(openOrCloseClicked:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:switchBtn];
    [switchBtn setOn:NO];
    
    
    UILabel *stepLab = [[UILabel alloc]init];
    stepLab.frame = CGRectMake(200, 260, 100, 20);
    stepLab.backgroundColor = [UIColor clearColor];
    stepLab.textColor = [UIColor blackColor];
    stepLab.text = @"";//@"步数:0"
    stepLab.textAlignment = NSTextAlignmentLeft;
    stepLab.font = [UIFont systemFontOfSize:14];
    [self addSubview:stepLab];
    self.stepLabel = stepLab;
    
    
    [self.xCureV mas_makeConstraints:^(MASConstraintMaker *make) {
        MAS_MAKE_INSETS(self, 40, 20, 0, 0);
    }];
    [switchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(@60);
        make.height.mas_equalTo(@30);
        make.top.right.equalTo(self).insets(UIEdgeInsetsMake(24, 30, 0, 0));
    }];
    [collectLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(@30);
        make.height.mas_equalTo(@30);
        make.top.equalTo(self).insets(UIEdgeInsetsMake(24,0, 0, 0));
        make.right.equalTo(switchBtn.mas_left).offset(-5);
    }];
}

- (void)openOrCloseClicked:(id)sender
{
    
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    UIBezierPath *bPath = [UIBezierPath bezierPath];
    //    [bPath arrowStartPoint:CGPointMake(20, 40) withEndPoint:CGPointMake(20, 400)];
    [bPath setLineWidth:1.0f];
    [bPath moveToPoint:CGPointMake(20, 20)];
    [bPath addLineToPoint:CGPointMake(20, 220)];
    [bPath closePath];
    [bPath setLineCapStyle:kCGLineCapSquare];
    [[UIColor lightGrayColor]set];
    [bPath stroke];
    
    // x
    [bPath moveToPoint:CGPointMake(10, 120)];
    [bPath addLineToPoint:CGPointMake(300, 120)];
    //    [bPath addArcWithCenter:CGPointMake(100, 100) radius:25 startAngle:0 endAngle:0 clockwise:YES];
    [bPath closePath];
    [[UIColor lightGrayColor]set];
    [bPath stroke];
    
    [bPath moveToPoint:CGPointMake(10, 120)];
    [bPath addLineToPoint:CGPointMake(20, 120)];
    
    [bPath moveToPoint:CGPointMake(10, 100)];
    [bPath addLineToPoint:CGPointMake(20, 100)];
    
    [bPath moveToPoint:CGPointMake(10, 80)];
    [bPath addLineToPoint:CGPointMake(20, 80)];
    
    [bPath moveToPoint:CGPointMake(10, 60)];
    [bPath addLineToPoint:CGPointMake(20, 60)];
    [bPath stroke];
    
    // y
    //    [bPath moveToPoint:CGPointMake(10, 200)];
    //    [bPath addLineToPoint:CGPointMake(300, 200)];
    //    [bPath closePath];
    //    [[UIColor lightGrayColor]set];
    //    [bPath stroke];
    //
    //    // z
    //    [bPath moveToPoint:CGPointMake(10, 300)];
    //    [bPath addLineToPoint:CGPointMake(300, 300)];
    //    [bPath closePath];
    //    [[UIColor lightGrayColor]set];
    //    [bPath stroke];
}


- (void)startDeviceMotion
{
    motionManager = [[CMMotionManager alloc] init];
    motionManager.showsDeviceMovementDisplay = YES;
    motionManager.deviceMotionUpdateInterval = 1.0 / 60.0;
    [motionManager startDeviceMotionUpdatesUsingReferenceFrame:CMAttitudeReferenceFrameXTrueNorthZVertical];
}

- (void)startUpdateAccelerometer
{
    /* 设置采样的频率，单位是秒 */
    NSTimeInterval updateInterval = 0.05; // 每秒采样20次
    
    //    CGSize size = [self superview].frame.size;
    //	__block CGRect f = [self frame];
    __block int stepCount = 0; // 步数
    //在block中，只能使用weakSelf。
    /* 判断是否加速度传感器可用，如果可用则继续 */
    if ([motionManager isAccelerometerAvailable] == YES) {
        /* 给采样频率赋值，单位是秒 */
        [motionManager setAccelerometerUpdateInterval:updateInterval];
        
        /* 加速度传感器开始采样，每次采样结果在block中处理 */
        [motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:^(CMAccelerometerData *accelerometerData, NSError *error)
         {
             
             CGFloat sqrtValue =sqrt(accelerometerData.acceleration.x*accelerometerData.acceleration.x+accelerometerData.acceleration.y*accelerometerData.acceleration.y+accelerometerData.acceleration.z*accelerometerData.acceleration.z);
             NSLog(@"sqrtValue == %f", sqrtValue);
             if (switchBtn.isOn)
             {
                 self.xCureV.userInteractionEnabled = YES;
                 [[DBUtils utils].dataArr addObject:[NSNumber numberWithFloat:sqrtValue]];
                 self.xCureV.inputData = sqrtValue;
                 
                 // 走路产生的震动率
//                 if (sqrtValue > 1.552188 && valiadCountStep)
//                 {
//                     displayLink.paused = NO;
                     //[NSString stringWithFormat:@"步数:%d ", stepCount];
//                     self.stepLabel.text = @"";
//                     stepCount +=1;
//                     valiadCountStep = NO;
//                 }
             }
             else
                 self.xCureV.userInteractionEnabled = NO;
             
         }];
    }
    
}


- (void)startDisplayLink
{
    displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(onDisplayLink:)];
    [displayLink setFrameInterval:60];
    [displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    displayLink.paused = YES;
}

- (void)stopDisplayLink
{
    
}

- (void)onDisplayLink:(id)sender
{
    displayLink.paused = YES;
    valiadCountStep = YES;
}

- (void)oneStep
{
    NSLog(@"printStep");
}


@end
