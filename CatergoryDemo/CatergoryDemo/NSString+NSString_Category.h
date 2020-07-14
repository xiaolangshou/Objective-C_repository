//
//  NSString+NSString_Category.h
//  CatergoryDemo
//
//  Created by Thomas Lau on 2020/7/14.
//  Copyright © 2020 TLLTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (NSString_Category)

@property (nonatomic, assign) NSString *name;

- (void)Func;

@end

NS_ASSUME_NONNULL_END
