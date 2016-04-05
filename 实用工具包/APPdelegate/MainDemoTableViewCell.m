//
//  MainDemoTableViewCell.m
//  实用工具包
//
//  Created by Ghoul on 16/3/18.
//  Copyright © 2016年 Ghoul. All rights reserved.
//

#import "MainDemoTableViewCell.h"

@interface MainDemoTableViewCell ()

@property (nonatomic, strong) UILabel * textLable;
@property (nonatomic, strong) UIImageView * bgView;

@end

@implementation MainDemoTableViewCell

- (void)setName:(NSString *)name {
    _name = name;
    self.textLabel.text = name;
}

- (void)setImageURL:(NSString *)imageURL {
    _imageURL = imageURL;
    if (!imageURL) return;
    [self.bgView sd_setImageWithURL:[NSURL URLWithString:imageURL]];
    [self.contentView addSubview:self.bgView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        MAS_MAKE_ZERO(self.contentView);
    }];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initiziation];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initiziation];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initiziation];
    }
    return self;
}

- (void)initiziation {
    [self.contentView addSubview:self.textLabel];
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        MAS_MAKE_ZERO(self.contentView);
    }];
}

- (UILabel *)textLabel {
    if (!_textLable) {
        _textLable = [[UILabel alloc] init];
        _textLable.textColor = [UIColor MainDemoTableViewCellTextColor];
        _textLable.textAlignment = NSTextAlignmentCenter;
    }
    return _textLable;
}

@end
