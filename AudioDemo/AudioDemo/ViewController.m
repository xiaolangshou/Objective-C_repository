//
//  ViewController.m
//  AudioDemo
//
//  Created by Thomas Lau on 2020/7/1.
//  Copyright © 2020 TLLTD. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "lame.h"
#import "TLRecorderKit.h"

@interface ViewController ()

@property (nonatomic, strong) AVAudioRecorder *audioRecorder;
@property (nonatomic, assign) NSString *recordPath;

@property (nonatomic, strong) UIButton *startBtn;
@property (nonatomic, strong) UIButton *stopBtn;
@property (nonatomic, strong) UIButton *pauseBtn;
@property (nonatomic, strong) UIButton *deleteBtn;
@property (nonatomic, strong) UIButton *playBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

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
    
    _playBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 260, 60, 30)];
    _playBtn.backgroundColor = UIColor.cyanColor;
    [_playBtn setTitle:@"播放" forState:UIControlStateNormal];
    [self.view addSubview:_playBtn];
    [_playBtn addTarget:self action:@selector(playBtnTapped) forControlEvents:UIControlEventTouchUpInside];
}

- (void)startBtnTapped {
    
    NSLog(@"开始录音");
    // 不同的文件格式，存放不同的编码数据，caf结尾的文件，基本上可以存放任何苹果支持的编码格式
    [[TLAudioTool shareTLAudioTool] beginRecordWithRecordName:@"test"
                                               withRecordType:@"caf"
                                           withIsConventToMp3:YES];
}

- (void)stopBtnTapped {
    
    NSLog(@"停止录音");
    [[TLAudioTool shareTLAudioTool] endRecord];
}

- (void)pauseBtnTapped {
    
    NSLog(@"暂停录音");
    [[TLAudioTool shareTLAudioTool] pauseRecord];
}

- (void)deleteBtnTapped {
    
    NSLog(@"删除录音");
    [[TLAudioTool shareTLAudioTool] deleteRecord];
}

- (void)playBtnTapped {
    
    NSLog(@"播放录音");
    [[TLAudioPlayerTool shareTLAudioPlayerTool] playAudioWith: [cachesRecorderPath stringByAppendingPathComponent:@"test.mp3"]];
    [TLAudioPlayerTool shareTLAudioPlayerTool].span = 0;
    
    NSLog(@"volum: %f", [TLAudioPlayerTool shareTLAudioPlayerTool].volumn);
    NSLog(@"progress: %f", [TLAudioPlayerTool shareTLAudioPlayerTool].progress);
}

@end
