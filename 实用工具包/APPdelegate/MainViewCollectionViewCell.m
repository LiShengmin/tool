//
//  MainViewCollectionViewCell.m
//  实用工具包
//
//  Created by Ghoul on 15/12/24.
//  Copyright © 2015年 Ghoul. All rights reserved.
//

#import "MainViewCollectionViewCell.h"
#import "UIView+GHOExtension.h"

@interface MainViewCollectionViewCell ()

@property (nonatomic, weak) UILabel * titleLabel;
@property (nonatomic, weak) UIImageView * URlImage;
@property (nonatomic, weak) UIVisualEffectView * visualEffectView;

@end

@implementation MainViewCollectionViewCell

#pragma mark- Setter Getter 方法
- (void)setLabelText:(NSString *)labelText {
    _labelText = [labelText copy];
    _titleLabel.text = _labelText;
    _titleLabel.hidden = !_labelText;
}


- (NSString *)title {
    return self.titleLabel.text;
}

- (void)setImageStr:(NSString *)imageStr {
    _imageStr = imageStr;
    _URlImage.image = [UIImage imageNamed:imageStr];
}

- (void)setImageURL:(NSString *)imageURL {
    _imageURL = [imageURL copy];
    [_URlImage sd_setImageWithURL:[NSURL URLWithString:imageURL]];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    _URlImage.frame = self.bounds;
    
    _titleLabel.hidden = !self.title;

    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        MAS_MAKE_ZERO(self);
    }];
    
    [_URlImage mas_makeConstraints:^(MASConstraintMaker *make) {
        MAS_MAKE_ZERO(self);
    }];
    [_visualEffectView mas_makeConstraints:^(MASConstraintMaker *make) {
        MAS_MAKE_ZERO(self);
    }];
}
//    UIInterfaceOrientation interfaceOrientation=[[UIApplication sharedApplication] statusBarOrientation];
//    if (interfaceOrientation == UIDeviceOrientationPortrait || interfaceOrientation ==UIDeviceOrientationPortraitUpsideDown) {
//        //翻转为竖屏时
//        [self setVerticalFrame];
//    }else if (interfaceOrientation==UIDeviceOrientationLandscapeLeft || interfaceOrientation ==UIDeviceOrientationLandscapeRight) {
//        //翻转为横屏时
////        [self setHorizontalFrame];
//    }
#pragma mark- 加载方法
- (void)setUpTitlabel {
    UILabel * label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    _titleLabel = label;
    [self insertSubview:_titleLabel atIndex:1];
}

- (void)setUpUrlImage {
    UIImageView * imageView = [[UIImageView alloc] init];
    _URlImage = imageView;
    [self insertSubview:imageView atIndex:0];
}

- (void)setvisualEffectView {
    //添加毛玻璃效果的方法 ～～～～IOS8 以上
    UIBlurEffect * beffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
    UIVisualEffectView * view = [[UIVisualEffectView alloc] initWithEffect:beffect];
    [_URlImage addSubview:view];
    _visualEffectView = view;
    [self.URlImage insertSubview:view atIndex:1];
}

#pragma mark - 初始化
- (void)initiziation {
    [self setUpTitlabel];
    [self setUpUrlImage];
    [self setvisualEffectView];
}
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initiziation];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initiziation];
    }
    return self;
}


@end
