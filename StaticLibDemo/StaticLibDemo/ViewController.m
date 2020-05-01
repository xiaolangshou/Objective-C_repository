//
//  ViewController.m
//  StaticLibDemo
//
//  Created by Thomas Lau on 2020/3/6.
//  Copyright © 2020 TLLTD. All rights reserved.
//

#import "ViewController.h"
#import "StaticLib.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"sum = %f", [StaticLib sum:10 with:1]);
}


@end
