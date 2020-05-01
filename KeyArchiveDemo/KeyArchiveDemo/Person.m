//
//  Person.m
//  KeyArchiveDemo
//
//  Created by Thomas Lau on 2020/4/30.
//  Copyright © 2020 TLLTD. All rights reserved.
//

#import "Person.h"

@implementation Person

- (void)encodeWithCoder:(nonnull NSCoder *)coder {
    // 告诉系统归档的属性是哪些
    [coder encodeObject:self.name forKey:@"name"];
}

- (nullable instancetype)initWithCoder:(nonnull NSCoder *)coder {
    self = [super init];
    
    if (self) {
        self.name = [coder decodeObjectForKey:@"name"];
    }
    return self;
}

@end
