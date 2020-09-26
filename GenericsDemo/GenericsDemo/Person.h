//
//  TLCollection.h
//  GenericsDemo
//
//  Created by Thomas Lau on 2020/9/26.
//  Copyright © 2020 TLLTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject

@property (strong, nonatomic) NSString *name;
@property (assign, nonatomic) NSNumber *age;
@property (strong, nonatomic) NSArray *jobs;

@end

NS_ASSUME_NONNULL_END
