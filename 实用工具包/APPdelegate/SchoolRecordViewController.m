//
//  SchoolRecordViewController.m
//  实用工具包
//
//  Created by Ghoul on 16/3/24.
//  Copyright © 2016年 Ghoul. All rights reserved.
//

#import "SchoolRecordViewController.h"
#import "RecoderHUD.h"

@interface SchoolRecordViewController ()

@property (nonatomic, strong) D3RecordButton * btn;
//@property (nonatomic, strong) D3RecordButton * centerBtn;

@end

@implementation SchoolRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.btn];
    [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 0, 0));
        make.height.mas_equalTo(100);
    }];
    self.btn.backgroundColor = [UIColor brownColor];
    [self.btn setTitle:@"按住录音" forState:UIControlStateNormal];
    
    [self.btn initRecord:self maxtime:10 title:@"上滑取消录音"];
//    [self.centerBtn initRecord:self maxtime:5];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


-(void)endRecord:(NSData *)voiceData{
    NSError *error;
    play = [[AVAudioPlayer alloc]initWithData:voiceData error:&error];
    NSLog(@"%@",error);
    play.volume = 1.0f;
    [play play];
    NSLog(@"yesssssssssss..........%f",play.duration);
    [_btn setTitle:@"按住录音" forState:UIControlStateNormal];
}

//不改btn的话这些就不要了
-(void)dragExit{
    [_btn setTitle:@"按住录音" forState:UIControlStateNormal];
}


-(void)dragEnter{
    [_btn setTitle:@"松开发送" forState:UIControlStateNormal];
}

#pragma mark- 懒加载
- (D3RecordButton *)btn {
    if (!_btn) {
        _btn = [[D3RecordButton alloc] init];
    }
    return _btn;
}

@end
