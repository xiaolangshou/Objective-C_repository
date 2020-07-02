//
//  UIImage+Extension.m
//  AudioDemo
//
//  Created by Liu Tao on 2020/7/2.
//  Copyright © 2020 TLLTD. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage_Extension

- (UIImage *)setImageColor: (UIColor *)imageColor {
    //获取画布
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
    //画笔沾取颜色
    [imageColor setFill];
    CGRect bounds = CGRectMake(0, 0, self.size.width, self.size.height);
    //绘制一次
    UIRectFill(bounds);
    //再绘制一次
    [self drawInRect:bounds blendMode:kCGBlendModeOverlay alpha:1.0f];
    //获取图片
    [self drawInRect:bounds blendMode:kCGBlendModeDestinationIn alpha:1.0f];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
