//
//  WeatherRootViewController.h
//  实用工具包
//
//  Created by Ghoul on 16/1/6.
//  Copyright © 2016年 Ghoul. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeatherRootViewController : UIViewController

@end

//
//
//
//NSString * str = @"http://weather.moji.com/weather/pb/detail";
//NSDictionary * dic =
//@{
//  @"common": @{
//          @"unix" : @"1452068210773.297",
//          @"uid" : @(643969918),
//          @"app_version" : @"50050701",
//          @"mcc" : @"460",
//          @"width" : @(1242),
//          @"net" : @"wifi",
//          @"mnc" : @"01",
//          @"identifier" : @"7E290C69-EFB7-4009-BE2C-F95093D5017E",
//          @"platform" : @"iPhone",
//          @"sid" : @"87EECF196C1D048E041BF558C1D177D4",
//          @"language" : @"CN",
//          @"height" : @(2208),
//          @"token" : @"<50f4d5b0 1016a5b1 65230cba 33e0bf6f f1dcaf0d 1baff7bb 419edf0d dff84790>",
//          @"snsid" : @(20281349),
//          @"os_version" : @"9.2",
//          @"device" : @"iPhone",
//          @"pid" : @"9000"
//          },
//  @"params" : @{
//          @"fst" : @(91452064660688),
//          @"city" : @[
//                  @{
//                      @"id" : @(47),
//                      @"ts" : @(1452068025776),
//                      @"avatarId" : @"2",
//                      @"cr" : @1
//                      },
//                  @{
//                      @"id" : @600,
//                      @"ts" : @1452068025776,
//                      @"avatarId" : @"2",
//                      @"cr" : @0
//                      },
//                  @{
//                      @"id" : @33,
//                      @"ts" : @1452068025776,
//                      @"avatarId" : @"2",
//                      @"cr" : @0
//                      }
//                  ],
//          @"lang" : @"CN",
//          @"tu" : @"c",
//          @"wu" : @"beau",
//          @"token" : @"<50f4d5b0 1016a5b1 65230cba 33e0bf6f f1dcaf0d 1baff7bb 419edf0d dff84790>",
//          @"sst" : @1452068025781
//          }
//  };
//
////    NSDictionary * DIC2 = @{Form item:
////                                @{
////    @"common" : @{
////        @"unix" : @"1452071274803.798",
////        @"uid" : @643969918,
////        @"mcc" : @"460",
////        @"app_version" : @"50050701",
////        @"width" : @1242,
////        @"net" : @"wifi",
////        @"mnc" : @"01",
////        @"identifier" : @"7E290C69-EFB7-4009-BE2C-"
////    }
////
////    }};
////    [GHONetWorking GHO_GET:str parameters:dic progress:^(NSProgress *downloadProgress) {
////
////    } success:^(NSURLSessionDataTask *task, id responseObject) {
////
////    } failure:^(NSURLSessionDataTask *task, NSError *error) {
////
////    }];
//
//[GHONetWorking GHO_Post:str parameters:dic progress:^(NSProgress *downloadProgress) {
//    
//} success:^(NSURLSessionDataTask *task, id responseObject) {
//    
//} failure:^(NSURLSessionDataTask *task, NSError *error) {
//    
//}];


//    NSString * str0 = @"http://www.weather.com.cn/data/sk/101010100.html";
//    NSString * str1 = @"http://www.weather.com.cn/data/cityinfo/101010100.html";
//    NSString * str2 = @"http://m.weather.com.cn/data/101010100.html";

//    NSString * public1 = @"http://webapi.weather.com.cn/data/?areaid=101010100&type=index&date=201211281030&appid=cf2d61521456sads";
//    NSString * private1 = @"private_key";
