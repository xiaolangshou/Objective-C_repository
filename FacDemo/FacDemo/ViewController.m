//
//  ViewController.m
//  FacDemo
//
//  Created by Liu Tao on 2020/3/6.
//  Copyright © 2020 Liu Tao. All rights reserved.
//

#import "ViewController.h"
#import "CarFac.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"%@", [CarFac createCar:BMW]);
}


@end
