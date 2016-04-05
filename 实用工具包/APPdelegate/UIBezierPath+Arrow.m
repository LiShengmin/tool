//
//  UIBezierPath+Arrow.m
//  实用工具包
//
//  Created by Lcvem on 16/3/26.
//  Copyright © 2016年 Ghoul. All rights reserved.
//

#import "UIBezierPath+Arrow.h"

#define kArrowLen 10

@implementation UIBezierPath (Arrow)

- (void)arrowStartPoint:(CGPoint)sPoint withEndPoint:(CGPoint)ePoint
{
    [self setLineWidth:1.0f];
    //    [self moveToPoint:sPoint];
    //    [self addLineToPoint:ePoint];
    //    [self closePath];
    [self setLineCapStyle:kCGLineCapSquare];
    [[UIColor lightGrayColor]set];
    //    [self stroke];
    
    //    CGPoint center = [self centerPoint:sPoint endPoint:ePoint];
    CGPoint leftPoint = [self leftPoint:sPoint endPoint:ePoint];
    CGPoint rightPoint = [self rightPoint:sPoint endPoint:ePoint];
    [self moveToPoint:leftPoint];
    [self addLineToPoint:rightPoint];
    [self addLineToPoint:ePoint];
    [self moveToPoint:rightPoint];
    [self addLineToPoint:ePoint];
    
    [[UIColor lightGrayColor]set];
    [self fill];
    
}

// 矢量
- (CGFloat) vectorWithSPoint:(CGPoint)sPoint endPoint:(CGPoint)ePoint
{
    CGFloat vectorSE = (ePoint.y - sPoint.y)/(ePoint.x - sPoint.y);
    return vectorSE;
}


- (CGPoint)centerPoint:(CGPoint)sPoint endPoint:(CGPoint)ePoint
{
    CGFloat vectorSE = [self vectorWithSPoint:sPoint endPoint:ePoint];
    CGPoint center = CGPointMake( ePoint.y*vectorSE *kArrowLen, ePoint.x/vectorSE*kArrowLen);
    return center;
}
//

- (CGPoint)leftPoint:(CGPoint)sPoint endPoint:(CGPoint)ePoint
{
    CGFloat vectorSE = [self vectorWithSPoint:sPoint endPoint:ePoint];
    CGPoint center = [self centerPoint:sPoint endPoint:ePoint];
    CGPoint leftPoint = CGPointMake(center.y *(-1/vectorSE)*2, center.x/(-1/vectorSE)*2);
    return leftPoint;
}

- (CGPoint)rightPoint:(CGPoint)sPoint endPoint:(CGPoint)ePoint
{
    CGFloat vectorSE = [self vectorWithSPoint:sPoint endPoint:ePoint];
    CGPoint center = [self centerPoint:sPoint endPoint:ePoint];
    CGPoint rightPoint = CGPointMake(center.y *(1/vectorSE)*2, center.x/(1/vectorSE)*2);
    return rightPoint;
}


@end
