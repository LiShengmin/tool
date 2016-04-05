//
//  RecoderHUD.h
//  实用工具包
//
//  Created by Ghoul on 16/3/24.
//  Copyright © 2016年 Ghoul. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecoderHUD : UIView {
    UIImageView *imgView;
    UILabel *titleLabel;
    UILabel *timeLabel;
}

@property (nonatomic, strong, readonly) UIWindow *overlayWindow;

+ (void)show;

+ (void)dismiss;

+ (void)setTitle:(NSString*)title;

+ (void)setTimeTitle:(NSString*)time;

+ (void)setImage:(NSString*)imgName;

@end
