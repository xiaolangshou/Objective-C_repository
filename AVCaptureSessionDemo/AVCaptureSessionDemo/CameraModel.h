//
//  CameraModel.h
//  AVCaptureSessionDemo
//
//  Created by Thomas Lau on 2020/7/11.
//  Copyright © 2020 Liu Tao. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CameraModel : NSObject

@property (nonatomic, strong) UIView *previewView;

@property (nonatomic, copy  ) AVCaptureSessionPreset    preset;
@property (nonatomic, assign) int                       frameRate;
@property (nonatomic, assign) int                       resolutionHeight;
@property (nonatomic, assign) OSType                    videoFormat;

@property (nonatomic, assign) AVCaptureTorchMode        torchMode;
@property (nonatomic, assign) AVCaptureFocusMode        focusMode;
@property (nonatomic, assign) AVCaptureExposureMode     exposureMode;
@property (nonatomic, assign) AVCaptureFlashMode        flashMode;
@property (nonatomic, assign) AVCaptureWhiteBalanceMode whiteBalanceMode;

@property (nonatomic, assign) AVCaptureDevicePosition   position;
@property (nonatomic, copy  ) AVLayerVideoGravity       videoGravity;
@property (nonatomic, assign) AVCaptureVideoOrientation videoOrientation;

@property (nonatomic, assign) BOOL isEnableVideoStabilization;

- (instancetype)initWithPreviewView:(UIView *)previewView
                             preset:(AVCaptureSessionPreset)preset
                          frameRate:(int)frameRate
                   resolutionHeight:(int)resolutionHeight
                        videoFormat:(OSType)videoFormat
                          torchMode:(AVCaptureTorchMode)torchMode
                          focusMode:(AVCaptureFocusMode)focusMode
                       exposureMode:(AVCaptureExposureMode)exposureMode
                          flashMode:(AVCaptureFlashMode)flashMode
                   whiteBalanceMode:(AVCaptureWhiteBalanceMode)whiteBalanceMode
                           position:(AVCaptureDevicePosition)position
                       videoGravity:(AVLayerVideoGravity)videoGravity
                   videoOrientation:(AVCaptureVideoOrientation)videoOrientation
         isEnableVideoStabilization:(BOOL)isEnableVideoStabilization;

@end

NS_ASSUME_NONNULL_END
