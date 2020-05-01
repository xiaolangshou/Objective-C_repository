//
//  CustomVideoCompositionInstruction.m
//  OpenGLDemo2
//
//  Created by Thomas Lau on 2020/4/3.
//  Copyright © 2020 TLLTD. All rights reserved.
//

#import "CustomFilter.h"
#import "CustomVideoCompositionInstruction.h"

@interface CustomVideoCompositionInstruction ()

@property (nonatomic, strong) CustomFilter *filter;

@end

@implementation CustomVideoCompositionInstruction

- (instancetype)initWithPassthroughTrackID:(CMPersistentTrackID)passthroughTrackID timeRange:(CMTimeRange)timeRange {
    self = [super init];
    if (self) {
        _passthroughTrackID = passthroughTrackID;
        _timeRange = timeRange;
        _requiredSourceTrackIDs = @[];
        _containsTweening = NO;
        _enablePostProcessing = NO;
        _filter = [[CustomFilter alloc] init];
    }
    return self;
}

- (instancetype)initWithSourceTrackIDs:(NSArray<NSValue *> *)sourceTrackIDs timeRange:(CMTimeRange)timeRange {
    self = [super init];
    if (self) {
        _requiredSourceTrackIDs = sourceTrackIDs;
        _timeRange = timeRange;
        _passthroughTrackID = kCMPersistentTrackID_Invalid;
        _containsTweening = YES;
        _enablePostProcessing = NO;
        _filter = [[CustomFilter alloc] init];
    }
    return self;
}

#pragma mark - Public

- (CVPixelBufferRef)applyPixelBuffer:(CVPixelBufferRef)pixelBuffer {
    self.filter.pixelBuffer = pixelBuffer;
    CVPixelBufferRef outputPixelBuffer = self.filter.outputPixelBuffer;
    CVPixelBufferRetain(outputPixelBuffer);
    return outputPixelBuffer;
}

@end
