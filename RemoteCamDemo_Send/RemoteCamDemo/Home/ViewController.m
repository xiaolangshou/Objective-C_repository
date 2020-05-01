//
//  ViewController.m
//  RemoteCamDemo
//
//  Created by Thomas Lau on 2020/4/16.
//  Copyright © 2020 TLLTD. All rights reserved.
//

#import "ViewController.h"
#import "H264Encoder.h"
#import "TCPServer.h"
#import "GCDAsyncSocket.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()<AVCaptureVideoDataOutputSampleBufferDelegate, AVCaptureAudioDataOutputSampleBufferDelegate>

@property (nonatomic, strong) H264Encoder *h264code;
@property (nonatomic, strong) AVCaptureSession *captureSession;
@property (nonatomic, strong) AVCaptureDeviceInput *currentVideoDeviceInput;
@property (nonatomic, strong) AVCaptureDeviceInput *currentaudioDeviceInput;
@property (nonatomic, strong) AVCaptureVideoDataOutput *videoOutput;
@property (nonatomic, weak) AVCaptureVideoPreviewLayer *previedLayer;
@property (nonatomic, weak) AVCaptureConnection *videoConnection;
@property (nonatomic, weak) UIImageView *focusCursorImageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupView];
}

- (void)setupView {
    self.title = @"视频采集";
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 开启socket 监听,模拟服务端,等待客户端Socket连接后,发送视频流数据
    [[TCPServer shareInstance] openSerViceWithPort: 8889];
    
    [self setupCaputureVideo];
}

// 捕获音视频
- (void)setupCaputureVideo {
    
    // 1.创建捕获会话,必须要强引用，否则会被释放
    AVCaptureSession *captureSession = [[AVCaptureSession alloc] init];
    _captureSession = captureSession;
    
    // 1.1设置采集质量
    if ([captureSession canSetSessionPreset:AVCaptureSessionPresetiFrame1280x720]) {
        captureSession.sessionPreset = AVCaptureSessionPresetiFrame1280x720;
    }
    
    // 2.获取摄像头设备，默认是后置摄像头
    AVCaptureDevice *videoDevice = [self getVideoDevice:AVCaptureDevicePositionBack];
    
    // 3.获取声音设备
    AVCaptureDevice *audioDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeAudio];
    
    // 4.创建对应视频设备输入对象
    AVCaptureDeviceInput *videoDeviceInput = [AVCaptureDeviceInput deviceInputWithDevice:videoDevice error:nil];
    _currentVideoDeviceInput = videoDeviceInput;
    
    // 5.创建对应音频设备输入对象
    AVCaptureDeviceInput *audioDeviceInput = [AVCaptureDeviceInput deviceInputWithDevice:audioDevice error:nil];
    _currentaudioDeviceInput = audioDeviceInput;
    
    // 6.添加到会话中
    // 注意“最好要判断是否能添加输入，会话不能添加空的
    // 6.1 添加视频
    if ([captureSession canAddInput:videoDeviceInput]) {
        [captureSession addInput:videoDeviceInput];
    }
    // 6.2 添加音频
    if ([captureSession canAddInput:audioDeviceInput]) {
        [captureSession addInput:audioDeviceInput];
    }
    
    // 7.获取视频数据输出设备
    AVCaptureVideoDataOutput *videoOutput = [[AVCaptureVideoDataOutput alloc] init];
    _videoOutput = videoOutput;
    
    //  是否抛弃延迟的帧
    [videoOutput setAlwaysDiscardsLateVideoFrames: YES];
    
    // 7.1 设置代理，捕获视频样品数据
    // 注意：队列必须是串行队列，才能获取到数据，而且不能为空
    dispatch_queue_t videoQueue = dispatch_queue_create("Video Capture Queue", DISPATCH_QUEUE_SERIAL);
    [videoOutput setSampleBufferDelegate:self queue:videoQueue];
    if ([captureSession canAddOutput:videoOutput]) {
        [captureSession addOutput:videoOutput];
    }
    //  7.2设置采集格式
    videoOutput.videoSettings = [NSDictionary dictionaryWithObject: [NSNumber numberWithInt:kCVPixelFormatType_420YpCbCr8BiPlanarVideoRange] forKey:(id)kCVPixelBufferPixelFormatTypeKey];
    
    // 8.获取音频数据输出设备
    AVCaptureAudioDataOutput *audioOutput = [[AVCaptureAudioDataOutput alloc] init];
    // 8.2 设置代理，捕获视频样品数据
    // 注意：队列必须是串行队列，才能获取到数据，而且不能为空
    dispatch_queue_t audioQueue = dispatch_queue_create("Audio Capture Queue", DISPATCH_QUEUE_SERIAL);
    [audioOutput setSampleBufferDelegate:self queue:audioQueue];
    if ([captureSession canAddOutput:audioOutput]) {
        [captureSession addOutput:audioOutput];
    }
    
    // 9.获取视频输入与输出连接，用于分辨音视频数据
    _videoConnection = [videoOutput connectionWithMediaType:AVMediaTypeVideo];
    
    // 10. 设置方向
    [_videoConnection setVideoOrientation:AVCaptureVideoOrientationPortrait];
    
    // 11.添加视频预览图层
    AVCaptureVideoPreviewLayer *previedLayer = [AVCaptureVideoPreviewLayer layerWithSession:captureSession];
    previedLayer.frame = self.view.bounds;
    previedLayer.backgroundColor = [[UIColor blackColor] CGColor];
    [self.view.layer insertSublayer:previedLayer atIndex:0];
    _previedLayer = previedLayer;
    
    // 12.启动会话
    [captureSession startRunning];
}

// 指定摄像头方向获取摄像头
- (AVCaptureDevice *)getVideoDevice:(AVCaptureDevicePosition)position
{
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *device in devices) {
        if (device.position == position) {
            return device;
        }
    }
    return nil;
}

- (H264Encoder *)h264code{
    if (!_h264code) {
        _h264code = [[H264Encoder alloc]init];
    }
    return _h264code;
}

- (void)dealloc{
    
    [_captureSession stopRunning];
    NSLog(@"%s",__func__);
}

#pragma mark - AVCaptureVideoDataOutputSampleBufferDelegate
// 获取输入设备数据，有可能是音频有可能是视频
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection
{
    if (_videoConnection == connection) {
        // NSLog(@"采集到视频数据");
        
        // 进行视频编码
        [self.h264code encodeSampleBuffer:sampleBuffer H264DataBlock:^(NSData * data) {
            @autoreleasepool {
                // 粘包处理
                NSMutableData *sendData = [NSMutableData data];
                
                // 1.获取编码后数据长度
                NSInteger datalength = data.length;
                
                // 2.将数据长度 inter 转 NSData类型
                NSData *lengthData = [NSData dataWithBytes:&datalength length:sizeof(datalength)];
                
                // 3.lengthData默认为8字节,这里需服务端需和客户端协商,我这里使用4字节来存储 数据长度
                NSData *newLengthData = [lengthData subdataWithRange: NSMakeRange(0, 4)];
                
                // 4.将数据长度转NSData后,拼接到每一帧前面,方便拆包
                NSLog(@"newLengthData = %@", newLengthData);
                NSLog(@"data = %@", data);
                [sendData appendData:newLengthData];
                [sendData appendData:data];
                
                // 5.发送每一帧编码后数据
                [[TCPServer shareInstance] sendData:[sendData copy]];
                NSLog(@"sendData: %@", [sendData copy]);
            }
        }];
        
    } else {
        // NSLog(@"采集到音频数据");
    }
}

@end
