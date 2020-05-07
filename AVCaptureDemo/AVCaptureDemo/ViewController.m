//
//  ViewController.m
//  AVCaptureDemo
//
//  Created by Thomas Lau on 2020/5/7.
//  Copyright © 2020 TLLTD. All rights reserved.
//

#import "ViewController.h"
#import "ZSWCameraTool.h"
#import "ZSWMotionManager.h"
#import "ZSWPhotoController.h"
#import <CoreMotion/CoreMotion.h>
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()<AVCapturePhotoCaptureDelegate, ZSWCameraToolDelegate>

/* 捕获设备，通常是前置摄像头、后置摄像头、麦克风 */
@property (nonatomic, strong) AVCaptureDevice *device;
/* 输入设备，使用AVCaptureDevice来初始化 */
@property (nonatomic, strong) AVCaptureDeviceInput *input;
/* 输出图片 */
@property (nonatomic, strong) AVCapturePhotoOutput *photoOutput;
/* 可以把输入输出结合在一起，并开始启动捕获设备(摄像头) */
@property (nonatomic, strong) AVCaptureSession *session;
/* 图像预览层，实时显示捕获的图像 */
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;
/* 闪光灯 */
@property (nonatomic, assign) AVCaptureFlashMode mode;
/* 前后置摄像头 */
@property (nonatomic, assign) AVCaptureDevicePosition position;
/* cameraTool */
@property (nonatomic, strong) ZSWCameraTool *cameraTool;
/* 最小缩放值 */
@property (nonatomic, assign) CGFloat minZoomFactor;
/* 最大缩放值 */
@property (nonatomic, assign) CGFloat maxZoomFactor;
/* 聚焦框 */
@property (nonatomic, strong) UIView *focusView;
/* 获取屏幕方向 */
@property (nonatomic, assign) UIDeviceOrientation orientation;
/* 陀螺仪管理 */
@property (nonatomic, strong) ZSWMotionManager *motionManager;

@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (self.session && !self.session.running) {
        [self.session startRunning];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupCamera];
}

#pragma mark - 初始化相机属性
- (void)setupCamera {
    
    // 连接输入与会话
    if([self.session canAddInput:self.input]) {
        [self.session addInput:self.input];
    }

    // 连接输出与会话
    if([self.session canAddOutput:self.photoOutput]) {
        [self.session addOutput:self.photoOutput];
    }
    
    //预览画面
    self.previewLayer.frame = self.view.bounds;
    [self.view.layer insertSublayer: self.previewLayer atIndex:0];
    
    // 对焦框
    [self.view addSubview: self.focusView];
    
    // 开始取景
    [self.session startRunning];
    
    NSError *error = nil;
    if([self.device lockForConfiguration:&error]) {
        //自动白平衡：使用AVCaptureWhiteBalanceModeContinuousAutoWhiteBalance自动持续白平衡
        if([self.device isWhiteBalanceModeSupported: AVCaptureWhiteBalanceModeContinuousAutoWhiteBalance]) {
            [self.device setWhiteBalanceMode: AVCaptureWhiteBalanceModeContinuousAutoWhiteBalance];
        }
        [self.device unlockForConfiguration];
    } else {
        NSLog(@"%@",error);
    }
}

#pragma mark - AVCapturePhotoCaptureDelegate 拍摄后的代理方法，得到拍摄的图片
- (void)captureOutput:(AVCapturePhotoOutput *)output
didFinishProcessingPhoto:(AVCapturePhoto *)photo
                error:(NSError *)error  API_AVAILABLE(ios(11.0))
{
    //停止取景
    [self.session stopRunning];

    NSData *imageData = nil;
    if (@available(iOS 11.0, *)) {
        imageData = [photo fileDataRepresentation];
    } else {
        // Fallback on earlier versions
        NSLog(@"Fallback on earlier versions");
    }
    UIImage *image = [UIImage imageWithData:imageData];
    self.cameraTool.image = image;
    
    // 开启陀螺仪监测设备方向，motionManager必须设置为全局强引用属性，否则无法开启陀螺仪监测；
    [self.motionManager startMotionManager:^(NSInteger orientation) {
        self.orientation = orientation;
        NSLog(@"设备方向：%ld",orientation);
    }];
}

