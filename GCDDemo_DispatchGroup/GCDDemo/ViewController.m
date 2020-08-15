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
    
    /* GCD 的队列组：dispatch_group 使用场景 */
//    [self dispatchGroupNotify1];
    [self dispatchGroupNotify2];
}

- (void)dispatchGroupNotify1 {
    
    NSLog(@"currentThread: %@", [NSThread currentThread]);
    NSLog(@"---start---");
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_queue_create("QiShareQueue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_async(group, queue, ^{
        for (int i = 0; i<2; i++) {
            [NSThread sleepForTimeInterval:1];
            NSLog(@"%@ %d", [NSThread currentThread], i);
        }
    });
    dispatch_group_async(group, queue, ^{
        for (int i = 0; i<2; i++) {
            [NSThread sleepForTimeInterval:1];
            NSLog(@"%@ %d", [NSThread currentThread], i);
        }
    });
    dispatch_group_async(group, queue, ^{
        for (int i = 0; i<2; i++) {
            [NSThread sleepForTimeInterval:1];
            NSLog(@"%@ %d", [NSThread currentThread], i);
        }
    });
    
    dispatch_group_notify(group, queue, ^{
        NSLog(@"dispatch_group_Notify block end");
    });
    
    NSLog(@"---end---");
}

// enter \ leave 分组管理异步任务
- (void)dispatchGroupNotify2 {
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_queue_create("Queue", DISPATCH_QUEUE_CONCURRENT);
    
    // block one
    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:1];
            NSLog(@"%@ %d",[NSThread currentThread],i);
        }
        
        dispatch_group_leave(group);
    });
    
    // block two
    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:1];
            NSLog(@"%@ %d",[NSThread currentThread],i);
        }
        
        dispatch_group_leave(group);
    });

    // main queue
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:1];
            NSLog(@"%@ %d",[NSThread currentThread],i);
        }
    });
}

@end
