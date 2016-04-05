//
//  D3RecordButton.h
//  实用工具包
//
//  Created by Ghoul on 16/3/24.
//  Copyright © 2016年 Ghoul. All rights reserved.
//

#import "lame.h"
#import "MP3Recorder.h"
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@protocol D3RecordDelegate <NSObject>
- (void)endRecord:(NSData *)voiceData;

@optional
- (void)recording:(float) recordTime;
- (void)dragExit;
- (void)dragEnter;
@end


@interface D3RecordButton : UIButton <Mp3RecorderDelegate> {
    int maxTime;
    MP3Recorder *mp3;
    NSString *title;
}
@property (nonatomic,weak) id<D3RecordDelegate> delegate;

- (void)initRecord:(id<D3RecordDelegate>)delegate maxtime:(int)_maxTime title:(NSString*)title;
- (void)initRecord:(id<D3RecordDelegate>)delegate maxtime:(int)_maxTime;
- (void)startRecord;
- (void)stopRecord;
- (void)cancelRecord;


@end
