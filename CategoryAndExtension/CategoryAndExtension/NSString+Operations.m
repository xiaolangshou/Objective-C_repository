//
//  NSString+Operations.m
//  CategoryAndExtension
//
//  Created by Thomas Lau on 2020/5/4.
//  Copyright © 2020 Liu Tao. All rights reserved.
//

#import "NSString+Operations.h"

static char *CloudoxKey = "CloudoxKey";

@implementation NSString (Operations)

- (NSString *)name {
    return objc_getAssociatedObject(self, CloudoxKey);
}

- (void)setName: (NSString *)str {
    objc_setAssociatedObject(self, CloudoxKey, str, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)add:(NSString *)str {
    return [self stringByAppendingString:str];
}

@end
