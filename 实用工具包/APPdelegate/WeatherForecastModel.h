//
//  WeatherForecastModel.h
//  实用工具包
//
//  Created by Ghoul on 16/1/20.
//  Copyright © 2016年 Ghoul. All rights reserved.
//

#import "RootModel.h"

@interface WeatherForecastModelF1 : RootModel

@property (nonatomic, strong) NSString * fa;//白天天气现象编号
@property (nonatomic, strong) NSString * fb;//晚上天气现象编号
@property (nonatomic, strong) NSString * fc;//白天天气温度(摄氏度)
@property (nonatomic, strong) NSString * fd;//晚上天气温度(摄氏度)
@property (nonatomic, strong) NSString * fe;//白天风向编号
@property (nonatomic, strong) NSString * ff;//晚上风向编号
@property (nonatomic, strong) NSString * fg;//白天风力编号
@property (nonatomic, strong) NSString * fh;//晚上风力编号
@property (nonatomic, strong) NSString * fi;//日出日落时间(中间用|分割)

@end

@interface WeatherForecastModelC : RootModel

@property (nonatomic, strong) NSString * c1;//区域 ID
@property (nonatomic, strong) NSString * c2;//城市英文名
@property (nonatomic, strong) NSString * c3;//城市中文名
@property (nonatomic, strong) NSString * c4;//城市所在市英文名
@property (nonatomic, strong) NSString * c5;//城市所在市中文名
@property (nonatomic, strong) NSString * c6;//城市所在省英文名
@property (nonatomic, strong) NSString * c7;//城市所在省中文名
@property (nonatomic, strong) NSString * c8;//城市所在国家英文名
@property (nonatomic, strong) NSString * c9;//城市所在国家中文名
@property (nonatomic, strong) NSString * c10;//城市级别
@property (nonatomic, strong) NSString * c11;//城市区号
@property (nonatomic, strong) NSString * c12;//邮编
@property (nonatomic, strong) NSString * c13;//经度
@property (nonatomic, strong) NSString * c14;//纬度
@property (nonatomic, strong) NSString * c15;//海拔
@property (nonatomic, strong) NSString * c16;//雷达站号
@property (nonatomic, strong) NSString * c17;//预报发布时间

@end

@interface WeatherForecastModelF : RootModel

@property (nonatomic, strong) NSString * f0;
@property (nonatomic, strong) NSArray <WeatherForecastModelF1 *> * f1;

@end

@interface WeatherForecastModel : RootModel

@property (nonatomic, strong) WeatherForecastModelC * c;
@property (nonatomic, strong) WeatherForecastModelF * f;

@end
