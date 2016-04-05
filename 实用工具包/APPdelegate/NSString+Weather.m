//
//  NSString+Weather.m
//  实用工具包
//
//  Created by Ghoul on 16/1/14.
//  Copyright © 2016年 Ghoul. All rights reserved.
//

#import "NSString+Weather.h"
#import "NSString+encrypto.h"

@implementation NSString (Weather)

- (NSString *)weatherURL:(NSString *)areaid type:(WeatherType)type {
/*urlStr*/
    NSString * urlStr = @"http://open.weather.com.cn/data/";
/*areaid*/
    areaid = [self areaid:areaid];
/*type*/
    NSString * typeStr = [self type:type];
/*date*/
    NSString *dateStr = [self date];
/*appid*/
    NSString * appid = @"b696b2c5cf021c88";
/*prived_key*/
    NSString * prived_key = @"95d33c_SmartWeatherAPI_520e3b4";
    
    NSString * pubick_key = [NSString stringWithFormat:@"%@?areaid=%@&type=%@&date=%@&appid=%@", urlStr, areaid, typeStr, dateStr, appid];
    
    NSString * key0 = [[NSString alloc] hmacsha1:pubick_key secret:prived_key];
    
    NSString * urlEncode = [[NSString alloc] URLenEncode:key0];
    
    NSString * OverURL = [NSString stringWithFormat:@"%@?areaid=%@&type=%@&date=%@&appid=%@&key=%@", urlStr, areaid, typeStr, dateStr, [appid substringWithRange:NSMakeRange(0, 6)], urlEncode];
    
    return OverURL;
}

- (NSString *)type:(WeatherType)type {
    NSString * typeStr;
    switch (type) {
        case 1:
            typeStr = @"index_f";
            break;
        case 2:
            typeStr = @"index_v";
            break;
        case 4:
            typeStr = @"forecast_f";
            break;
        case 8:
            typeStr = @"forecast_v";
            break;
            
        default:
            break;
    }
    return typeStr;
}

- (NSString *)date {
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
    //用[NSDate date]可以获取系统当前时间
    NSString *dateStr = [dateFormatter stringFromDate:[NSDate date]];
    return dateStr;
}
- (NSString *)areaid:(NSString *)areaid {
    if ([areaid isEqualToString:@"北京"]) {
        areaid = @"101010300";
    }
    areaid = @"101050101";
    return @"101050101";
}

- (NSString*)URLenEncode:(NSString*)unencodedString{
    
    // CharactersToBeEscaped = @":/?&=;+!@#$()~',*";
    // CharactersToLeaveUnescaped = @"[].";
    return (NSString*)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(nil,
                                                                                (CFStringRef)unencodedString,nil,(CFStringRef)@"!*'();:@&=+$,/?%#[]",kCFStringEncodingUTF8));;
}

//URLDEcode
- (NSString *)URLenStrDecode:(NSString*)encodedString

{
    //NSString *decodedString = [encodedString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding ];
    
    NSString *decodedString  = (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL,
                                                                                                                     (__bridge CFStringRef)encodedString,
                                                                                                                     CFSTR(""),
                                                                                                                     CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    return decodedString;
}

@end
