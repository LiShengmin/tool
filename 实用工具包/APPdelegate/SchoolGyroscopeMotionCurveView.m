//
//  SchoolGyroscopeMotionCurveView.m
//  实用工具包
//
//  Created by Lcvem on 16/3/27.
//  Copyright © 2016年 Ghoul. All rights reserved.
//

#import "SchoolGyroscopeMotionCurveView.h"
#import "DBUtils.h"

@implementation SchoolGyroscopeMotionCurveView

@synthesize lastZero;
@synthesize firstZero;
@synthesize middlePick;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor clearColor];
        self.layer.borderColor = [UIColor redColor].CGColor;
        
        NSMutableArray *tmpArr = [[NSMutableArray alloc]init];
        self.dataArr = tmpArr;
        
        UILabel *quanquanLabel = [[UILabel alloc]init];
//        quanquanLabel.frame = CGRectMake(260, 0, 20, 20);
        quanquanLabel.backgroundColor = [UIColor clearColor];
        quanquanLabel.textColor = [UIColor blackColor];
        quanquanLabel.text = @"网络连接错误";
        quanquanLabel.textAlignment = NSTextAlignmentRight;
        quanquanLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:quanquanLabel];
        self.titleLabel = quanquanLabel;
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.equalTo(self).insets(UIEdgeInsetsMake(0, 0, 0, 0));
            make.height.mas_equalTo(@20);
            make.width.mas_equalTo(@(280));
        }];
        self.velocity = 40;
        
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
        [self addGestureRecognizer:pan];
    }
    return self;
}

- (void)setInputData:(CGFloat)inputData
{
    _inputData = inputData;
    [self.dataArr addObject:[NSNumber numberWithFloat:inputData]];
    if (self.dataArr.count > 280)
        [self.dataArr removeObjectAtIndex:0];
    [self setNeedsDisplay];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    NSInteger count = 0;
    for (NSInteger i = self.dataArr.count -1; i > 0; i --)
    {
        NSNumber *pointNum = self.dataArr[i];
        CGFloat point = [pointNum floatValue];
        
        NSNumber *nextNum = self.dataArr[i-1];
        CGFloat nextPoint = [nextNum floatValue];
        
        
        CGFloat frontP = point * self.velocity;
        CGFloat lastP = nextPoint * self.velocity;
        
        UIBezierPath *bPath = [UIBezierPath bezierPath];
        [bPath setLineWidth:1.0f];
        [bPath moveToPoint:CGPointMake(280 - count,frontP + 40)];
        [bPath addLineToPoint:CGPointMake(280 - count-1,lastP + 40)];
        [bPath closePath];
        [bPath setLineCapStyle:kCGLineCapSquare];
        [[UIColor blackColor]set];
        [bPath stroke];
        count += 1;
        //        NSLog(@"%f", frontP);
        //        [self arithmeticalStartTipping:point * self.velocity withLastPoint:nextPoint * self.velocity];
        //        NSLog(@"%f", 40 - point *self.velocity);
    }
}

// pan
- (void)pan:(UIPanGestureRecognizer *)sender
{
    CGPoint translation = [sender translationInView:self];
    
    NSLog(@"%f", translation.x);
    
    // 置0
    [sender setTranslation:CGPointMake(0, 0) inView:self];
}



/**
 *  记步规则，采用中间有0值，下一个值是超过20，在下一个值为0，此即 记为一步
 *
 *  @param point 前一个点 和后一个点
 */
- (void)arithmeticalStartTipping:(CGFloat)frontP withLastPoint:(CGFloat)lastP
{
    // 从0算起步 查找正数
    
    if (frontP == 0 || (frontP > 0 && lastP < 0) ||(frontP < 0 && lastP > 0))
    {
        if (!firstZero)
        {
            if (self.delegate)
            {
                [self.delegate oneStep];
            }
            
        }
        firstZero = 1;
    }
    else// 查找中间峰值
    {
        
        //        NSLog(@"%f", lastP);
        if (frontP > 20)
        {
            //            NSLog(@"%f", frontP);
            firstZero = 0;  // 表示遇到中间峰值
        }
    }
    //    else
    //    {
    //        if (lastP == 0 ||(frontP < 0 && lastP > 0) )
    //        {
    //            lastZero = 1; // 表示遇到最后一个0点
    //            if (self.delegate)
    //            {
    //                [self.delegate oneStep];
    //            }
    //            lastZero =0;
    //            middlePick = 0;
    //            firstZero = 0;
    //        }
    //    }
    
}

@end
