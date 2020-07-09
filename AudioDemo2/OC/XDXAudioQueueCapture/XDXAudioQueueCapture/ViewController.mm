//
//  ViewController.m
//  XDXAudioQueueRecordAndPlayback
//
//  Created by 小东邪 on 2019/5/3.
//  Copyright © 2019 小东邪. All rights reserved.
//

#import "ViewController.h"
#import "XDXQueueProcess.h"
#import "XDXAudioFileHandler.h"
#import "XDXAudioQueuePlayer.h"
#import "XDXAudioQueueCaptureManager.h"

#import <AVFoundation/AVFoundation.h>

#define kXDXReadAudioPacketsNum 4096

@interface ViewController ()

@property (nonatomic, assign) BOOL isStopPlay;
@property (nonatomic, strong) UIButton *recordBtn;
@property (nonatomic, strong) UIButton *playBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configAudioQueuePlayer];
    [self startAudioCapture];
    [self setupUI];
}

- (void)dealloc {
    [[XDXAudioQueueCaptureManager getInstance] stopAudioCapture];
}

- (void)setupUI {
    
    _recordBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.center.x - 30, 150, 60, 60)];
    [self.view addSubview:_recordBtn];
    _recordBtn.layer.cornerRadius = 30;
    [_recordBtn setBackgroundImage:[UIImage imageNamed:@"icon_recored_audio_pre"] forState:UIControlStateNormal];
    [_recordBtn addTarget:self action:@selector(recordBtnTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    _playBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.center.x - 28, 240, 56, 56)];
    [self.view addSubview:_playBtn];
    _playBtn.layer.cornerRadius = 30;
    [_playBtn setBackgroundImage:[UIImage imageNamed:@"icon_record_play"] forState:UIControlStateNormal];
    [_playBtn addTarget:self action:@selector(playBtnTapped:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)recordBtnTapped: (UIButton *)btn {

    [btn setSelected:!btn.isSelected];
    
    if (btn.isSelected) {
        [btn setBackgroundImage:[UIImage imageNamed:@"icon_recored_audio"] forState:UIControlStateNormal];
        [[XDXAudioQueueCaptureManager getInstance] startRecordFile];

    } else {
        [btn setBackgroundImage:[UIImage imageNamed:@"icon_recored_audio_pre"] forState:UIControlStateNormal];
        [[XDXAudioQueueCaptureManager getInstance] stopRecordFile];
    }
}

- (void)playBtnTapped: (UIButton *)btn {

    [btn setSelected:!btn.isSelected];
    
    if (btn.isSelected) {
        [btn setBackgroundImage:[UIImage imageNamed:@"icon_record_stop"] forState:UIControlStateNormal];
        [self startPlay];
    } else {
        [btn setBackgroundImage:[UIImage imageNamed:@"icon_record_play"] forState:UIControlStateNormal];
        [self stopPlay];
    }
}

- (void)configAudioQueuePlayer {
    
    AudioStreamBasicDescription audioFormat = {
        .mSampleRate         = 44100,
        .mFormatID           = kAudioFormatLinearPCM,
        .mChannelsPerFrame   = 1,
        .mFormatFlags        = kLinearPCMFormatFlagIsSignedInteger | kLinearPCMFormatFlagIsPacked,
        .mBitsPerChannel     = 16,
        .mBytesPerPacket     = 2,
        .mBytesPerFrame      = 2,
        .mFramesPerPacket    = 1,
    };
    
    // Configure Audio Queue Player
    [[XDXAudioQueuePlayer getInstance] configureAudioPlayerWithAudioFormat:&audioFormat bufferSize:kXDXReadAudioPacketsNum * audioFormat.mBytesPerPacket];
}

- (void)startAudioCapture {
    
    [[XDXAudioQueueCaptureManager getInstance] startAudioCapture];
}

- (void)startPlay {
    
    // Configure Audio File
    NSString *filePath = [XDXAudioFileHandler getInstance].recordFilePath;
    XDXAudioFileHandler *fileHandler = [XDXAudioFileHandler getInstance];
    [fileHandler configurePlayFilePath:filePath];
    NSLog(@"filePath = %@", filePath);

    [self putAudioDataIntoDataQueue];
    [[XDXAudioQueuePlayer getInstance] startAudioPlayer];
    
    self.isStopPlay = NO;
}

- (void)stopPlay {
    
    [[XDXAudioQueuePlayer getInstance] stopAudioPlayer];
    self.isStopPlay = YES;
}

#pragma mark - Other

- (void)putAudioDataIntoDataQueue {
    AudioStreamPacketDescription *packetDesc = NULL;
    __block UInt32 readBytes;
    
    // Note: our send audio rate should > play audio rate
    if (@available(iOS 10.0, *)) {
        [NSTimer scheduledTimerWithTimeInterval:0.09 repeats:YES block:^(NSTimer * _Nonnull timer) {
            if (self.isStopPlay) {
                [timer invalidate];
                [[XDXAudioFileHandler getInstance] resetFileForPlay];
                XDXCustomQueueProcess *audioBufferQueue =  [XDXAudioQueuePlayer getInstance]->_audioBufferQueue;
                audioBufferQueue->ResetFreeQueue(audioBufferQueue->m_work_queue, audioBufferQueue->m_free_queue);
                return;
            }
            
            void *audioData = malloc([XDXAudioQueuePlayer audioBufferSize]);
            readBytes = [[XDXAudioFileHandler getInstance] readAudioFromFileBytesWithAudioDataRef:audioData
                                                                                       packetDesc:packetDesc
                                                                                   readPacketsNum:kXDXReadAudioPacketsNum];
            
            if (readBytes > 0) {
                [self addBufferToWorkQueueWithAudioData:audioData size:readBytes userData:packetDesc];
            }else {
                [timer invalidate];
            }
            
        }];
    } else {
        // Fallback on earlier versions
        NSLog(@"iOS version less than 10.0, please update");
    }
}

- (void)addBufferToWorkQueueWithAudioData:(void *)data  size:(int)size userData:(void *)userData {
    XDXCustomQueueProcess *audioBufferQueue =  [XDXAudioQueuePlayer getInstance]->_audioBufferQueue;
    
    XDXCustomQueueNode *node = audioBufferQueue->DeQueue(audioBufferQueue->m_free_queue);
    if (node == NULL) {
        NSLog(@"XDXCustomQueueProcess addBufferToWorkQueueWithSampleBuffer : Data in , the node is NULL !");
        return;
    }
    node->data = data;
    node->size = size;
    node->userData = userData;
    audioBufferQueue->EnQueue(audioBufferQueue->m_work_queue, node);
    
    NSLog(@"XDXCustomQueueProcess addBufferToWorkQueueWithSampleBuffer : Data in ,  work size = %d, free size = %d !",audioBufferQueue->m_work_queue->size, audioBufferQueue->m_free_queue->size);
}

@end
