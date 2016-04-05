//
//  SchoolGyroscopeMotionViewController.m
//  实用工具包
//
//  Created by Lcvem on 16/3/26.
//  Copyright © 2016年 Ghoul. All rights reserved.
//

#import "SchoolGyroscopeMotionViewController.h"



@interface SchoolGyroscopeMotionViewController ()

@end

@implementation SchoolGyroscopeMotionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    SchoolGyroscopeMotionView *gyroscopeMotion = [[SchoolGyroscopeMotionView alloc]init];
    [self.view addSubview:gyroscopeMotion];
    self.mutView = gyroscopeMotion;
    [self.mutView mas_makeConstraints:^(MASConstraintMaker *make) {
        MAS_MAKE_INSETS(self.view, 64, 0, 0, 0);
    }];
    
    // Do any additional setup after loading the view, typically from a nib.
}



- (IBAction)buttonPressed:(UIButton *)sender {
    CGRect temp = sender.frame;
    __weak NSString *strTitle = @"changeColor";
    [ShowBtnColor ChangeRootViewBtnRect:temp
                        blockcompletion:^(UIColor *colorEnum) {
                            
                            /*函数回调 当block执行时就会回到这里*/
                            
                            [sender setTitle:strTitle forState:UIControlStateNormal];
                            sender.backgroundColor = colorEnum;
                            NSLog(@"%@", strTitle);
                            
                        }];
    NSLog(@"%@", strTitle);

}

-(void)chargeMyIphone:(void(^)(void))finishBlock
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

@implementation ShowBtnColor


+ (void)ChangeRootViewBtnRect:(CGRect)rect blockcompletion:(Changcolor)Changcolorblock

{
    
    UIColor *temp = [UIColor greenColor];
    
    Changcolorblock(temp); //执行block
    
}

@end
