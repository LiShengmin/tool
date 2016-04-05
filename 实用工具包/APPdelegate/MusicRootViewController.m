//
//  MusicRootViewController.m
//  实用工具包
//
//  Created by Ghoul on 16/1/7.
//  Copyright © 2016年 Ghoul. All rights reserved.
//

#import "MusicRootViewController.h"
#import "MusicRootTableViewCell.h"
#import "MusicRootPlistModle.h"
#import "MusicPlayerManager.h"

@interface MusicRootViewController () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UIImageView *backImageView;
@property (nonatomic, strong) UITableView *musicTableView;
@property (nonatomic, strong) MusicPlayerManager *playerManger;

@end

@implementation MusicRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.playerManger = [MusicPlayerManager sharedMusicPlayerManager];
    self.title = @"播放列表";
        [self.playerManger getPlayListCompletionHandler:^{
        NSLog(@"请求完成");
        [self.musicTableView reloadData];
    }];
    self.backImageView.image = [UIImage BGForMusicRootController];
    
}

#pragma mark- 懒加载
- (UIImageView *)backImageView {
    if (!_backImageView) {
        _backImageView = [[UIImageView alloc] init];
    }
    return _backImageView;
}

#pragma mark- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.playerManger.plistCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MusicRootTableViewCell * cell = [MusicRootTableViewCell cellForTableView:tableView];
    
    MusicRootPlistModle *model = [self.playerManger getmusicInfoWithIndext:indexPath.row];
    
    
    
    return cell;
}

#pragma mark- UITableViewDelegate

@end
