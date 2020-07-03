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
#import "UIImage+Extension.h"

@interface ViewController ()

@property (nonatomic, strong) AVAudioRecorder *audioRecorder;
@property (nonatomic, assign) NSString *recordPath;
@property (nonatomic, strong) UIButton *startBtn;
@property (nonatomic, strong) UIButton *playBtn;
@property (nonatomic, strong) UIActivityIndicatorView *indicator;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupView];
}

- (void)setupView {
    
    _startBtn = [[UIButton alloc] initWithFrame:CGRectMake(60, 200, 60, 30)];
    _startBtn.backgroundColor = UIColor.cyanColor;
    [_startBtn setTitle:@"开始" forState:UIControlStateNormal];
    [self.view addSubview:_startBtn];
    [_startBtn addTarget:self action:@selector(startBtnTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    _playBtn = [[UIButton alloc] initWithFrame:CGRectMake(60, 260, 60, 30)];
    _playBtn.backgroundColor = UIColor.cyanColor;
    [_playBtn setTitle:@"播放" forState:UIControlStateNormal];
    [self.view addSubview:_playBtn];
    [_playBtn addTarget:self action:@selector(playBtnTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    _indicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(130, 200, 30, 30)];
    [self.view addSubview:_indicator];
}

- (void)startBtnTapped: (UIButton *)btn {
    
    [btn setSelected:!btn.isSelected];
    
    if (btn.isSelected) {
        btn.backgroundColor = UIColor.redColor;
        [btn setTitle:@"停止" forState:UIControlStateNormal];
        
        NSLog(@"开始录音");
        // 不同的文件格式，存放不同的编码数据，caf结尾的文件，基本上可以存放任何苹果支持的编码格式
        [[TLAudioTool shareTLAudioTool] beginRecordWithRecordName:@"test"
                                                   withRecordType:@"caf"
                                               withIsConventToMp3:YES];
        
        [_indicator startAnimating];
    } else {
        btn.backgroundColor = UIColor.cyanColor;
        [btn setTitle:@"开始" forState:UIControlStateNormal];
        
        NSLog(@"停止录音");
        
        [self->_indicator stopAnimating];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [[TLAudioTool shareTLAudioTool] endRecord];
        });
    }
}

- (void)playBtnTapped: (UIButton *)btn {
    
    NSLog(@"播放录音");
    [[TLAudioPlayerTool shareTLAudioPlayerTool] playAudioWith: [cachesRecorderPath stringByAppendingPathComponent:@"test.mp3"]];
    [TLAudioPlayerTool shareTLAudioPlayerTool].span = 0;
    
    NSLog(@"volum: %f", [TLAudioPlayerTool shareTLAudioPlayerTool].volumn);
    NSLog(@"progress: %f", [TLAudioPlayerTool shareTLAudioPlayerTool].progress);
}

@end
