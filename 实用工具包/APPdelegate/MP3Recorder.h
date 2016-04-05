//
//  MP3Recorder.h
//  实用工具包
//
//  Created by Ghoul on 16/3/24.
//  Copyright © 2016年 Ghoul. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol Mp3RecorderDelegate <NSObject>

- (void)failRecord;
- (void)beginConvert;
- (void)recording:(float)recordTime volume:(float)volume;
- (void)endConvertWithData:(NSData *)voiceData;

@end

@interface MP3Recorder : NSObject {
    double lowPassResults;
    float recordTime;
    NSTimer *playTimer;
}
@property (nonatomic, weak) id<Mp3RecorderDelegate> delegate;

- (id)initWithDelegate:(id<Mp3RecorderDelegate>)delegate;
- (void)startRecord;
- (void)stopRecord;
- (void)cancelRecord;


@end
