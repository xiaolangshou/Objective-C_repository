//
//  H264Decoder.h
//  RemoteCamDemo_Recieve
//
//  Created by Thomas Lau on 2020/4/18.
//  Copyright © 2020 TLLTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <VideoToolbox/VideoToolbox.h>

NS_ASSUME_NONNULL_BEGIN

@class H264Decoder;

@protocol H264DecoderDelegate <NSObject>

@optional

- (void)decoder:(H264Decoder *) decoder didDecodingFrame:(CVImageBufferRef) imageBuffer;

@end

@interface H264Decoder : NSObject

@property (nonatomic, weak) id<H264DecoderDelegate> delegate;

//  解码NALU
- (void)decodeNalu:(uint8_t *)frame size:(uint32_t)frameSize;

@end

NS_ASSUME_NONNULL_END
