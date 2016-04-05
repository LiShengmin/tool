//
//  QDDSmallScrollerView.h
//  实用工具包
//
//  Created by Ghoul on 16/1/9.
//  Copyright © 2016年 Ghoul. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QDDSmallScrollerViewDelegate <NSObject>

- (void)setIndex:(NSInteger)index;

@end

@interface QDDSmallScrollerView : UIView

@property (nonatomic, assign) NSInteger seclectIndex;

@property (nonatomic, strong) NSArray * nomalImages;
@property (nonatomic, strong) NSArray * seclectImages;
@property (nonatomic, strong) NSArray * titles;

@property (nonatomic, weak) id <QDDSmallScrollerViewDelegate> delegate;

- (void)initWithNomalImages:(NSArray *)nomalImages
              SeclectImages:(NSArray *)seclectImages
                     Titles:(NSArray *)titles
                       Fram:(CGRect)fram;
           
@end


@interface QDDSmallScrollerViewModel : NSObject

@property (nonatomic, strong) UIImage * nomalImage;
@property (nonatomic, strong) UIImage * seclectImage;
@property (nonatomic, strong) NSString * text;

@end
/**再interface旁边加上 一个代理方法*/
//<QDDSmallScrollerViewDelegate>

/**在interface和@end中间 加上一个私有属性*/
//@property (nonatomic, strong) QDDSmallScrollerView * qddSmallScrollerView;

/**在.m文件中加入一个懒加载的方法*/
//- (QDDSmallScrollerView *)qddSmallScrollerView {
//    if (!_qddSmallScrollerView) {
//        NSArray * seclectImages = @[@"625.jpg",@"625.jpg",@"625.jpg",@"625.jpg"];
//        NSArray * nomalImages = @[@"625.jpg",@"625.jpg",@"625.jpg",@"625.jpg"];
//        NSArray * titles = @[@"625.jpg",@"625.jpg",@"625.jpg",@"625.jpg"];
//        
//        QDDSmallScrollerView * view = [[QDDSmallScrollerView alloc] init];
//        [view initWithNomalImages:nomalImages SeclectImages:seclectImages Titles:titles Fram:CGRectMake(0, 64, SCREEN_WIDTH, 100)];
//        view.frame = CGRectMake(0, 64, SCREEN_WIDTH, 100);
//        view.delegate = self;
//        view.backgroundColor = [UIColor lightGrayColor];

//        view.seclectIndex = 2;//这个是你正在操作第几个块 从0开始

//        _qddSmallScrollerView = view;
//    }
//    return _qddSmallScrollerView;
//}

/**代理方法 用于返回每次点击的块*/
//#pragma mark- QDDSmallScrollerViewDelegate
//- (void)setIndex:(NSInteger)index {
//    NSLog(@"%ld", index);
//    
//}