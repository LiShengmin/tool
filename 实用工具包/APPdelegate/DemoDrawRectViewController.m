//
//  DemoDrawRectViewController.m
//  实用工具包
//
//  Created by Lcvem on 16/4/1.
//  Copyright © 2016年 Ghoul. All rights reserved.
//

#import "DemoDrawRectViewController.h"
#import "UIView+DrawRectBlock.h"

@interface DemoDrawRectViewController ()

@end

@implementation DemoDrawRectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:[UIView viewWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64)
    drawRectBlock:^(UIView *drawRectView, CGRect rect) {
        CGContextRef c = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(c, [UIColor cyanColor].CGColor);
        CGContextFillRect(c, rect);
    }]];


}

@end
