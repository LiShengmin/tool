//
//  VarTableHeightViewCell.m
//  实用工具包
//
//  Created by Ghoul on 16/3/8.
//  Copyright © 2016年 Ghoul. All rights reserved.
//

#import "VarTableHeightViewCell.h"

@implementation VarTableHeightViewCell

- (void)updateConstraints {
    //remove Constraints
    [self.height uninstall];
    
    //add Constraints
    [self.content mas_makeConstraints:^(MASConstraintMaker *make) {
        self.height = make.height.equalTo(@60);//any number
    }];
    
    if(self.isShowView == NO) {
//        change Height Constrains to be 0
        [self.content mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0);
        }];
    }
    else {
        //remove Constraints
        [self.height uninstall];
    }
    
    [super updateConstraints];
}

- (void)setText:(NSString *)text {
    _text = text;
    self.textView.text = text;
    
    if ([self.text isEqualToString:@"123456789012345678901234567890"]) {
        self.isShowView = NO;
        self.button.hidden=YES;
        self.content.hidden=YES;
        self.intextView.hidden=YES;
    }else {
        self.isShowView = YES;
        self.button.hidden=NO;
        self.content.hidden=NO;
        self.intextView.hidden=NO;
        
    }
}

#pragma mark- cycleLife
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initiziation];
    }
    return self;
}

- (void)initiziation {
    [self.contentView addSubview:_textView];
    _textView.text = @"1234567";
    self.textView = [[UILabel alloc] init];
    self.textView.backgroundColor = [UIColor greenColor];
    self.textView.numberOfLines = 0;
    [self.contentView addSubview:_textView];
    /***/
    self.content = [[UIView alloc] init];
    self.content.backgroundColor = [UIColor redColor];
    self.content.alpha = 0.5f;
    [self.contentView addSubview:_content];
    /***/
    self.intextView = [[UILabel alloc] init];
    [_intextView setText:@"intextView"];
    _intextView.backgroundColor = [UIColor blueColor];
    [self.contentView addSubview:_intextView];
    /***/
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    [_button setTitle:@"button" forState:UIControlStateNormal];
    [_button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _button.backgroundColor = [UIColor  redColor];
    [self.contentView addSubview:_button];

    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.contentView).insets(UIEdgeInsetsMake(0, 25, 0, 100));
//        make.bottom.equalTo(self.content.mas_top).offset(5);
    }];
    [self.content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textView.mas_bottom).offset(5);
        make.bottom.left.right.equalTo(self.contentView).insets(UIEdgeInsetsMake(0, 0, 5, 0));
    }];
    [self.intextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.content).insets(UIEdgeInsetsMake(0, 0, 0, 0));
        make.bottom.equalTo(self.button.mas_top).offset(0);
    }];

    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.content).insets(UIEdgeInsetsMake(0, 5, 0, 5));
    }];
}

#pragma mark- 懒加载
- (UILabel *)textView {
    if (!_textView) {
        _textView = [[UILabel alloc] init];
    }
    return _textView;
}

@end
