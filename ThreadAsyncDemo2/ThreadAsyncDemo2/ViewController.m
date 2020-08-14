//
//  ViewController.m
//  ThreadAsyncDemo2
//
//  Created by Liu Tao on 2020/8/14.
//  Copyright © 2020 Liu Tao. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self semaphoreSync];
}

- (void)semaphoreSync {
    
    NSLog(@"thread: %@", [NSThread currentThread]);
    NSLog(@"semaphore begin");
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    dispatch_queue_t queue = dispatch_queue_create("queue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:1.0];
            NSLog(@"%@:%d",[NSThread currentThread],i);
        }
        
        dispatch_semaphore_signal(semaphore);
    });
    
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    
    NSLog(@"semaphore end");
}


@end
