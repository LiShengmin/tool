//
//  FFTSchoolDemoViewController.m
//  实用工具包
//
//  Created by Lcvem on 16/4/1.
//  Copyright © 2016年 Ghoul. All rights reserved.
//

#import "FFTSchoolDemoViewController.h"

static vDSP_Length const FFTViewControllerFFTWindowSize = 4096;

@interface FFTSchoolDemoViewController ()

@end

@implementation FFTSchoolDemoViewController

#pragma mark - Status Bar Style
//------------------------------------------------------------------------------

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

//------------------------------------------------------------------------------
#pragma mark - View Lifecycle
//------------------------------------------------------------------------------
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor FFTSchoolDemo_audioPlotFreqViewBGColor];
    
    EZAudioPlot * plotFreq = [[EZAudioPlot alloc] initWithFrame:CGRectMake(0, 0,375, 650)];
    _audioPlotFreq = plotFreq;
    _audioPlotFreq.backgroundColor = [UIColor FFTSchoolDemo_audioPlotFreqViewBGColor];
    _audioPlotFreq.color = [UIColor whiteColor];
    [self.view addSubview:_audioPlotFreq];
    [_audioPlotFreq mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view).insets(UIEdgeInsetsMake(64, 0, 200, 0));
    }];
    
    EZAudioPlot * plotTime = [[EZAudioPlot alloc] initWithFrame:CGRectMake(0, 0,375, 140)];
    plotTime.color = [UIColor whiteColor];
    _audioPlotTime = plotTime;
    [self.audioPlotFreq addSubview:self.audioPlotTime];
    [_audioPlotTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.audioPlotFreq).insets(UIEdgeInsetsMake(0, 16, 0, 13));
        make.height.mas_equalTo(@100);
    }];
    
    UILabel * lable =  [[UILabel alloc] init];
    _maxFrequencyLabel = lable;
    _maxFrequencyLabel.textColor = [UIColor whiteColor];
    [self.audioPlotFreq addSubview:_maxFrequencyLabel];
    [_maxFrequencyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.audioPlotTime.mas_bottom).offset(-18);
        make.left.equalTo(self.audioPlotTime.mas_left).offset(0);
    }];
    //
    // Setup the AVAudioSession. EZMicrophone will not work properly on iOS
    // if you don't do this!
    //
    AVAudioSession *session = [AVAudioSession sharedInstance];
    NSError *error;
    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:&error];
    if (error)
    {
        NSLog(@"Error setting up audio session category: %@", error.localizedDescription);
    }
    [session setActive:YES error:&error];
    if (error)
    {
        NSLog(@"Error setting up audio session active: %@", error.localizedDescription);
    }
    
    //
    // Setup time domain audio plot
    //
    self.audioPlotTime.plotType = EZPlotTypeBuffer;
    self.maxFrequencyLabel.numberOfLines = 0;
    
    //
    // Setup frequency domain audio plot
    //
    self.audioPlotFreq.shouldFill = YES;
    self.audioPlotFreq.plotType = EZPlotTypeBuffer;
    self.audioPlotFreq.shouldCenterYAxis = NO;
    
    //
    // Create an instance of the microphone and tell it to use this view controller instance as the delegate
    //
    self.microphone = [EZMicrophone microphoneWithDelegate:self];
    
    //
    // Create an instance of the EZAudioFFTRolling to keep a history of the incoming audio data and calculate the FFT.
    //
    self.fft = [EZAudioFFTRolling fftWithWindowSize:FFTViewControllerFFTWindowSize
                                         sampleRate:self.microphone.audioStreamBasicDescription.mSampleRate
                                           delegate:self];
    
    //
    // Start the mic
    //
    [self.microphone startFetchingAudio];
}

//------------------------------------------------------------------------------
#pragma mark - EZMicrophoneDelegate
//------------------------------------------------------------------------------

-(void)    microphone:(EZMicrophone *)microphone
     hasAudioReceived:(float **)buffer
       withBufferSize:(UInt32)bufferSize
 withNumberOfChannels:(UInt32)numberOfChannels
{
    //
    // Calculate the FFT, will trigger EZAudioFFTDelegate
    //
    [self.fft computeFFTWithBuffer:buffer[0] withBufferSize:bufferSize];
    
    __weak typeof (self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf.audioPlotTime updateBuffer:buffer[0]
                              withBufferSize:bufferSize];
    });
}

//------------------------------------------------------------------------------
#pragma mark - EZAudioFFTDelegate
//------------------------------------------------------------------------------

- (void)        fft:(EZAudioFFT *)fft
 updatedWithFFTData:(float *)fftData
         bufferSize:(vDSP_Length)bufferSize
{
    float maxFrequency = [fft maxFrequency];
    NSString *noteName = [EZAudioUtilities noteNameStringForFrequency:maxFrequency
                                                        includeOctave:YES];
    
    __weak typeof (self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        weakSelf.maxFrequencyLabel.text = [NSString stringWithFormat:@"Highest Note: %@,\nFrequency: %.2f", noteName, maxFrequency];
        [weakSelf.audioPlotFreq updateBuffer:fftData withBufferSize:(UInt32)bufferSize];
    });
}
@end
