//
//  D3RecordButton.m
//  实用工具包
//
//  Created by Ghoul on 16/3/24.
//  Copyright © 2016年 Ghoul. All rights reserved.
//

#import "D3RecordButton.h"
#import "RecoderHUD.h"

@implementation D3RecordButton

-(void)initRecord:(id<D3RecordDelegate>)delegate maxtime:(int)_maxTime title:(NSString *)_title{
    self.delegate = delegate;
    maxTime = _maxTime;
    title = _title;
    mp3 = [[MP3Recorder alloc]initWithDelegate:self];
    
    [self addTarget:self action:@selector(startRecord) forControlEvents:UIControlEventTouchDown];
    [self addTarget:self action:@selector(stopRecord) forControlEvents:UIControlEventTouchUpInside];
    [self addTarget:self action:@selector(cancelRecord) forControlEvents:UIControlEventTouchUpOutside | UIControlEventTouchCancel];
    [self addTarget:self action:@selector(RemindDragExit:) forControlEvents:UIControlEventTouchDragExit];
    [self addTarget:self action:@selector(RemindDragEnter:) forControlEvents:UIControlEventTouchDragEnter];
}

-(void)initRecord:(id<D3RecordDelegate>)delegate maxtime:(int)_maxTime{
    [self initRecord:delegate maxtime:_maxTime title:nil];
}


//开始录音
-(void)startRecord{
    [mp3 startRecord];
    [RecoderHUD show];
    [self setHUDTitle];
}

//正常停止录音，开始转换数据
-(void)stopRecord{
    [mp3 stopRecord];
    [RecoderHUD dismiss];
}

//取消录音
-(void)cancelRecord{
    [mp3 cancelRecord];
    [RecoderHUD dismiss];
    [RecoderHUD setTitle:@"已取消录音"];
}

//离开按钮范围
- (void)RemindDragExit:(UIButton *)button
{
    [RecoderHUD setTitle:@"松手取消录音"];
    if ([_delegate respondsToSelector:@selector(dragExit)]) {
        [_delegate dragExit];
    }
}

//进入按钮范围
- (void)RemindDragEnter:(UIButton *)button
{
    [self setHUDTitle];
    if ([_delegate respondsToSelector:@selector(dragEnter)]) {
        [_delegate dragEnter];
    }
}

-(void)setHUDTitle{
    if (title != nil) {
        [RecoderHUD setTitle:title];
    }
    else{
        [RecoderHUD setTitle:@"离开按钮取消录音"];
    }
}


#pragma mark Mp3RecordDelegate
-(void)beginConvert{
}

//录音失败
- (void)failRecord
{
    DLog(@"%@",@"录音失败");
}


//回调录音资料
- (void)endConvertWithData:(NSData *)voiceData
{
    [RecoderHUD setTitle:@"录音成功"];
    if ([_delegate respondsToSelector:@selector(endRecord:)]) {
        [_delegate endRecord:voiceData];
    }
}

-(void)recording:(float)recordTime volume:(float)volume{
    if (recordTime>=maxTime) {
        [self stopRecord];
    }
//    [RecoderHUD setImage:[NSString stringWithFormat:@"mic_%.0f.png",volume*10 > 5 ? 5 : volume*10]];
//    DLog(@"volume == %f",volume * 100000000);
//    DLog(@"recordTime == %f",recordTime);
    [RecoderHUD setTimeTitle:[NSString stringWithFormat:@"录音: %.0f\"",recordTime]];
}


@end