#pragma mark - ZSWCameraToolDelegate
- (void)startCamera {
    NSLog(@"拍摄");

    AVCapturePhotoSettings *photoSetting = nil; //必须设置成局部变量，否则每次拍摄使用全局变量会奔溃
    photoSetting = [AVCapturePhotoSettings photoSettingsWithFormat:@{AVVideoCodecKey:AVVideoCodecTypeJPEG}];
    
    //设置闪光灯开关
    [photoSetting setFlashMode:self.mode];
    
    [self.photoOutput capturePhotoWithSettings:photoSetting delegate:self];
}

- (void)lightFlash {
    NSLog(@"闪光灯设置");
    if(self.mode == AVCaptureFlashModeOn) {
        self.mode = AVCaptureFlashModeOff;
    } else {
        self.mode = AVCaptureFlashModeOn;
    }
}

- (void)switchCameraPosition {
    NSLog(@"镜头设置");
    
    if(self.position == AVCaptureDevicePositionFront) {
        self.position = AVCaptureDevicePositionBack;
    } else {
        self.position = AVCaptureDevicePositionFront;
    }
    
    [self transformCameraAnimationWithPosition:self.position];

    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithDeviceType:AVCaptureDeviceTypeBuiltInWideAngleCamera mediaType:AVMediaTypeVideo position:self.position];
    if(device) {
        self.device = device;
    }
    
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    [self.session beginConfiguration];
    [self.session removeInput: self.input];
    if([self.session canAddInput:input]) {
        [self.session addInput: input];
        self.input = input;
        [self.session commitConfiguration];
    }
    
}

- (void)reshoot {
    NSLog(@"重拍");
    [self.session startRunning];
}

- (void)completionShootWithPhoto:(UIImage *)photo {
    NSLog(@"完成");
    //保存到手机本地相册
    UIImageWriteToSavedPhotosAlbum(photo, nil, nil, nil);
    
    ZSWPhotoController *vc = [ZSWPhotoController new];
    vc.photo = photo;
    vc.orientation = self.orientation;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - method
//设置动画翻转效果
- (void)transformCameraAnimationWithPosition:(AVCaptureDevicePosition)position {
    
    CATransition *animation = [CATransition animation];
    animation.duration = .5f;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.type = @"oglFlip";
    
    if(position == AVCaptureDevicePositionFront) {
        animation.subtype = kCATransitionFromLeft;  //翻转方向
    } else {
        animation.subtype = kCATransitionFromRight;  //翻转方向
    }
    
    [self.previewLayer addAnimation:animation forKey:nil];
}

#pragma mark - lazy
- (AVCaptureDevice *)device {
    if(!_device) {
        _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    }
    return _device;
}

- (AVCaptureDeviceInput *)input {
    if(!_input) {
        _input = [[AVCaptureDeviceInput alloc] initWithDevice:self.device error:nil];
    }
    return _input;
}

- (AVCapturePhotoOutput *)photoOutput {
    if(!_photoOutput) {
        _photoOutput = [[AVCapturePhotoOutput alloc] init];
    }
    return _photoOutput;
}

- (AVCaptureSession *)session {
    if(!_session) {
        _session = [[AVCaptureSession alloc] init];
        _session.sessionPreset = AVCaptureSessionPresetPhoto; //画质
    }
    return _session;
}

- (AVCaptureVideoPreviewLayer *)previewLayer {
    if(!_previewLayer) {
        _previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    }
    return _previewLayer;
}

- (ZSWCameraTool *)cameraTool {
    if(!_cameraTool) {
        _cameraTool = [[ZSWCameraTool alloc] initWithFrame:self.view.bounds];
        _cameraTool.delegate = self;
    }
    return _cameraTool;
}


- (UIView *)focusView {
    if(!_focusView) {
        _focusView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
        _focusView.backgroundColor = [UIColor redColor];
        _focusView.hidden = YES;
    }
    return _focusView;
}

- (ZSWMotionManager *)motionManager {
    if(!_motionManager) {
        _motionManager = [[ZSWMotionManager alloc] init];
    }
    return _motionManager;
}

@end
