//
//  BitMap.h
//  JPEGToBMPDemo
//
//  Created by Thomas Lau on 2020/4/30.
//  Copyright © 2020 TLLTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BitMap : NSObject<NSCoding>

@property (strong, nonatomic) UIImage *img;

@end

NS_ASSUME_NONNULL_END
