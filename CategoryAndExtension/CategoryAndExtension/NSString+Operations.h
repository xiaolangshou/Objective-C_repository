//
//  NSString+Operations.h
//  CategoryAndExtension
//
//  Created by Thomas Lau on 2020/5/4.
//  Copyright © 2020 Liu Tao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Operations)

@property (strong, nonatomic) NSString *name;

- (NSString *)add:(NSString *)str;

@end

NS_ASSUME_NONNULL_END
