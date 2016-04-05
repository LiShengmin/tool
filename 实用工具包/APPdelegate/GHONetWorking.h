//
//  GHONetWorking.h
//  实用工具包
//
//  Created by Ghoul on 15/12/30.
//  Copyright © 2015年 Ghoul. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface AFHTTPClient : AFHTTPSessionManager

DEFINE_SINGLETON_FOR_HEADER(AFHTTPClient)

@end

typedef void(^HttpParameters) (NSProgress * downloadProgress);
typedef void(^HttpSuccessBlock) (NSURLSessionDataTask * task, id  responseObject);
typedef void(^HttpFailure) (NSURLSessionDataTask * task, NSError * error);

@interface GHONetWorking : NSObject

DEFINE_SINGLETON_FOR_HEADER(GHONetWorking);

+ (void)GHO_GET:(NSString *)URLString
 parameters:(id)parameters
   progress:(HttpParameters)progress
    success:(HttpSuccessBlock)success
    failure:(HttpFailure)failure;

+ (void)GHO_Post:(NSString *)URLString
      parameters:(id)parameters
        progress:(HttpParameters)progress
         success:(HttpSuccessBlock)success
         failure:(HttpFailure)failure;

@end
