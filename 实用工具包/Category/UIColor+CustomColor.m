//
//  UIColor+CustomColor.m
//  实用工具包
//
//  Created by Ghoul on 15/12/30.
//  Copyright © 2015年 Ghoul. All rights reserved.
//

#import "UIColor+CustomColor.h"

@implementation UIColor (CustomColor)

+ (UIColor *)navBGColor{
//    return RGBA(36, 199, 253, 1);
    return RGBA(213, 255, 210, 1);
}

+ (UIColor *)VarHeightTableTextColor {
    return RGBA(0, 0, 0, 1);
}

+ (UIColor *)MainDemoTableViewCellTextColor {
    return RGBA(0, 0, 0, 1);
}

+ (UIColor *)FFTSchoolDemo_audioPlotFreqViewBGColor {
    return RGBA(2, 184, 245, 1);
}

+ (UIColor *)RecordFileSchoolDemo_recordingAudioPlotBGColor{
    return [UIColor colorWithRed:0.984 green:0.71 blue:0.365 alpha:1];
}

+ (UIColor *)RecordFileSchoolDemo_recordingAudioPlotLineColor {
    return RGBA(254, 254, 254, 1);
}

+ (UIColor *)RecordFileSchoolDemo_playingAudioPlotBGColor {
    return [UIColor colorWithRed:0.984 green:0.71 blue:0.365 alpha:1];;
}

+ (UIColor *)RecordFileSchoolDemo_playingAudioPlotSelectBGColor {
    return [UIColor colorWithRed:0.984 green:0.71 blue:0.365 alpha:1];;
}







+ (UIColor*)colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alphaValue {
    return UIColorFromRGB(hexValue, alphaValue);
}

+ (UIColor*)colorWithHex:(NSInteger)hexValue {
    return [UIColor colorWithHex:hexValue alpha:1];
}

+ (NSString *)hexFromUIColor: (UIColor*) color {
    if (CGColorGetNumberOfComponents(color.CGColor) <4) {
        const CGFloat *components = CGColorGetComponents(color.CGColor);
        color = [UIColor colorWithRed:components[0]
                                green:components[0]
                                 blue:components[0]
                                alpha:components[1]];
    }
    
    if (CGColorSpaceGetModel(CGColorGetColorSpace(color.CGColor)) != kCGColorSpaceModelRGB) {
        return [NSString stringWithFormat:@"#FFFFFF"];
    }
    return [NSString stringWithFormat:@"#%x%x%x", (int)((CGColorGetComponents(color.CGColor))[0]*255.0),
            (int)((CGColorGetComponents(color.CGColor))[1]*255.0),
            (int)((CGColorGetComponents(color.CGColor))[2]*255.0)];;
}

+ (NSInteger)colorStringToInt:(NSString *)colorStrig {
    const char * cstr;
    int iPostion = 0;
    NSInteger nColor = 0;
    cstr = [colorStrig UTF8String];
    
    if (cstr[0] == '#') iPostion = 1;
    else iPostion = 0;
    
    if (([colorStrig length] - iPostion) == 6) {
        for (; iPostion < [colorStrig length]; iPostion ++) {
            NSInteger tem;
            if (cstr[iPostion] >= '0' && cstr[iPostion] <= '9') tem = cstr[iPostion] - '0';
            else if (cstr[iPostion] >= 'A' && cstr[iPostion] <= 'Z') tem = (cstr[iPostion] - 'A' +10);
            else if (cstr[iPostion] >= 'a' && cstr[iPostion] <= 'z') tem = (cstr[iPostion] - 'a' +10);
            
            nColor <<= 4;
            nColor += tem;
        }
    }
    if (([colorStrig length] - iPostion) == 3) {
        for (; iPostion < [colorStrig length];iPostion ++) {
            NSInteger tem;
            if (cstr[iPostion] >= '0' && cstr[iPostion] <= '9') tem = cstr[iPostion] - '0';
            else if (cstr[iPostion] >= 'A' && cstr[iPostion] <= 'Z') tem = (cstr[iPostion] - 'A' +10);
            else if (cstr[iPostion] >= 'a' && cstr[iPostion] <= 'z') tem = (cstr[iPostion] - 'a' +10);
            
            nColor <<= 2;
            nColor += tem;
            nColor <<= 2;
            nColor += tem;
            DLog(@"ncolor = %ld tmp = %ld", nColor, tem);
        }
    }
        return nColor;
}


@end
