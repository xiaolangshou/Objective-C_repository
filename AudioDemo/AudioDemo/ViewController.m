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

@property (nonatomic, strong) UIButton *startBtn;
@property (nonatomic, strong) UIButton *stopBtn;
@property (nonatomic, strong) UIButton *pauseBtn;
@property (nonatomic, strong) UIButton *deleteBtn;
@property (nonatomic, strong) UIButton *rerecordBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.audioRecorder = [self audioRecorder];
    [self setupView];
}

- (void)setupView {
    
    _startBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 100, 60, 30)];
    _startBtn.backgroundColor = UIColor.cyanColor;
    [_startBtn setTitle:@"开始" forState:UIControlStateNormal];
    [self.view addSubview:_startBtn];
    [_startBtn addTarget:self action:@selector(startBtnTapped) forControlEvents:UIControlEventTouchUpInside];
    
    _stopBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 140, 60, 30)];
    _stopBtn.backgroundColor = UIColor.cyanColor;
    [_stopBtn setTitle:@"停止" forState:UIControlStateNormal];
    [self.view addSubview:_stopBtn];
    [_stopBtn addTarget:self action:@selector(stopBtnTapped) forControlEvents:UIControlEventTouchUpInside];
    
    _pauseBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 180, 60, 30)];
    _pauseBtn.backgroundColor = UIColor.cyanColor;
    [_pauseBtn setTitle:@"暂停" forState:UIControlStateNormal];
    [self.view addSubview:_pauseBtn];
    [_pauseBtn addTarget:self action:@selector(pauseBtnTapped) forControlEvents:UIControlEventTouchUpInside];
    
    _deleteBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 220, 60, 30)];
    _deleteBtn.backgroundColor = UIColor.cyanColor;
    [_deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
    [self.view addSubview:_deleteBtn];
    [_deleteBtn addTarget:self action:@selector(deleteBtnTapped) forControlEvents:UIControlEventTouchUpInside];
    
    _rerecordBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 260, 60, 30)];
    _rerecordBtn.backgroundColor = UIColor.cyanColor;
    [_rerecordBtn setTitle:@"重录" forState:UIControlStateNormal];
    [self.view addSubview:_rerecordBtn];
    [_rerecordBtn addTarget:self action:@selector(rerecordBtnTapped) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)startBtnTapped {
    [self beginRecordWithRecordPath:_recordPath];
}

- (void)stopBtnTapped {
    [self endRecord];
}

- (void)pauseBtnTapped {
    [self pauseRecord];
}

- (void)deleteBtnTapped {
    [self deleteRecord];
}

- (void)rerecordBtnTapped {
    [self reRecord];
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

// 开始录音
- (void)beginRecordWithRecordPath: (NSString *)recordPath {
    // 记录录音地址
    _recordPath = recordPath;
    // 准备录音
    [self.audioRecorder prepareToRecord];
    // 开始录音
    [self.audioRecorder record];
}

// 结束录音
- (void)endRecord {
     [self.audioRecorder stop];
}

// 暂停录音
- (void)pauseRecord {
    [self.audioRecorder pause];
}

// 删除录音
- (void)deleteRecord {
     [self.audioRecorder stop];
     [self.audioRecorder deleteRecording];
}

// 重新录音
- (void)reRecord {

    self.audioRecorder = nil;
    [self beginRecordWithRecordPath:self.recordPath];
}

// 更新音频测量值
- (void)updateMeters
{
    [self.audioRecorder updateMeters];
}

// 获得指定声道的分贝峰值
- (float)peakPowerForChannel0 {

    [self.audioRecorder updateMeters];
    return [self.audioRecorder peakPowerForChannel:0];
}

@end
