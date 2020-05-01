//
//  VideoDisplayLayer.h
//  RemoteCamDemo_Recieve
//
//  Created by Thomas Lau on 2020/4/18.
//  Copyright © 2020 TLLTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreVideo/CoreVideo.h>

NS_ASSUME_NONNULL_BEGIN

@interface VideoDisplayLayer : CAEAGLLayer

@property CVPixelBufferRef pixelBuffer;

- (id)initWithFrame:(CGRect)frame;
- (void)resetRenderBuffer;

@end

NS_ASSUME_NONNULL_END
