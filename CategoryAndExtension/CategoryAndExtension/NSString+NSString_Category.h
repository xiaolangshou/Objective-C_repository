//
//  NSString+NSString_Category.h
//  CategoryAndExtension
//
//  Created by Liu Tao on 2020/3/8.
//  Copyright © 2020 Liu Tao. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <objc/runtime.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (NSString_Category)

@property (strong, nonatomic) NSString *name;

- (NSString *)add:(NSString *)str;

@end

NS_ASSUME_NONNULL_END
