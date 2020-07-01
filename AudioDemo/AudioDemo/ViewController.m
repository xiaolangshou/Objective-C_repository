//
//  ViewController.m
//  AudioDemo
//
//  Created by Thomas Lau on 2020/7/1.
//  Copyright © 2020 TLLTD. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) AVAudioRecorder *audioRecorder;
@property (nonatomic, assign) NSString *recordPath;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

// 定义一个录音对象，懒加载
- (AVAudioRecorder *)audioRecorder
{
    if (!_audioRecorder) {

       // 0. 设置录音会话
       /**
         AVAudioSessionCategoryPlayAndRecord: 可以边播放边录音(也就是平时看到的背景音乐)
        */
       [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
       // 启动会话
       [[AVAudioSession sharedInstance] setActive:YES error:nil];

       // 1. 确定录音存放的位置
       NSURL *url = [NSURL URLWithString:self.recordPath];

       // 2. 设置录音参数
       NSMutableDictionary *recordSettings = [[NSMutableDictionary alloc] init];
       // 设置编码格式
       /**
         kAudioFormatLinearPCM: 无损压缩，内容非常大
         kAudioFormatMPEG4AAC
       */
       [recordSettings setValue :[NSNumber numberWithInt: kAudioFormatLinearPCM] forKey: AVFormatIDKey];
       // 采样率(通过测试的数据，根据公司的要求可以再去调整)，必须保证和转码设置的相同
       [recordSettings setValue :[NSNumber numberWithFloat:11025.0] forKey: AVSampleRateKey];
       // 通道数（必须设置为双声道, 不然转码生成的 MP3 会声音尖锐变声.）
       [recordSettings setValue :[NSNumber numberWithInt:2] forKey: AVNumberOfChannelsKey];

       //音频质量,采样质量(音频质量越高，文件的大小也就越大)
       [recordSettings setValue:[NSNumber numberWithInt:AVAudioQualityMin] forKey:AVEncoderAudioQualityKey];

       // 3. 创建录音对象
       _audioRecorder = [[AVAudioRecorder alloc] initWithURL:url settings:recordSettings error:nil];
       _audioRecorder.meteringEnabled = YES;
     }
   return _audioRecorder;
}
@end
