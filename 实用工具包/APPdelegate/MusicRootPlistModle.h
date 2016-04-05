//
//  MusicRootPlistModle.h
//  实用工具包
//
//  Created by Ghoul on 16/1/7.
//  Copyright © 2016年 Ghoul. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RootModel.h"

@interface MusicRootPlistModle : RootModel

@property (nonatomic, strong) NSString * mp3Url;       // 歌曲的Url
@property (nonatomic, strong) NSString * ID;           // 歌曲的id
@property (nonatomic, strong) NSString * name;         // 歌曲的名称
@property (nonatomic, strong) NSString * picUrl;       // 歌曲的图片Url
@property (nonatomic, strong) NSString * blurPicUrl;   // 歌曲的模糊图片Url
@property (nonatomic, strong) NSString * album;        // 歌曲的专辑
@property (nonatomic, strong) NSString * singer;       // 歌曲的歌手
@property (nonatomic, strong) NSString * duration;     // 歌曲的时长
@property (nonatomic, strong) NSString * artists_name; // 歌曲的作者
@property (nonatomic, strong) NSMutableArray * timeForLyric;  // 时间对应的歌词

@end
