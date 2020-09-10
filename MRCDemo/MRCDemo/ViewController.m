//
//  ViewController.m
//  MRCDemo
//
//  Created by Thomas Lau on 2020/9/2.
//  Copyright © 2020 TLLTD. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

#pragma mrc

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableArray *array = [NSMutableArray array];
    NSLog(@"array的对象地址1：%p, retainCount:%zd", array, [array retainCount]);
    [array retain];
    NSLog(@"array的对象地址2：%p, retainCount:%zd", array, [array retainCount]);
    [array release];
    NSLog(@"array的对象地址3：%p, retainCount:%zd", array, [array retainCount]);
    [array addObject:@"1234"];
    NSLog(@"array的对象地址4：%p, retainCount:%zd", array, [array retainCount]);
}


@end
