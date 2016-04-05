//
//  NSString+WeatherModel.m
//  实用工具包
//
//  Created by Ghoul on 16/1/20.
//  Copyright © 2016年 Ghoul. All rights reserved.
//

#import "NSString+WeatherModel.h"

@implementation NSString (WeatherModel)

- (NSString *)WeatherModelWindDirection {
    switch ([self integerValue]) {
        case 0:
            return @"无风";
            break;
        case 1:
            return @"东北风";
            break;
        case 2:
            return @"东风";
            break;
        case 3:
            return @"东南风";
            break;
        case 4:
            return @"南风";
            break;
        case 5:
            return @"西南风";
            break;
        case 6:
            return @"西风";
            break;
        case 7:
            return @"西北风";
            break;
        case 8:
            return @"北风";
            break;
        case 9:
            return @"旋转风";
            break;
            
        default:
            return @"请正确输入风向编号";
            break;
    }
    return @"请正确输入风向编号";
}

- (NSString *)WeatherModelWindPower {
    switch ([self integerValue]) {
        case 0:
            return @"微风 <10m/h";
            break;
        case 1:
            return @"3-4级 10~17m/h";
            break;
        case 2:
            return @"4-5级 17~25m/h";
            break;
        case 3:
            return @"5-6级 25~34m/h";
            break;
        case 4:
            return @"6-7级 34~43m/h";
            break;
        case 5:
            return @"8-9级 43~54m/h";
            break;
        case 6:
            return @"9-10级 54~65m/h";
            break;
        case 7:
            return @"10-11级 65~77m/h";
            break;
        case 8:
            return @"11-12级 77~89m/h";
            break;
        case 9:
            return @"请输入正确风力编码";
            break;
            
        default:
            return @"请输入正确风力编码";
            break;
    }
    return @"请输入正确风力编码";
}

- (NSString *)WeatherModelWeatherPhenomenonOFIconName {
    switch ([self integerValue]) {
        case 0:
            return @"";
            break;
        case 1:
            return @"";
            break;
        case 2:
            return @"";
            break;
        case 3:
            return @"";
            break;
        case 4:
            return @"";
            break;
        case 5:
            return @"";
            break;
        case 6:
            return @"";
            break;
        case 7:
            return @"";
            break;
        case 8:
            return @"";
            break;
        case 9:
            return @"";
            break;
        case 10:
            return @"";
            break;
        case 11:
            return @"";
            break;
        case 12:
            return @"";
            break;
        case 13:
            return @"";
            break;
        case 14:
            return @"";
            break;
        case 15:
            return @"";
            break;
        case 16:
            return @"";
            break;
        case 17:
            return @"";
            break;
        case 18:
            return @"";
            break;
        case 19:
            return @"";
        case 20:
            return @"";
            break;
        case 21:
            return @"";
            break;
        case 22:
            return @"";
            break;
        case 23:
            return @"";
            break;
        case 24:
            return @"";
            break;
        case 25:
            return @"";
            break;
        case 26:
            return @"";
            break;
        case 27:
            return @"";
            break;
        case 28:
            return @"";
            break;
        case 29:
            return @"";
        case 30:
            return @"";
            break;
        case 31:
            return @"";
            break;
        case 32:
            return @"";
            break;
        case 53:
            return @"";
            break;
        case 99:
            return @"";
            break;
        
        default:
            return @"请正确输入天气气象编号";
            break;
    }
    return @"请正确输入天气气象编号";
}

- (NSString *)WeatherModelWeatherPhenomenon {
    switch ([self integerValue]) {
        case 0:
            return @"晴";
            break;
        case 1:
            return @"多云";
            break;
        case 2:
            return @"阴";
            break;
        case 3:
            return @"阵雨";
            break;
        case 4:
            return @"雷阵雨";
            break;
        case 5:
            return @"雷阵雨伴有冰雹";
            break;
        case 6:
            return @"雨夹雪";
            break;
        case 7:
            return @"小雨";
            break;
        case 8:
            return @"中雨";
            break;
        case 9:
            return @"大雨";
            break;
        case 10:
            return @"暴雨";
            break;
        case 11:
            return @"大暴雨";
            break;
        case 12:
            return @"特大暴雨";
            break;
        case 13:
            return @"阵雪";
            break;
        case 14:
            return @"小雪";
            break;
        case 15:
            return @"中雪";
            break;
        case 16:
            return @"大雪";
            break;
        case 17:
            return @"暴雪";
            break;
        case 18:
            return @"雾";
            break;
        case 19:
            return @"冻雨";
            break;
        case 20:
            return @"沙尘暴";
            break;
        case 21:
            return @"小到中雨";
            break;
        case 22:
            return @"中到大雨";
            break;
        case 23:
            return @"大到暴雨";
            break;
        case 24:
            return @"暴雨到大暴雨";
            break;
        case 25:
            return @"大暴雨到特大暴雨";
            break;
        case 26:
            return @"小到中雪";
            break;
        case 27:
            return @"中到大雪";
            break;
        case 28:
            return @"大到暴雪";
            break;
        case 29:
            return @"浮尘";
        case 30:
            return @"扬沙";
            break;
        case 31:
            return @"强沙尘暴";
            break;
        case 53:
            return @"霾";
            break;
        case 99:
            return @"无";
            break;
            
        default:
            return @"请正确输入天气气象编号";
            break;
    }
    return @"请正确输入天气气象编号";
}

@end
