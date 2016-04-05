//
//  RecordFileSchoolDemoViewController.h
//  实用工具包
//
//  Created by Lcvem on 16/4/3.
//  Copyright © 2016年 Ghoul. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "EZAudio.h"

#define kAudioFilePath @"test.m4a"

@interface RecordFileSchoolDemoViewController : UIViewController <EZAudioPlayerDelegate, EZMicrophoneDelegate, EZRecorderDelegate>

#pragma mark - Properties

@property (nonatomic, strong) UILabel *currentTimeLabel;
@property (nonatomic, strong) UILabel *playingStateLabel;
@property (nonatomic, strong) UILabel *recordingStateLabel;
@property (nonatomic, strong) UILabel *microphoneStateLabel;

@property (nonatomic, strong) UIButton *playButton;
@property (nonatomic, strong) UISwitch *recordSwitch;
@property (nonatomic, strong) UISwitch *microphoneSwitch;

@property (nonatomic, strong) EZAudioPlot *playingAudioPlot;
@property (nonatomic, strong) EZAudioPlotGL *recordingAudioPlot;


#pragma mark - Actions

- (void)playFile:(id)sender;
- (void)toggleMicrophone:(id)sender;
- (void)toggleRecording:(id)sender;


#pragma mark - Propertiess
//
// A flag indicating whether we are recording or not
//
@property (nonatomic, assign) BOOL isRecording;

 

//
// The microphone component
//
@property (nonatomic, strong) EZMicrophone *microphone;

 


//
// The audio player that will play the recorded file
//
@property (nonatomic, strong) EZAudioPlayer *player;

 

//
// The recorder component
//
@property (nonatomic, strong) EZRecorder *recorder;

 



@end
