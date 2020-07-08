//
//  ViewController.m
//  AudioDemo3
//
//  Created by Thomas Lau on 2020/7/8.
//  Copyright © 2020 TLLTD. All rights reserved.
//

#import "ViewController.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    NSError *error = nil;
    // 音频会话分类（catehory）和模式（mode）一起决定了应用要使用音频的方式,
    // 也可以说是定制音频的行为。通常在激活音频会话之前设置分类和模式。也可以在激活音频会话时设置分类和模式,但是这样会立即路由（route)。
    // 如果分类设置成功，但会也是，反则返回no
    if([audioSession setCategory: AVAudioSessionCategoryPlayAndRecord error:&error]) {
        // 配置成功
    } else {
        // 配置失败
    }
}


@end
