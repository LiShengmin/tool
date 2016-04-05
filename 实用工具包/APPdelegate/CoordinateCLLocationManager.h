//
//  CoordinateCLLocationManager.h
//  实用工具包
//
//  Created by Ghoul on 16/2/13.
//  Copyright © 2016年 Ghoul. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

typedef void(^CoorSuccess) (CLLocationCoordinate2D coordinate);
typedef void(^CoorCityName) (NSString * cityName);
typedef void(^CoorFailure) (NSError * error);

@interface CoordinateCLLocationManager : CLLocationManager

DEFINE_SINGLETON_FOR_HEADER(CoordinateCLLocationManager)

@property (nonatomic, copy) CoorSuccess success;
@property (nonatomic, copy) CoorFailure failure;
@property (nonatomic, copy) CoorCityName cityName;

- (void)latitudeAndLongitudeWithCLLocationFromDesiredAccuracy:(CLLocationAccuracy)desiredAccuracy distanceFilter:(CLLocationDistance)distanceFilter success:(CoorSuccess)success;

@end
