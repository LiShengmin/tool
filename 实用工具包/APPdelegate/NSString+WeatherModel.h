    //
//  NSString+WeatherModel.h
//  实用工具包
//
//  Created by Ghoul on 16/1/20.
//  Copyright © 2016年 Ghoul. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (WeatherModel)

- (NSString *)WeatherModelWindDirection;//风向
- (NSString *)WeatherModelWindPower;//风力等级
- (NSString *)WeatherModelWeatherPhenomenonOFIconName;//天气气象图标
- (NSString *)WeatherModelWeatherPhenomenon; //天气气象中文说明

@end
