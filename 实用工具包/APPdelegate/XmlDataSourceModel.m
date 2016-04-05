//
//  XmlDataSourceModel.m
//  实用工具包
//
//  Created by Ghoul on 16/1/17.
//  Copyright © 2016年 Ghoul. All rights reserved.
//

#import "XmlDataSourceModel.h"

@interface XmlDataSourceModel ()

@end

@implementation XmlDataSourceModel

- (void)initDataSourceOfIndexPath:(NSArray *)indexPath dataSource:(NSArray *)dataSource {
    self.dataDic = [NSMutableDictionary dictionary];
    for (int i = 0; i< dataSource.count; i++) {
        [self.dataDic setValue:dataSource[i] forKey:indexPath[i]];
    }
}

- (NSArray *)modelOfPriorityArr:(NSArray *)priorityArr {
    NSMutableArray * arr = [NSMutableArray array];
    for (NSString * priorityStr in priorityArr) {
        [arr addObject:[self.dataDic valueForKey:priorityStr]];
    }
    return (NSArray *)arr;
}

@end
