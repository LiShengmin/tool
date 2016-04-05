//
//  VarTableHeightViewCell.h
//  实用工具包
//
//  Created by Ghoul on 16/3/8.
//  Copyright © 2016年 Ghoul. All rights reserved.
//

#import "RootTableViewCell.h"

@interface VarTableHeightViewCell : RootTableViewCell

@property (strong, nonatomic) UILabel *textView;
@property (strong, nonatomic) UILabel *intextView;
@property (strong, nonatomic) UIView *content;
@property (strong, nonatomic) UIButton *button;

@property (nonatomic, copy) NSString *text;
@property (nonatomic, assign) BOOL isShowView;
@property (weak, nonatomic) MASConstraint *height;

@end
