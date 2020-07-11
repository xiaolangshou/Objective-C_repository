//
//  ViewController.m
//  AVCaptureSessionDemo
//
//  Created by Liu Tao on 2020/5/6.
//  Copyright © 2020 Liu Tao. All rights reserved.
//

#import "ViewController.h"
#import "CameraModel.h"
#import "CameraHandler.h"
#import "AdjustFocusView.h"

#import <AVFoundation/AVFoundation.h>

@interface ViewController ()<CameraHandlerDelegate>

@property (nonatomic, strong) CameraHandler *cameraHandler;
@property (nonatomic, strong) AdjustFocusView *focusView;
@property (nonatomic, strong) UIButton *switchBtn;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self configureCamera];
    [self setupUI];
}

#pragma mark - init

- (void)configureCamera {
    
    CameraModel *model = [[CameraModel alloc] initWithPreviewView:self.view
                                                                 preset:AVCaptureSessionPreset1920x1080
                                                              frameRate: 30
                                                       resolutionHeight: 720
                                                            videoFormat:kCVPixelFormatType_420YpCbCr8BiPlanarFullRange
                                                              torchMode:AVCaptureTorchModeOff
                                                              focusMode:AVCaptureFocusModeLocked
                                                           exposureMode:AVCaptureExposureModeContinuousAutoExposure
                                                              flashMode:AVCaptureFlashModeAuto
                                                       whiteBalanceMode:AVCaptureWhiteBalanceModeContinuousAutoWhiteBalance
                                                               position:AVCaptureDevicePositionBack
                                                           videoGravity:AVLayerVideoGravityResizeAspect
                                                       videoOrientation:AVCaptureVideoOrientationLandscapeRight
                                             isEnableVideoStabilization:YES];
    
    CameraHandler *handler = [[CameraHandler alloc] init];
    self.cameraHandler = handler;
    handler.delegate = self;
    [handler configureCameraWithModel:model];
    [handler startRunning];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveResolutionChanged:)
                                                 name:kNotifyResolutionChanged
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveFrameRateChanged:)
                                                 name:kNotifyFrameRateChanged
                                               object:nil];
}

- (void)setupUI {
    
    // Gesture
    UITapGestureRecognizer *singleClickGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                                   action:@selector(handleSingleClickGesture:)];
    [self.view addGestureRecognizer:singleClickGestureRecognizer];
    
    // Orientation
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(deviceOrientationDidChange:)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil];
    
    _switchBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 200, 100, 50)];
    [_switchBtn setTitle:@"switch" forState:UIControlStateNormal];
    [self.view addSubview:_switchBtn];
    [_switchBtn addTarget:self action:@selector(switchCameraDidClicked) forControlEvents:UIControlEventTouchUpInside];
    
    // Focus View
    AdjustFocusView *focusView = [[AdjustFocusView alloc] initWithFrame: CGRectMake(0, 0, 80, 80)];
    self.focusView = focusView;
    focusView.hidden = YES;
    [self.view addSubview:focusView];
    
    // WindowImageView
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(30, 60, 150, 100)];
    [self.view addSubview:_imageView];
}

#pragma mark - Button Action
- (void)switchCameraDidClicked {
    [self.cameraHandler switchCamera];
}

#pragma mark - Gesture
- (void)handleSingleClickGesture:(UITapGestureRecognizer *)recognizer  {
    CGPoint tapPoint = [recognizer locationInView:recognizer.view];

    [self.focusView setFrameByAnimateWithCenter:tapPoint];
    [self.cameraHandler setFocusPoint:tapPoint];
}

#pragma mark - Notification
- (void)receiveResolutionChanged:(NSNotification *)notification {
    NSDictionary *dic = notification.userInfo;
    int newHeight = [[dic objectForKey:kResolutionHeightChangedKey] intValue];
    [self.cameraHandler setCameraResolutionByActiveFormatWithHeight:newHeight];
}

- (void)receiveFrameRateChanged:(NSNotification *)notification {
    NSDictionary *dic = notification.userInfo;
    int newFrameRate = [[dic objectForKey:kFrameRateChangedKey] intValue];
    [self.cameraHandler setCameraForHFRWithFrameRate:newFrameRate];
}

#pragma mark - Delegate
- (void)CaptureOutput:(nonnull AVCaptureOutput *)output
     didDropSampleBuffer:(nonnull CMSampleBufferRef)sampleBuffer
          fromConnection:(nonnull AVCaptureConnection *)connection
{
    NSLog(@"DropSampleBuffer = %@", sampleBuffer);
}

- (void)CaptureOutput:(nonnull AVCaptureOutput *)output
   didOutputSampleBuffer:(nonnull CMSampleBufferRef)sampleBuffer
          fromConnection:(nonnull AVCaptureConnection *)connection
{
    NSLog(@"OutputSampleBuffer = %@", sampleBuffer);
    
    dispatch_sync(dispatch_get_main_queue(), ^{
        UIImage *image = [self imageFromBuffer:sampleBuffer];
        _imageView.image = image;
    });
}

- (UIImage *)imageFromBuffer:(CMSampleBufferRef)buffer {
    
    CVPixelBufferRef pixelBuffer = (CVPixelBufferRef)CMSampleBufferGetImageBuffer(buffer);
    
    CIImage *ciImage = [CIImage imageWithCVPixelBuffer:pixelBuffer];
    
    CIContext *temporaryContext = [CIContext contextWithOptions:nil];
    CGImageRef videoImage = [temporaryContext createCGImage:ciImage fromRect:CGRectMake(0, 0, CVPixelBufferGetWidth(pixelBuffer), CVPixelBufferGetHeight(pixelBuffer))];
    
    UIImage *image = [UIImage imageWithCGImage:videoImage];
    CGImageRelease(videoImage);
    
    return image;
}

#pragma mark - Notification
- (void)deviceOrientationDidChange:(NSNotification *)notification {
    // Obtaining the current device orientation
    UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
    
    NSLog(@"Curent UIInterfaceOrientation is %ld",(long)orientation);
    
    if(orientation == UIDeviceOrientationLandscapeLeft || orientation == UIDeviceOrientationLandscapeRight) {
        NSLog(@"Device Left");
        [self.cameraHandler adjustVideoOrientationByScreenOrientation:orientation];
    } else {
        NSLog(@"App not support");
    }
}

@end
