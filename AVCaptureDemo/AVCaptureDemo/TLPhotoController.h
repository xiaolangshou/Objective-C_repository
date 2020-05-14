//
//  TLPhotoController.h
//  AVCaptureCamera
//
//  Created by TL on 2018/11/7.
//  Copyright © 2018年 TL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TLPhotoController : UIViewController

/* photo */
@property (nonatomic, strong) UIImage *photo;
/* 设备方向 */
@property (nonatomic, assign) UIDeviceOrientation orientation;

@end
