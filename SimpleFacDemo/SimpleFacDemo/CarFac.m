//
//  CarFac.m
//  SimpleFacDemo
//
//  Created by Liu Tao on 2020/3/6.
//  Copyright © 2020 Liu Tao. All rights reserved.
//

#import "CarFac.h"

@implementation CarFac

+ (NSString *)createCar:(NSInteger)type {
    
    switch (type) {
        case 0:
            return @"Ford Car";
            break;
        case 1:
            return @"Honda Car";
            break;
        case 2:
            return @"BMW Car";
            break;
        default:
            return @"";
            break;
    }
}

@end
