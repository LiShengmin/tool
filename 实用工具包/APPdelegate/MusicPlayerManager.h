//
//  MusicPlayerManager.h
//  实用工具包
//
//  Created by Ghoul on 16/1/7.
//  Copyright © 2016年 Ghoul. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MusicRootPlistModle.h"

@interface MusicPlayerManager : NSObject

@property (nonatomic, assign) NSInteger plistCount;

DEFINE_SINGLETON_FOR_HEADER(MusicPlayerManager);

- (void)getPlayListCompletionHandler:(void(^)())handler;
- (MusicRootPlistModle *)getmusicInfoWithIndext:(NSUInteger)index;

@end

