//
//  ViewController.m
//  AudioQueueRecordAndPlayback
//
//  Created by 小东邪 on 2019/5/3.
//  Copyright © 2019 小东邪. All rights reserved.
//

#import "ViewController.h"
#import "QueueProcess.h"
#import "AudioFileHandler.h"
#import "AudioQueuePlayer.h"
#import "AudioQueueCaptureManager.h"

#import <AVFoundation/AVFoundation.h>

#define kReadAudioPacketsNum 4096

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
    [[AudioQueueCaptureManager getInstance] stopAudioCapture];
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
        [[AudioQueueCaptureManager getInstance] startRecordFile];

    } else {
        [btn setBackgroundImage:[UIImage imageNamed:@"icon_recored_audio_pre"] forState:UIControlStateNormal];
        [[AudioQueueCaptureManager getInstance] stopRecordFile];
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
    [[AudioQueuePlayer getInstance] configureAudioPlayerWithAudioFormat:&audioFormat bufferSize:kReadAudioPacketsNum * audioFormat.mBytesPerPacket];
}

- (void)startAudioCapture {
    
    [[AudioQueueCaptureManager getInstance] startAudioCapture];
}

- (void)startPlay {
    
    // Configure Audio File
    NSString *filePath = [AudioFileHandler getInstance].recordFilePath;
    AudioFileHandler *fileHandler = [AudioFileHandler getInstance];
    [fileHandler configurePlayFilePath:filePath];
    NSLog(@"filePath = %@", filePath);

    [self putAudioDataIntoDataQueue];
    [[AudioQueuePlayer getInstance] startAudioPlayer];
    
    self.isStopPlay = NO;
}

- (void)stopPlay {
    
    [[AudioQueuePlayer getInstance] stopAudioPlayer];
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
                [[AudioFileHandler getInstance] resetFileForPlay];
                CustomQueueProcess *audioBufferQueue =  [AudioQueuePlayer getInstance]->_audioBufferQueue;
                audioBufferQueue->ResetFreeQueue(audioBufferQueue->m_work_queue, audioBufferQueue->m_free_queue);
                return;
            }
            
            void *audioData = malloc([AudioQueuePlayer audioBufferSize]);
            readBytes = [[AudioFileHandler getInstance] readAudioFromFileBytesWithAudioDataRef:audioData
                                                                                       packetDesc:packetDesc
                                                                                   readPacketsNum:kReadAudioPacketsNum];
            
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
    CustomQueueProcess *audioBufferQueue =  [AudioQueuePlayer getInstance]->_audioBufferQueue;
    
    CustomQueueNode *node = audioBufferQueue->DeQueue(audioBufferQueue->m_free_queue);
    if (node == NULL) {
        NSLog(@"CustomQueueProcess addBufferToWorkQueueWithSampleBuffer : Data in , the node is NULL !");
        return;
    }
    node->data = data;
    node->size = size;
    node->userData = userData;
    audioBufferQueue->EnQueue(audioBufferQueue->m_work_queue, node);
    
    NSLog(@"CustomQueueProcess addBufferToWorkQueueWithSampleBuffer : Data in ,  work size = %d, free size = %d !",audioBufferQueue->m_work_queue->size, audioBufferQueue->m_free_queue->size);
}

@end
