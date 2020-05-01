//
//  ViewController.m
//  webviewdemo
//
//  Created by Liu Tao on 2020/4/29.
//  Copyright © 2020 Liu Tao. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) UIWebView *webView;
@property (strong, nonatomic) NSString *str;
@property (strong, nonatomic) NSTimer *timer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.str = @"http://bos.nj.bpc.baidu.com/tieba-smallvideo/11772_3c435014fb2dd9a5fd56a57cc369f6a0.mp4";
    self.webView = [[UIWebView alloc] initWithFrame: CGRectMake(0,
                                                               0,
                                                               UIScreen.mainScreen.bounds.size.width,
                                                               UIScreen.mainScreen.bounds.size.height)];
    [self.webView loadRequest: [NSURLRequest requestWithURL: [NSURL URLWithString: self.str]]];
    [self.view addSubview: self.webView];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                 repeats:YES
                                                   block:^(NSTimer * _Nonnull timer)
    {
        NSLog(@"%@", [self CVPixelBufferRef]);
    }];
    [self.timer fire];
    
}

- (CVPixelBufferRef)CVPixelBufferRef {
    
    CGSize size = self.view.frame.size;
    NSDictionary *options = @{(NSString*)kCVPixelBufferCGImageCompatibilityKey : @YES,
                              (NSString*)kCVPixelBufferCGBitmapContextCompatibilityKey : @YES,
                              (NSString*)kCVPixelBufferIOSurfacePropertiesKey: [NSDictionary dictionary]};
    CVPixelBufferRef pxbuffer = NULL;
    
    CGFloat frameWidth = size.width;
    CGFloat frameHeight = size.height;
    
    CVReturn status = CVPixelBufferCreate(kCFAllocatorDefault,
                                          frameWidth,
                                          frameHeight,
                                          kCVPixelFormatType_32ARGB,
                                          (__bridge CFDictionaryRef) options,
                                          &pxbuffer);
    
    NSParameterAssert(status == kCVReturnSuccess && pxbuffer != NULL);
    
    CVPixelBufferLockBaseAddress(pxbuffer, 0);
    void *pxdata = CVPixelBufferGetBaseAddress(pxbuffer);
    NSParameterAssert(pxdata != NULL);
    
    CGColorSpaceRef rgbColorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGContextRef context = CGBitmapContextCreate(pxdata,
                                                 size.width,
                                                 size.height,
                                                 8,
                                                 CVPixelBufferGetBytesPerRow(pxbuffer),
                                                 rgbColorSpace,
                                                 kCGImageAlphaPremultipliedFirst);
    NSParameterAssert(context);
    
    CGContextConcatCTM(context, CGAffineTransformMakeRotation(0));
    CGAffineTransform flipVertical = CGAffineTransformMake( 1, 0, 0, -1, 0, frameHeight);
    CGContextConcatCTM(context, flipVertical);
    
//    CGAffineTransform flipHorizontal = CGAffineTransformMake( -1.0, 0.0, 0.0, 1.0, frameWidth, 0.0 );
//    CGContextConcatCTM(context, flipHorizontal);

    [self.webView.layer renderInContext:context];
    
    CGColorSpaceRelease(rgbColorSpace);
    CGContextRelease(context);
    CVPixelBufferUnlockBaseAddress(pxbuffer, 0);
    
    return pxbuffer;
}

@end
