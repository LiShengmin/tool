//
//  UIColor+CustomColor.h
//  实用工具包
//
//  Created by Ghoul on 15/12/30.
//  Copyright © 2015年 Ghoul. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (CustomColor)

+ (UIColor *)navBGColor;
+ (UIColor *)VarHeightTableTextColor;
+ (UIColor *)MainDemoTableViewCellTextColor;
+ (UIColor *)FFTSchoolDemo_audioPlotFreqViewBGColor;
+ (UIColor *)RecordFileSchoolDemo_recordingAudioPlotBGColor;
+ (UIColor *)RecordFileSchoolDemo_recordingAudioPlotLineColor;
+ (UIColor *)RecordFileSchoolDemo_playingAudioPlotBGColor;
+ (UIColor *)RecordFileSchoolDemo_playingAudioPlotSelectBGColor;


+ (UIColor*)colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alphaValue;
+ (UIColor*)colorWithHex:(NSInteger)hexValue;
+ (NSString *)hexFromUIColor: (UIColor*) color;
+ (NSInteger)colorStringToInt:(NSString *)colorStrig;

@end
