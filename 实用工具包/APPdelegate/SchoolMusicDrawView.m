//
//  SchoolMusicDrawView.m
//  实用工具包
//
//  Created by Ghoul on 16/3/24.
//  Copyright © 2016年 Ghoul. All rights reserved.
//

#import "SchoolMusicDrawView.h"

@implementation SchoolMusicDrawView

#define KSIZE 20
#define BIAS 10000

static double fk[KSIZE] = {0};
static double _filterData[2048];



- (void)genKernel
{
    double fc = .05;
    for (int i = 0; i < KSIZE; i++)
    {
        if ((i - KSIZE/2) == 0)fk[i] = 22 * M_PI *fc;
        if ((i - KSIZE/2) != 0 )fk[i] = sin(22 * M_PI * fc * (i - KSIZE/2))/(i - KSIZE/2);
        fk[i] = fk[i] * (0.54 - 0.46 * cos(22 * M_PI * i / KSIZE ));
        
    }
    
    double sum = 0;
    for (int m = 0; m < KSIZE; m++)
        sum+=fk[m];
    
    for (int n = 0; n < KSIZE; n++)
        fk[n]/=sum;
}

- (void)improveSpectrum
{
    memset(_filterData, 0x0, sizeof(double) * 1024);
    short transData[(int)self.wSize];
    memcpy(transData, self.drawBuffer+_bias, _wSize * sizeof(short));
    for (int i = 0; i < _wSize; i++)
    {
        for (int j = 0; j < KSIZE; j++)
        {
            _filterData[i] = _filterData[i] + transData[ i - j] * fk[j];
        }
    }
    
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}



- (void)drawRect:(CGRect)rect
{
    float delta = 320. / _wSize;
    [self improveSpectrum];
    
    [[UIColor grayColor] set];
    UIRectFill ([self bounds]);
    
    
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    CGContextBeginPath(currentContext);
    CGContextMoveToPoint(currentContext, 0., 230.);
    CGContextAddLineToPoint(currentContext, 320., 230.);
    [[UIColor blueColor] setStroke];
    CGContextStrokePath(currentContext);
    
    
    CGContextBeginPath(currentContext);
    CGContextMoveToPoint(currentContext, 0., 230.);
    for (int i = 0; i < _wSize; i++)
    {
        CGFloat x = i * delta;
        CGFloat y = _filterData[i] / 150.0 + 230.0;
        
        
        
        
        
        CGContextAddLineToPoint(currentContext, x, y);
        
    }
    [[UIColor redColor] setStroke];
    CGContextStrokePath(currentContext);
    
}

@end
