//
//  AppDelegate.m
//  实用工具包
//
//  Created by Ghoul on 15/12/23.
//  Copyright © 2015年 Ghoul. All rights reserved.
//

#import "AppDelegate.h"
#import <AVFoundation/AVFoundation.h>
#import "MainViewController.h"
#import "RootNavgationController.h"

@interface AppDelegate ()

@property (nonatomic, unsafe_unretained) UIBackgroundTaskIdentifier backgroundUpdateTask;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    /**音频文件的支持*/
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];

    MainViewController * rootVC = [[MainViewController alloc] init];
    RootNavgationController * navgationController = [[RootNavgationController alloc] initWithRootViewController:rootVC];
    
    self.window.rootViewController = navgationController;
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    [self beginBackgroundUpdateTask];
    
    //此处添加在后台运行的代码
    
    [self endBackgroundUpdateTask];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)beginBackgroundUpdateTask {
    self.backgroundUpdateTask = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
        [self endBackgroundUpdateTask];
    }];
}

- (void)endBackgroundUpdateTask {
    [[UIApplication sharedApplication] endBackgroundTask:self.backgroundUpdateTask];
    self.backgroundUpdateTask = UIBackgroundTaskInvalid;
}



/**想无限制的延长在后台运行时间的做法*/
//1.在plish文件中加入背景播放的支持。
//加入项：Required background modes。并设置为：audio
//
//2.初始化一个AVAudioPlayer音频，并且无限制的播放下去。



//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//    
//    dispatch_queue_t dispatchQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    dispatch_async(dispatchQueue, ^(void) {
//        NSError *audioSessionError = nil;
//        AVAudioSession *audioSession = [AVAudioSession sharedInstance];
//        if ([audioSession setCategory:AVAudioSessionCategoryPlayback error:&audioSessionError]){
//            NSLog(@"Successfully set the audio session.");
//        } else {
//            NSLog(@"Could not set the audio session");
//        }
//        
//        
//        NSBundle *mainBundle = [NSBundle mainBundle];
//        NSString *filePath = [mainBundle pathForResource:@"mySong" ofType:@"mp3"];
//        NSData *fileData = [NSData dataWithContentsOfFile:filePath];
//        NSError *error = nil;
//        
//        self.audioPlayer = [[AVAudioPlayer alloc] initWithData:fileData error:&error];
//        
//        if (self.audioPlayer != nil){
//            self.audioPlayer.delegate = self;
//            
//            [self.audioPlayer setNumberOfLoops:-1];
//            if ([self.audioPlayer prepareToPlay] && [self.audioPlayer play]){
//                NSLog(@"Successfully started playing...");
//            } else {
//                NSLog(@"Failed to play.");
//            }
//        } else {
//            
//        }
//    });
//}


@end
