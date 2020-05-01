//
//  NSString+NSString_Category.m
//  CategoryAndExtension
//
//  Created by Liu Tao on 2020/3/8.
//  Copyright © 2020 Liu Tao. All rights reserved.
//

#import "NSString+NSString_Category.h"

static NSString *title = @"title";

@implementation NSString (NSString_Category)

- (NSString *)name {
    return objc_getAssociatedObject(self, &title);
}

- (void)setName:(NSString *)name {
    objc_setAssociatedObject(self, &title, name, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)add:(NSString *)str1 {
    return [self stringByAppendingString:str1];
}

@end
