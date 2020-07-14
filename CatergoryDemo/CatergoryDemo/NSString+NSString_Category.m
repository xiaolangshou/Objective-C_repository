//
//  NSString+NSString_Category.m
//  CatergoryDemo
//
//  Created by Thomas Lau on 2020/7/14.
//  Copyright © 2020 TLLTD. All rights reserved.
//

#import "NSString+NSString_Category.h"

static char *Key = @"keys";

@implementation NSString (NSString_Category)

- (NSString *)name {
    return objc_getAssociatedObject(self, Key);
}

- (void)setName:(NSString *)str {
    objc_setAssociatedObject(self, Key, str, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)Func {
    NSLog(@"Function...");
}

@end
