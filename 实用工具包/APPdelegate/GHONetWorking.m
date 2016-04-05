//
//  GHONetWorking.m
//  实用工具包
//
//  Created by Ghoul on 15/12/30.
//  Copyright © 2015年 Ghoul. All rights reserved.
//

#import "GHONetWorking.h"

@implementation AFHTTPClient

+ (instancetype)sharedAFHTTPClient {
    static AFHTTPClient * client;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        client = [AFHTTPClient manager];
        client.responseSerializer = [AFJSONResponseSerializer serializer];
        client.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html", @"text/json", @"text/javascript",@"text/plain",@"image/gif", nil];
        client.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        [client.requestSerializer setValue:@"http://api.maxjia.com/" forHTTPHeaderField:@"Referer"];
        [client.requestSerializer setValue:@"Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.118 Safari/537.36 ApiMaxJia/1.0" forHTTPHeaderField:@"User-Agent"];
        client.requestSerializer.timeoutInterval = 10;
    });
    return client;
}

@end

@implementation GHONetWorking

DEFINE_SINGLETON_FOR_CLASS(GHONetWorking)
//
//- (void)GHO_GET:(NSString *)URLString parameters:(id)parameters progress:(void (^)(NSProgress *))progress success:(void (^)(NSURLSessionDataTask *, id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure {
//    
//    GHONetWorking * netWorking = [GHONetWorking sharedGHONetWorking];
//    
//    NSLog(@"AFHttp::URL::%@",URLString);
//    
//    
//    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
//    [manager GET:URLString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
//        progress (downloadProgress);
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        success(task,responseObject);
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"AFHTTP::error::%@",error);
//        NSLog(@"AFHTTP::operation == %@",task.response);
//        failure(task, error);
//    }];
//}

+ (void)GHO_GET:(NSString *)URLString
     parameters:(id)parameters
       progress:(HttpParameters)progress
        success:(HttpSuccessBlock)success
        failure:(HttpFailure)failure {
    
    AFHTTPClient * manager = [AFHTTPClient sharedAFHTTPClient];
    NSLog(@"url = %@, params = %@", URLString, parameters);
    [manager GET:URLString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        if (progress == nil) return ;
        progress (downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success == nil) return ;
        success(task,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"AFHTTP::error::%@",error);
        NSLog(@"AFHTTP::operation == %@",task.response);
        failure(task, error);
    }];
}

+ (void)GHO_Post:(NSString *)URLString
      parameters:(id)parameters
        progress:(HttpParameters)progress
         success:(HttpSuccessBlock)success
         failure:(HttpFailure)failure { 
    
    AFHTTPClient *manager = [AFHTTPClient sharedAFHTTPClient];
    
    [manager POST:URLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress == nil) return ;
        progress(uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success == nil) return ;
        success (task, responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"AFHTTP::error::%@",error);
        NSLog(@"AFHTTP::operation == %@",task.response);
        failure (task, error);
    }];
}

+ (void)GHO_PostWithImgPath:(NSString *)path
                 params:(NSDictionary *)params
                 images:(NSArray *)images
                success:(HttpSuccessBlock)success
                failure:(HttpFailure)failure {
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:path parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        for (NSUInteger idx = 0; idx < images.count; idx ++) {
            
            NSDate *date = [NSDate new];
            NSDateFormatter *df = [[NSDateFormatter alloc]init];
            [df setDateFormat:@"yyyyMMddHHmmss"];
            [df setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"]];
            
            [formData appendPartWithFileData:images[idx] name:[NSString stringWithFormat:@"file%zi", idx + 1 ] fileName:[NSString stringWithFormat:@"%@%zi.jpg", [df stringFromDate:date], idx + 1 ] mimeType:@"image/jpg"];
        }
    } error:nil];
//    
//    AFHTTPRequestOperation *opration = [[AFHTTPRequestOperation alloc]initWithRequest:request];
//    opration.responseSerializer = [AFJSONResponseSerializer serializer];
//    opration.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
//    
//    [request setValue:@"http://api.maxjia.com/" forHTTPHeaderField:@"Referer"];
//    [request setValue:@"Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.118 Safari/537.36 ApiMaxJia/1.0" forHTTPHeaderField:@"User-Agent"];
//    
//    [opration setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        if (success == nil) return;
//        success(responseObject);
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        if (failure == nil) return;
//        failure(error);
//    }];
    
//    [opration start];
}




@end
