//
//  MainViewDataSourceModel.h
//  实用工具包
//
//  Created by Ghoul on 15/12/24.
//  Copyright © 2015年 Ghoul. All rights reserved.
//

#import "RootModel.h"

@interface MainViewDataSourceModel : RootModel

@property (nonatomic, copy) NSString * title;
@property (nonatomic, copy) NSString * urlStr;
@property (nonatomic, copy) NSString * imageStr;
@property (nonatomic, copy) NSString * imageURL;
@property (nonatomic, copy) NSString * jmpVC;

@end
