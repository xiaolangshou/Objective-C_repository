//
//  CustomFilter.h
//  OpenGLDemo2
//
//  Created by Thomas Lau on 2020/4/3.
//  Copyright © 2020 TLLTD. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomFilter : NSObject

@property (nonatomic, assign) CVPixelBufferRef pixelBuffer;

- (CVPixelBufferRef)outputPixelBuffer;

@end

NS_ASSUME_NONNULL_END
