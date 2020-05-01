//
//  Person.h
//  KeyArchiveDemo
//
//  Created by Thomas Lau on 2020/4/30.
//  Copyright © 2020 TLLTD. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject<NSCoding>

@property (nonatomic, strong) NSString *name;

@end

NS_ASSUME_NONNULL_END
