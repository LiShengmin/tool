//
//  SchoolMusicDrawView.h
//  实用工具包
//
//  Created by Ghoul on 16/3/24.
//  Copyright © 2016年 Ghoul. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SchoolMusicDrawView : UIView

@property short *drawBuffer;
@property int  dataLen;
@property float *outRel;
@property float *outImg;
@property int bias;
@property int wSize;
- (void)genKernel;

@end
