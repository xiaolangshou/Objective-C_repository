//
//  DisplayViewController.m
//  RemoteCamDemo_Recieve
//
//  Created by Thomas Lau on 2020/4/18.
//  Copyright © 2020 TLLTD. All rights reserved.
//

#import "DisplayViewController.h"
#import "VideoDisplayLayer.h"
#import "TCPClient.h"
#import "H264Decoder.h"

@interface DisplayViewController ()<H264DecoderDelegate, TCPClientDelegate>

//  播放器 layer
@property (nonatomic, strong) VideoDisplayLayer *playLayer;
//  解码器
@property (nonatomic, strong) H264Decoder *h264Decoder;
//  视频流缓冲区
@property (nonatomic, strong) NSMutableData *bufferData;


@end

@implementation DisplayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化解码器
    self.h264Decoder = [[H264Decoder alloc] init];
    self.h264Decoder.delegate = self;
    self.bufferData = [NSMutableData data];
    
    // 设置播放器 layer
    [self setupDisplayLayer];
    
    // socket 连接,IP 地址为采集端的IP,端口号可自定义
    [TCPClient sharedSocketClient].delegate = self;
    [[TCPClient sharedSocketClient] connectServerWithHost:@"192.168.2.196" andPort: 8889];
}

// 设置播放器
- (void)setupDisplayLayer {
    
    self.playLayer = [[VideoDisplayLayer alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.playLayer.backgroundColor = self.view.backgroundColor.CGColor;
    [self.view.layer addSublayer:self.playLayer];
}

#pragma -mark TCPSocketClientDelegate

- (void)socket: (TCPClient *)socket didReadData: (NSData *)data {
    @synchronized (self) { // 互斥锁
        
        [self.bufferData appendData: data];
        while (self.bufferData.length > 4) {
            
            NSInteger h264Datalength = 0;
            [[self.bufferData subdataWithRange: NSMakeRange(0, 4)] getBytes: &h264Datalength length: sizeof(h264Datalength)];
            
            // 缓存区的长度大于总长度，证明有完整的数据包在缓存区，然后进行处理
            if (self.bufferData.length >= (h264Datalength+4)) {
                NSData *h264Data = [[self.bufferData subdataWithRange: NSMakeRange(4, h264Datalength)] copy];
                
                [self.h264Decoder decodeNalu:(uint8_t *)[h264Data bytes] size:(uint32_t)h264Data.length];
                
                // 处理完数据后将处理过的数据移出缓存区
                self.bufferData = [NSMutableData dataWithData:[self.bufferData subdataWithRange:NSMakeRange(h264Datalength+4, self.bufferData.length - (h264Datalength+4))]];
            } else {
                break;
            }
        }
    }
}

// 解码完成回调
- (void)decoder:(H264Decoder *) decoder didDecodingFrame: (CVImageBufferRef) imageBuffer {
    
    if (!imageBuffer) {
        return;
    }
    // 回主线程给 layer 进行展示
//    dispatch_async(dispatch_get_main_queue(), ^{
        self.playLayer.pixelBuffer = imageBuffer;
        CVPixelBufferRelease(imageBuffer);
//    });
}

// 数据缓存
- (NSMutableData *)bufferData{
    if (!_bufferData) {
        _bufferData = [NSMutableData  data];
    }
    return _bufferData;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    NSData *data = [@"test" dataUsingEncoding: NSUTF8StringEncoding];
    
    [[TCPClient sharedSocketClient] sendData:data];
}

@end
