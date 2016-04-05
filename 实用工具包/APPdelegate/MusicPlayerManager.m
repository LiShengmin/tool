//
//  MusicPlayerManager.m
//  实用工具包
//
//  Created by Ghoul on 16/1/7.
//  Copyright © 2016年 Ghoul. All rights reserved.
//

#import "MusicPlayerManager.h"
#import "MusicUrlCache.h"
#import "MusicRootPlistModle.h"
#import "GHONetWorking.h"
@import AVFoundation;

@interface MusicPlayerManager ()

@property (nonatomic,strong) NSMutableArray *playlist;
@property (nonatomic,strong) AVPlayer *player; // 播放器属性
@property (nonatomic,strong) NSTimer *timer;  // 定时器
@property (nonatomic,assign) NSInteger currentIndex;  // 当前的音乐下标

@end

@implementation MusicPlayerManager

DEFINE_SINGLETON_FOR_CLASS(MusicPlayerManager);

- (void)getPlayListCompletionHandler:(void(^)())handler {
    [self.playlist removeAllObjects];
    
    [GHONetWorking GHO_GET:MusicPlayerListURL parameters:nil progress:^(NSProgress *downloadProgress) {
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray * tempArr = responseObject;
        self.playlist = [MusicRootPlistModle objectWithKeyValues:tempArr];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
    }];
    handler();
}

- (MusicRootPlistModle *)getmusicInfoWithIndext:(NSUInteger)index{
    
    
    return nil;
}

#pragma mark- 懒加载
- (NSMutableArray *)playlist {
    if (!_playlist) {
        _playlist = [NSMutableArray array];
    }
    return _playlist;
}

- (AVPlayer *)player {
    if (!_player) {
        _player = [[AVPlayer alloc] init];
    }return _player;
}

@end
