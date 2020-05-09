//
//  TLPhotoController.m
//  AVCaptureCamera
//
//  Created by TL on 2018/11/7.
//  Copyright © 2018年 TL. All rights reserved.
//

#import "TLPhotoController.h"

@interface TLPhotoController ()

/* imageView */
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation TLPhotoController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    _imageView = [[UIImageView alloc] init];
    _imageView.frame = self.view.bounds;
    _imageView.contentMode = UIViewContentModeScaleAspectFit;  //避免图片被拉伸
    [self.view addSubview:_imageView];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(20, 20, 40, 40);
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [backBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    //根据拍摄时的屏幕方向，调整图片方向
    switch (self.orientation) {
        case UIDeviceOrientationLandscapeLeft:
            [self resetImageWithOrientation: UIImageOrientationUp];
            break;
        case UIDeviceOrientationLandscapeRight:
            [self resetImageWithOrientation: UIImageOrientationDown];
            break;
        case UIDeviceOrientationPortraitUpsideDown:
            [self resetImageWithOrientation: UIImageOrientationLeft];
            break;
        default:
            self.imageView.image = self.photo;
            break;
    }
}

//重置图片方向
- (void)resetImageWithOrientation:(UIImageOrientation)imageOrientation {
    
    //横屏拍摄的时候，旋转图片
    UIImage *image = [UIImage imageWithCGImage:self.photo.CGImage scale:1.0 orientation:imageOrientation];
    _imageView.image = image;
    
    //将横屏拍摄的图片旋转至竖屏，并调整imageview的尺寸
    CGFloat width = self.view.frame.size.width;
    
    CGFloat height = image.size.height * width / image.size.width;
    CGRect frame = _imageView.frame;
    frame.size.height = height;
    _imageView.frame = frame;
    _imageView.center = self.view.center;
}

- (void)backAction {
    [self.navigationController popViewControllerAnimated:YES];
}


@end
