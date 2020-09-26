//
//  MBCollection.h
//  GenericsDemo2
//
//  Created by Thomas Lau on 2020/9/26.
//  Copyright © 2020 TLLTD. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MBCollection<__covariant T>: NSObject

// __kind of 表示其中的类型为该类型或其子类
@property (nonatomic, retain) NSMutableArray <__kindof T> *elements;

- (void)addObject: (T)object;
- (BOOL)insertOBject: (T)object atIndex: (NSInteger) index;

@end

NS_ASSUME_NONNULL_END
