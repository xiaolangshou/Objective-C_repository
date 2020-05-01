//
//  BitMap.m
//  JPEGToBMPDemo
//
//  Created by Thomas Lau on 2020/4/30.
//  Copyright © 2020 TLLTD. All rights reserved.
//

#import "BitMap.h"

@implementation BitMap

- (void)encodeWithCoder:(nonnull NSCoder *)coder {
    [coder encodeObject:self.img forKey:@"bitmap"];
}

- (nullable instancetype)initWithCoder:(nonnull NSCoder *)coder {
    self = [super init];
    
    if (self) {
        self.img = [coder decodeObjectForKey:@"bitmap"];
    }
    return self;
}

@end
