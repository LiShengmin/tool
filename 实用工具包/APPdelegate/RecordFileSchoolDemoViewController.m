//
//  RecordFileSchoolDemoViewController.m
//  实用工具包
//
//  Created by Lcvem on 16/4/3.
//  Copyright © 2016年 Ghoul. All rights reserved.
//

#import "RecordFileSchoolDemoViewController.h"

@interface RecordFileSchoolDemoViewController ()

@end

@implementation RecordFileSchoolDemoViewController

 
#pragma mark - Dealloc
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Status Bar Style
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)initizial {
    _currentTimeLabel = [[UILabel alloc] init];
    _currentTimeLabel.text = @"00:00";
    _currentTimeLabel.font = [UIFont systemFontOfSize:30];
    _currentTimeLabel.textColor = [UIColor whiteColor];
    _playingStateLabel = [[UILabel alloc] init];
    _playingStateLabel.text = @"platingStateLabel";
    _recordingStateLabel = [[UILabel alloc] init];
    _recordingStateLabel.text = @"recordingStateLabel";
    _microphoneStateLabel = [[UILabel alloc] init];
    _microphoneStateLabel.text = @"_microphoneStateLabel";
    
    _playButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _playButton.titleLabel.text = @"Play";
    _playButton.backgroundColor = [UIColor lightGrayColor];
    [_playButton setTitle:@"Playing" forState:UIControlStateNormal];
    [_playButton setTitle:@"Play" forState:UIControlStateSelected];
    [_playButton addTarget:self action:@selector(playFile:) forControlEvents:UIControlEventTouchUpInside];
    
    _recordSwitch = [[UISwitch alloc] init];
    [_recordSwitch addTarget:self action:@selector(toggleRecording:) forControlEvents:UIControlEventValueChanged];
    _microphoneSwitch = [[UISwitch alloc] init];
    [_microphoneSwitch addTarget:self action:@selector(toggleMicrophone:) forControlEvents:UIControlEventValueChanged];
    
    _playingAudioPlot = [[EZAudioPlot alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    
    _recordingAudioPlot = [[EZAudioPlotGL alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    
    [self.view addSubview:_currentTimeLabel];
    [self.view addSubview:_playingStateLabel];
    [self.view addSubview:_recordingStateLabel];
    [self.view addSubview:_microphoneStateLabel];
    [self.view addSubview:_playButton];
    [self.view addSubview:_recordSwitch];
    [self.view addSubview:_microphoneSwitch];
    [self.view addSubview:_playingAudioPlot];
    [self.view insertSubview:_recordingAudioPlot atIndex:0];
    
    [_currentTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.view.mas_top).offset(0);
//        make.left.equalTo(self.view.mas_left).offset(0);
        make.top.left.equalTo(self.view).insets(UIEdgeInsetsMake(64, 0, 0, 0));
        make.height.mas_offset(@60);
        make.width.mas_offset(@90);
    }];
    [_playingAudioPlot mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 0, 0));
        make.left.equalTo(self.currentTimeLabel.mas_right).offset(30);
        make.height.mas_offset(@200);
    }];
    
    [_playButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.recordSwitch.mas_top).offset(0);
        make.left.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 0, 0));
        make.height.mas_offset(@30);
        make.width.mas_offset(@70);
    }];
    [_playingStateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.playButton.mas_right).offset(0);
        make.right.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 0, 0));
        make.top.equalTo(self.playButton.mas_top).offset(0);
        make.height.mas_offset(@30);
    }];
    
    [_recordingStateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.recordSwitch.mas_right).offset(0);
        make.right.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 0, 0));
        make.top.equalTo(self.recordSwitch.mas_top).offset(0);
        make.height.mas_offset(@30);
    }];
    [_microphoneStateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.microphoneSwitch.mas_right).offset(0);
        make.right.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 0, 0));
        make.top.equalTo(self.microphoneSwitch.mas_top).offset(0);
        make.height.mas_offset(@30);
    }];
    
    [_recordSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.microphoneSwitch.mas_top).offset(0);
        make.left.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 0, 0));
        make.height.mas_offset(@30);
    }];
    [_microphoneSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.recordSwitch.mas_bottom).offset(0);
        make.left.bottom.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 0, 0));
        make.height.mas_offset(@30);
    }];
    
    [_recordingAudioPlot mas_makeConstraints:^(MASConstraintMaker *make) {
        MAS_MAKE_ZERO(self.view);
    }];
}
#pragma mark - Setup
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor RecordFileSchoolDemo_playingAudioPlotBGColor];
    
    [self initizial];
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
    // Customizing the audio plot that'll show the current microphone input/recording
    //
    self.recordingAudioPlot.backgroundColor = [UIColor clearColor];
    self.recordingAudioPlot.color           = [UIColor RecordFileSchoolDemo_recordingAudioPlotLineColor];
    self.recordingAudioPlot.plotType        = EZPlotTypeRolling;
    self.recordingAudioPlot.shouldFill      = YES;
    self.recordingAudioPlot.shouldMirror    = YES;
    
    //
    // Customizing the audio plot that'll show the playback
    //
