//
//  FFTSchoolDemoViewController.h
//  实用工具包
//
//  Created by Lcvem on 16/4/1.
//  Copyright © 2016年 Ghoul. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EZAudio.h"

@interface FFTSchoolDemoViewController : UIViewController  <EZMicrophoneDelegate, EZAudioFFTDelegate>

//------------------------------------------------------------------------------
#pragma mark - Properties
//------------------------------------------------------------------------------

//
// EZAudioPlot for frequency plot
//
@property (nonatomic,strong) EZAudioPlot *audioPlotFreq;

//
// EZAudioPlot for time plot
//
@property (nonatomic,strong) EZAudioPlot *audioPlotTime;

//
// A label used to display the maximum frequency (i.e. the frequency with the
// highest energy) calculated from the FFT.
//
@property (nonatomic, strong) UILabel *maxFrequencyLabel;

//
// The microphone used to get input.
//
@property (nonatomic,strong) EZMicrophone *microphone;

//
// Used to calculate a rolling FFT of the incoming audio data.
//
@property (nonatomic, strong) EZAudioFFTRolling *fft;


@end
