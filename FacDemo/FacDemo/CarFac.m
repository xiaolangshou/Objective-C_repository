//
//  CarFac.m
//  FacDemo
//
//  Created by Liu Tao on 2020/3/6.
//  Copyright © 2020 Liu Tao. All rights reserved.
//

#import "CarFac.h"
#import "CarFacType.m"
#import "FordFac.h"
#import "HondaFac.h"
#import "BMWFac.h"

@implementation CarFac

+ (NSString *)createCar: (CarFacType) type {
    switch (type) {
        case ford:
            return [FordFac creatFordCar];
            break;
        case honda:
            return [HondaFac createHondaCar];
            break;
        case BMW:
            return [BMWFac createBMWCar];
            break;
        default:
            return [FordFac creatFordCar];
            break;
    }
}

@end
