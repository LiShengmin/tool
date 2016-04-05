//
//  WeatherIndexModelTableViewCell.m
//  实用工具包
//
//  Created by Ghoul on 16/3/20.
//  Copyright © 2016年 Ghoul. All rights reserved.
//

#import "WeatherIndexModelTableViewCell.h"

#define DEFINE_LABLE_GETTER(ClassName, className)\
- (UILabel *)##className {\
if (!##className) {\
##className= [[UILabel alloc] init];\
##className.numberOfLines = 0;\
##className.textColor = [UIColor blackColor];\
}\
return ##className;\
}

@interface WeatherIndexModelTableViewCell ()

@property (nonatomic, strong) UILabel * lable1;
@property (nonatomic, strong) UILabel * lable2;
@property (nonatomic, strong) UILabel * lable3;
@property (nonatomic, strong) UILabel * lable4;
@property (nonatomic, strong) UILabel * lable5;

@end

@implementation WeatherIndexModelTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initizial];
    }
    return self;
}

- (UILabel *)lable1 {
    if (!_lable1) {
        UILabel * lable = [[UILabel alloc] init];
        lable.textColor = [UIColor blackColor];
        lable.textAlignment = NSTextAlignmentLeft;
        lable.numberOfLines = 0;
        _lable1 = lable;
    }
    return _lable1;
}

- (UILabel *)lable2 {
    if (!_lable2) {
        UILabel * lable = [[UILabel alloc] init];
        lable.textColor = [UIColor blackColor];
        lable.textAlignment = NSTextAlignmentLeft;
        lable.numberOfLines = 0;
        _lable2 = lable;
    }
    return _lable2;
}

- (UILabel *)lable3 {
    if (!_lable3) {
        UILabel * lable = [[UILabel alloc] init];
        lable.textColor = [UIColor blackColor];
        lable.textAlignment = NSTextAlignmentLeft;
        lable.numberOfLines = 0;
        _lable3 = lable;
    }
    return _lable3;
}

- (UILabel *)lable4 {
    if (!_lable4) {
        UILabel * lable = [[UILabel alloc] init];
        lable.textColor = [UIColor blackColor];
        lable.textAlignment = NSTextAlignmentLeft;
        lable.numberOfLines = 0;
        _lable4 = lable;
    }
    return _lable4;
}

- (UILabel *)lable5 {
    if (!_lable5) {
        UILabel * lable = [[UILabel alloc] init];
        lable.textColor = [UIColor blackColor];
        lable.textAlignment = NSTextAlignmentLeft;
        lable.numberOfLines = 0;
        _lable5 = lable;
    }
    return _lable5;
}

- (void)initizial {
    [self.contentView addSubview:self.lable1];
    self.lable1.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:self.lable2];
    self.lable2.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:self.lable3];
    [self.contentView addSubview:self.lable4];
    [self.contentView addSubview:self.lable5];

    [_lable1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.contentView).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    [_lable2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lable1.mas_bottom).offset(0);
        make.left.right.equalTo(self.contentView).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    [_lable3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView).insets(UIEdgeInsetsMake(0, 0, 0, 0));
        make.top.equalTo(self.lable2.mas_bottom).offset(0);
    }];
    [_lable4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView).insets(UIEdgeInsetsMake(0, 0, 0, 0));
        make.top.equalTo(self.lable3.mas_bottom).offset(0);
    }];
    [_lable5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.contentView).insets(UIEdgeInsetsMake(0, 0, 0, 0));
        make.top.equalTo(self.lable4.mas_bottom).offset(0);
    }];
    
}

- (void)setModel:(WeatherIndexModelI *)model {
    _model = model;
    _lable1.text = model.i1;
    _lable2.text = model.i2;
    _lable3.text = model.i3;
    _lable4.text = model.i4;
    _lable5.text = model.i5;
}

@end
