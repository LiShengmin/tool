//
//  DBUtils.h
//  实用工具包
//
//  Created by Lcvem on 16/3/26.
//  Copyright © 2016年 Ghoul. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBUtils : NSObject

@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) NSMutableDictionary *dataDic;
+ (DBUtils*)utils;
- (void)saveDataToLocalWithDic:(NSDictionary*)dic;

@end
