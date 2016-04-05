//
//  QDDSmallScrollerView.m
//  实用工具包
//
//  Created by Ghoul on 16/1/9.
//  Copyright © 2016年 Ghoul. All rights reserved.
//

#import "QDDSmallScrollerView.h"

#define LIGHT_HEIGHT 5
#define BTNTAG 120

@interface QDDSmallScrollerView ()

@property (nonatomic, strong) NSMutableArray * models;
@property (nonatomic, strong) UILabel * greyLine;
@property (nonatomic, strong) UILabel * lightLine;
@property (nonatomic, assign) NSInteger num;

@end

@implementation QDDSmallScrollerView

#pragma mark- lifeCycle
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    [self initialize];
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    [self initialize];
    return self;
}

- (void)initialize
{
    [self addSubview:self.greyLine];
    [self addSubview:self.lightLine];
    _seclectIndex = 0;
}

#pragma mark- 懒加载
- (UILabel *)lightLine {
    if (!_lightLine) {
        self.lightLine = [[UILabel alloc] init];
        self.lightLine.backgroundColor = [UIColor cyanColor];
        self.lightLine.frame = CGRectMake(0, 0, 0, LIGHT_HEIGHT);
    }
    return _lightLine;
}

- (UILabel *)greyLine {
    if (!_greyLine) {
        self.greyLine = [[UILabel alloc] init];
        self.greyLine.backgroundColor = [UIColor grayColor];
        self.greyLine.frame = CGRectMake(0, 0, SCREEN_WIDTH, LIGHT_HEIGHT);
    }
    return _greyLine;
}

- (NSMutableArray *)models {
    if (!_models) {
        _models = [[NSMutableArray alloc] init];
    }
    return _models;
}
#pragma mark- setter and getter
- (void)setSeclectImages:(NSArray *)seclectImages {
    _seclectImages = [seclectImages copy];
}

- (void)setNomalImages:(NSArray *)nomalImages {
    _nomalImages = nomalImages;
}

- (void)setTitles:(NSArray *)titles {
    _titles = titles;
}

- (void)setNum:(NSInteger)num {
    _num = num;
}

- (void)setSeclectIndex:(NSInteger)seclectIndex {
    _seclectIndex = seclectIndex;
    [UIView animateWithDuration:2 animations:^{
        self.lightLine.frame = CGRectMake(SCREEN_WIDTH / 4 * seclectIndex, self.lightLine.frame.origin.y, self.lightLine.frame.size.width, self.lightLine.frame.size.height);
    }];
}

- (void)setNumAfter{
    if (!_num) return;
    for (int i = 0; i<_num; i++) {
        QDDSmallScrollerViewModel * model = _models[i];
        
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(i * SCREEN_WIDTH /_num, 0, self.frame.size.width/_num, self.frame.size.height-5);
        [btn setImage:model.nomalImage forState:UIControlStateHighlighted];
        [btn setImage:model.seclectImage forState:UIControlStateNormal];
        [btn setTitle:model.text forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
//        [btn setTitleColor:[UIColor cyanColor] forState:UIControlStateSelected];
//        [btn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
//        [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        
        btn.tag = BTNTAG + i;
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:btn];
    }
}

- (void)initWithNomalImages:(NSArray *)nomalImages
              SeclectImages:(NSArray *)seclectImages
                     Titles:(NSArray *)titles
                       Fram:(CGRect)fram
{
    self.frame = fram;
    
    _nomalImages = nomalImages;
    _seclectImages = seclectImages;
    _titles = titles;
    _num = seclectImages.count;
    
    if (_seclectImages && _nomalImages && _titles) {
        for (int i = 0 ; i < _num; i++) {
            QDDSmallScrollerViewModel *model = [[QDDSmallScrollerViewModel alloc] init];
            model.nomalImage = [UIImage imageNamed:_nomalImages[i]];
            model.seclectImage = [UIImage imageNamed:_seclectImages[i]];
            model.text = _titles[i];
            [self.models addObject:model];
        }
        _greyLine.frame = CGRectMake(0, self.frame.size.height- LIGHT_HEIGHT, SCREEN_WIDTH, LIGHT_HEIGHT);
        _lightLine.frame = CGRectMake(0, self.frame.size.height- LIGHT_HEIGHT, SCREEN_WIDTH / _num, LIGHT_HEIGHT);
    }
    [self setNumAfter];
}
#pragma mark- Action:
- (void)btnAction:(UIButton *)sender {
    NSInteger k = sender.tag - BTNTAG;
    if (k > _seclectIndex) return;
    CGFloat x = SCREEN_WIDTH / 4 * k;
    [UIView animateWithDuration:0.2 animations:^{
        self.lightLine.frame = CGRectMake(x, self.lightLine.frame.origin.y, self.lightLine.frame.size.width, self.lightLine.frame.size.height);
    }];
    
    [self.delegate setIndex: k];
}

@end

@implementation QDDSmallScrollerViewModel

MJLogAllIvars

@end
