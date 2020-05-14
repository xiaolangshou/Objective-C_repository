//
//  TLCameraTool.h
//  AVCaptureCamera
//
//  Created by TL on 2018/11/7.
//  Copyright © 2018年 TL. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TLCameraToolDelegate <NSObject>
//开始拍摄
- (void)startCamera;
//闪光灯设置
- (void)lightFlash;
//镜头设置
- (void)switchCameraPosition;
//重新拍摄
- (void)reshoot;
//完成
- (void)completionShootWithPhoto:(UIImage *)photo;

@end

@interface TLCameraTool : UIView

/* delegate */
@property (nonatomic, weak) id <TLCameraToolDelegate> delegate;
/* image */
@property (nonatomic, strong) UIImage *image;

@end