//    self.playingAudioPlot.backgroundColor = [UIColor RecordFileSchoolDemo_playingAudioPlotBGColor];
    self.playingAudioPlot.color = [UIColor whiteColor];
    self.playingAudioPlot.plotType = EZPlotTypeRolling;
    self.playingAudioPlot.shouldFill = YES;
    self.playingAudioPlot.shouldMirror = YES;
    self.playingAudioPlot.gain = 2.5f;
    
    // Create an instance of the microphone and tell it to use this view controller instance as the delegate
    self.microphone = [EZMicrophone microphoneWithDelegate:self];
    self.player = [EZAudioPlayer audioPlayerWithDelegate:self];
    
    //
    // Override the output to the speaker. Do this after creating the EZAudioPlayer
    // to make sure the EZAudioDevice does not reset this.
    //
    [session overrideOutputAudioPort:AVAudioSessionPortOverrideSpeaker error:&error];
    if (error)
    {
        NSLog(@"Error overriding output to the speaker: %@", error.localizedDescription);
    }
    
    //
    // Initialize UI components
    //
    self.microphoneStateLabel.text = @"Microphone On";
    self.recordingStateLabel.text = @"Not Recording";
    self.playingStateLabel.text = @"Not Playing";
    self.playButton.enabled = NO;
    
    //
    // Setup notifications
    //
    [self setupNotifications];
    
    //
    // Log out where the file is being written to within the app's documents directory
    //
    NSLog(@"File written to application sandbox's documents directory: %@",[self testFilePathURL]);
    
    //
    // Start the microphone
    //
    [self.microphone startFetchingAudio];
}

 

- (void)setupNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playerDidChangePlayState:)
                                                 name:EZAudioPlayerDidChangePlayStateNotification
                                               object:self.player];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playerDidReachEndOfFile:)
                                                 name:EZAudioPlayerDidReachEndOfFileNotification
                                               object:self.player];
}

 
#pragma mark - Notifications
 

- (void)playerDidChangePlayState:(NSNotification *)notification
{
    __weak typeof (self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        EZAudioPlayer *player = [notification object];
        BOOL isPlaying = [player isPlaying];
        if (isPlaying)
        {
            weakSelf.recorder.delegate = nil;
        }
        weakSelf.playingStateLabel.text = isPlaying ? @"Playing" : @"Not Playing";
        weakSelf.playingAudioPlot.hidden = !isPlaying;
    });
}

 

- (void)playerDidReachEndOfFile:(NSNotification *)notification
{
    __weak typeof (self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf.playingAudioPlot clear];
    });
}

 
#pragma mark - Actions
 

- (void)playFile:(id)sender
{
    //
    // Update microphone state
    //
    [self.microphone stopFetchingAudio];
    
    //
    // Update recording state
    //
    self.isRecording = NO;
    self.recordingStateLabel.text = @"Not Recording";
    self.recordSwitch.on = NO;
    
    self.playingAudioPlot.backgroundColor = [UIColor RecordFileSchoolDemo_playingAudioPlotBGColor];
    //
    // Close the audio file
    //
    if (self.recorder)
    {
        [self.recorder closeAudioFile];
    }
    
    EZAudioFile *audioFile = [EZAudioFile audioFileWithURL:[self testFilePathURL]];
    [self.player playAudioFile:audioFile];
}

 

- (void)toggleMicrophone:(id)sender
{
    [self.player pause];
    
    BOOL isOn = [(UISwitch*)sender isOn];
    if (!isOn)
    {
        [self.microphone stopFetchingAudio];
    }
    else
    {
        [self.microphone startFetchingAudio];
    }
}

 

