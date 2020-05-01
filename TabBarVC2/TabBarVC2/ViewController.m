//
//  ViewController.m
//  TabBarVC2
//
//  Created by Liu Tao on 2020/2/19.
//  Copyright © 2020 Liu Tao. All rights reserved.
//

#import "ViewController1.h"

@interface ViewController1 ()


@end

@implementation ViewController1

+ (id)sharedInstance {
    static ViewController1 *sharedInstance = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


@end
