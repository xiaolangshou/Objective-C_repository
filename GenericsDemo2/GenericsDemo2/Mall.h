//
//  Mall.h
//  GenericsDemo2
//
//  Created by Thomas Lau on 2020/9/26.
//  Copyright © 2020 TLLTD. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Mall<T> : NSObject

- (void)buy:(T)product;
- (T)sell;

@end

NS_ASSUME_NONNULL_END