- (void)toggleRecording:(id)sender
{
    [self.player pause];
    if ([sender isOn])
    {
        //
        // Create the recorder
        //
        [self.recordingAudioPlot clear];
        [self.microphone startFetchingAudio];
        self.recorder = [EZRecorder recorderWithURL:[self testFilePathURL]
                                       clientFormat:[self.microphone audioStreamBasicDescription]
                                           fileType:EZRecorderFileTypeM4A
                                           delegate:self];
        self.playButton.enabled = YES;
    }
    self.isRecording = (BOOL)[sender isOn];
    self.recordingStateLabel.text = self.isRecording ? @"Recording" : @"Not Recording";
}

 
#pragma mark - EZMicrophoneDelegate
 

- (void)microphone:(EZMicrophone *)microphone changedPlayingState:(BOOL)isPlaying
{
    self.microphoneStateLabel.text = isPlaying ? @"Microphone On" : @"Microphone Off";
    self.microphoneSwitch.on = isPlaying;
}

 

#warning Thread Safety
//
// Note that any callback that provides streamed audio data (like streaming
// microphone input) happens on a separate audio thread that should not be
// blocked. When we feed audio data into any of the UI components we need to
// explicity create a GCD block on the main thread to properly get the UI to
// work.
- (void)   microphone:(EZMicrophone *)microphone
     hasAudioReceived:(float **)buffer
       withBufferSize:(UInt32)bufferSize
 withNumberOfChannels:(UInt32)numberOfChannels
{
    // Getting audio data as an array of float buffer arrays. What does that
    // mean? Because the audio is coming in as a stereo signal the data is split
    // into a left and right channel. So buffer[0] corresponds to the float* data
    // for the left channel while buffer[1] corresponds to the float* data for
    // the right channel.
    
    //
    // See the Thread Safety warning above, but in a nutshell these callbacks
    // happen on a separate audio thread. We wrap any UI updating in a GCD block
    // on the main thread to avoid blocking that audio flow.
    //
    __weak typeof (self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        //
        // All the audio plot needs is the buffer data (float*) and the size.
        // Internally the audio plot will handle all the drawing related code,
        // history management, and freeing its own resources. Hence, one badass
        // line of code gets you a pretty plot :)
        //
        [weakSelf.recordingAudioPlot updateBuffer:buffer[0]
                                   withBufferSize:bufferSize];
    });
}

 

- (void)   microphone:(EZMicrophone *)microphone
        hasBufferList:(AudioBufferList *)bufferList
       withBufferSize:(UInt32)bufferSize
 withNumberOfChannels:(UInt32)numberOfChannels
{
    //
    // Getting audio data as a buffer list that can be directly fed into the
    // EZRecorder. This is happening on the audio thread - any UI updating needs
    // a GCD main queue block. This will keep appending data to the tail of the
    // audio file.
    //
    if (self.isRecording)
    {
        [self.recorder appendDataFromBufferList:bufferList
                                 withBufferSize:bufferSize];
    }
}

 
#pragma mark - EZRecorderDelegate
 

- (void)recorderDidClose:(EZRecorder *)recorder
{
    recorder.delegate = nil;
}

 

- (void)recorderUpdatedCurrentTime:(EZRecorder *)recorder
{
    __weak typeof (self) weakSelf = self;
    NSString *formattedCurrentTime = [recorder formattedCurrentTime];
    dispatch_async(dispatch_get_main_queue(), ^{
        weakSelf.currentTimeLabel.text = formattedCurrentTime;
    });
}

 
#pragma mark - EZAudioPlayerDelegate
 

- (void) audioPlayer:(EZAudioPlayer *)audioPlayer
         playedAudio:(float **)buffer
      withBufferSize:(UInt32)bufferSize
withNumberOfChannels:(UInt32)numberOfChannels
         inAudioFile:(EZAudioFile *)audioFile
{
    __weak typeof (self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf.playingAudioPlot updateBuffer:buffer[0]
                                 withBufferSize:bufferSize];
    });
}

 

- (void)audioPlayer:(EZAudioPlayer *)audioPlayer
    updatedPosition:(SInt64)framePosition
        inAudioFile:(EZAudioFile *)audioFile
{
    __weak typeof (self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        weakSelf.currentTimeLabel.text = [audioPlayer formattedCurrentTime];
    });
}

 
#pragma mark - Utility
 

- (NSArray *)applicationDocuments
{
    return NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
}

 

- (NSString *)applicationDocumentsDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    return basePath;
}

 

- (NSURL *)testFilePathURL
{
    return [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@",
                                   [self applicationDocumentsDirectory],
                                   kAudioFilePath]];
}

@end
