//
//  CustomVideoCompositing.h
//  OpenGLDemo2
//
//  Created by Thomas Lau on 2020/4/3.
//  Copyright © 2020 TLLTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomVideoCompositing : NSObject<AVVideoCompositing>

@property (nonatomic, strong, nullable) NSDictionary<NSString *, id> *sourcePixelBufferAttributes;
@property (nonatomic, strong) NSDictionary<NSString *, id> *requiredPixelBufferAttributesForRenderContext;

@end

NS_ASSUME_NONNULL_END
