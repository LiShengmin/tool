//
//  DBUtils.m
//  实用工具包
//
//  Created by Lcvem on 16/3/26.
//  Copyright © 2016年 Ghoul. All rights reserved.
//

#import "DBUtils.h"

#define kFileName @"MUTInfo.plist"

@implementation DBUtils

+ (DBUtils*)utils
{
    static DBUtils *share = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        share = [[DBUtils alloc]init];
    });
    return share;
}

- (id)init
{
    if (self = [super init])
    {
        NSMutableArray *tmpArr = [[NSMutableArray alloc]init];
        self.dataArr = tmpArr;
        
        NSMutableDictionary *tmpDic = [[NSMutableDictionary alloc]init];
        self.dataDic = tmpDic;
    }
    return self;
}

- (NSString*)dataFilePath
{
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filePath = [pathArray objectAtIndex:0];
    NSString *fileName =[filePath stringByAppendingPathComponent:kFileName];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:fileName]) {
        [[NSFileManager defaultManager] createFileAtPath:fileName contents:nil attributes:nil];
    }
    return fileName;
}

- (void)saveDataToLocalWithDic:(NSDictionary*)dic
{
    NSString *filePath = [self dataFilePath];
    if (![dic writeToFile:filePath atomically:YES]) {
        NSLog(@"写入用户信息失败");
    }
}

@end
