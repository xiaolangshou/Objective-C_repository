//
//  Person.h
//  MemoryMangDemo
//
//  Created by Liu Tao on 2020/2/21.
//  Copyright © 2020 Liu Tao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject

@property (nonatomic, copy) NSString *copName;
@property (nonatomic, copy) NSMutableString *mutableCopName;
@property (nonatomic, strong) NSString *strongName;

@end

NS_ASSUME_NONNULL_END
