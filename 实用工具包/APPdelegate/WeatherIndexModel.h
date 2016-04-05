//
//  WeatherIndexModel.h
//  实用工具包
//
//  Created by Ghoul on 16/1/20.
//  Copyright © 2016年 Ghoul. All rights reserved.
//

#import "RootModel.h"

@interface WeatherIndexModelI : RootModel

@property (nonatomic, strong) NSString * i1;
@property (nonatomic, strong) NSString * i2;
@property (nonatomic, strong) NSString * i3;
@property (nonatomic, strong) NSString * i4;
@property (nonatomic, strong) NSString * i5;

@end

@interface WeatherIndexModel : RootModel

@property (nonatomic, strong) NSArray <WeatherIndexModelI *> * i;

@end
