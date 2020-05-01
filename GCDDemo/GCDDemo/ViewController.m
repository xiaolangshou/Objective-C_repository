//
//  ViewController.m
//  GCDDemo
//
//  Created by Thomas Lau on 2020/4/3.
//  Copyright © 2020 TLLTD. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self dispatchGroupNotify];
}

- (void)dispatchGroupNotify {
    
    NSLog(@"currentThread: %@", [NSThread currentThread]);
    NSLog(@"---start---");
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_queue_create("QiShareQueue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_async(group, queue, ^{
        NSLog(@"groupTask_1");
        NSLog(@"currentThread: %@", [NSThread currentThread]);
    });
    dispatch_group_async(group, queue, ^{
        NSLog(@"groupTask_2");
        NSLog(@"currentThread: %@", [NSThread currentThread]);
    });
    dispatch_group_async(group, queue, ^{
        NSLog(@"groupTask_3");
        NSLog(@"currentThread: %@", [NSThread currentThread]);
    });
    
    dispatch_group_notify(group, queue, ^{
        NSLog(@"dispatch_group_Notify block end");
    });
    
    NSLog(@"---end---");
}

@end
