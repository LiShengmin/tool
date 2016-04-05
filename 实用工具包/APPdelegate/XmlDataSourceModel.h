//
//  XmlDataSourceModel.h
//  实用工具包
//
//  Created by Ghoul on 16/1/17.
//  Copyright © 2016年 Ghoul. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XmlDataSourceModel : NSObject

@property (nonatomic, strong) NSMutableDictionary * dataDic;

- (void)initDataSourceOfIndexPath:(NSArray *)indexPath dataSource:(NSArray *)dataSource;

- (NSArray *)modelOfPriorityArr:(NSArray *)priorityArr;

@end
