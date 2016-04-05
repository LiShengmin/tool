//
//  NSString+Weather.h
//  实用工具包
//
//  Created by Ghoul on 16/1/14.
//  Copyright © 2016年 Ghoul. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, WeatherType) {
    index_f    = 1,         // 1    指数:index_f(基础接口)；
    index_v    = 1 << 1,    // 2    index_v(常规接口)；
    forecast_f = 1 << 2,    // 4    3天预报:forecast_f(基础接口)；
    forecast_v = 1 << 3     // 8    forecast_v(常规接口)
};

@interface NSString (Weather)

- (NSString*)URLenEncode:(NSString*)unencodedString;
- (NSString *)URLenStrDecode:(NSString*)encodedString;

- (NSString *)weatherURL:(NSString *)areaid type:(WeatherType)type;

@end
