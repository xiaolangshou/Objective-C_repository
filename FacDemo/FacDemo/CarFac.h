//
//  CarFac.h
//  FacDemo
//
//  Created by Liu Tao on 2020/3/6.
//  Copyright © 2020 Liu Tao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CarFacType.m"

NS_ASSUME_NONNULL_BEGIN

@interface CarFac : NSObject

+ (NSString *)createCar: (CarFacType) type;

@end

NS_ASSUME_NONNULL_END
