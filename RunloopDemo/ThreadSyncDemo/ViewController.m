//
//  ViewController.m
//  ThreadSyncDemo
//
//  Created by Thomas Lau on 2020/8/14.
//  Copyright © 2020 TLLTD. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self RunloopTest1];
}

- (void)RunloopTest1 {
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"1");
        
        // 想runloop中添加了定时器，然而子线程默认不启动runloop，所以不执行
        [self performSelector:@selector(test) withObject:nil afterDelay:0];
        
        // 想要执行的话，加如下代码
        // [[NSRunLoop currentRunLoop] run];
        
        NSLog(@"3");
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(test) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    });
}

- (void)test {
    NSLog(@"2");
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    NSThread *thread = [[NSThread alloc] initWithBlock:^{
        NSLog(@"1");
    }];
    
    [thread start];
    
    BOOL isOk = false;
    
    [self performSelector:@selector(test) onThread:thread withObject:nil waitUntilDone:isOk];
}

@end
