//
//  ViewController.m
//  NSOperationDemo
//
//  Created by Thomas Lau on 2020/8/15.
//  Copyright © 2020 TLLTD. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

/* NSOperation/NSOperationQueue的优点：
 1.可设置最大并发数
 2.可设置依赖关系，控制任务执行顺序
 3.可设置操作执行的优先级
 4.可以方便取消一个执行中的操作
 5.可以通过kvo的方式观察操作执行状态 */

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self blockOperation];
//    [self operationQueue];
//    [self operationQueue2];
//    [self threadCom];
    [self queuePriority];
}

// 不能直接使用NSOperation,因为是一个抽象类,所以使用BlockOperation
- (void)blockOperation {
    
    // 创建NSBlockOperation对象,默认主线程执行
    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:1];
            NSLog(@"1--%@", [NSThread currentThread]);
        }
    }];
    
    // 子线程执行
    [op addExecutionBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:1];
            NSLog(@"2--%@", [NSThread currentThread]);
        }
    }];

    [op addExecutionBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:1];
            NSLog(@"3--%@", [NSThread currentThread]);
        }
    }];

    [op start];
}

// NSOperationQueue 设置依赖关系后可以控制操作顺序执行
- (void)operationQueue {
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:1];
            NSLog(@"4--%@", [NSThread currentThread]);
        }
    }];
    
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:1];
            NSLog(@"5--%@", [NSThread currentThread]);
        }
    }];
    
    NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:1];
            NSLog(@"6--%@", [NSThread currentThread]);
        }
    }];
    
    NSBlockOperation *op4 = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:1];
            NSLog(@"7--%@", [NSThread currentThread]);
        }
    }];
    
    [op2 addDependency:op1];
    [op3 addDependency:op2];
    [op4 addDependency:op3];
    
    [queue addOperation:op1];
    [queue addOperation:op2];
    [queue addOperation:op3];
    [queue addOperation:op4];
}

// 设置最大并发数
- (void)operationQueue2 {
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    queue.maxConcurrentOperationCount = 2;
    
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 4; i++) {
            [NSThread sleepForTimeInterval:1.0];
            NSLog(@"7--%@", [NSThread currentThread]);
        }
    }];
    
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 4; i++) {
            [NSThread sleepForTimeInterval:1.0];
            NSLog(@"8--%@", [NSThread currentThread]);
        }
    }];
    
    NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 4; i++) {
            [NSThread sleepForTimeInterval:1.0];
            NSLog(@"9--%@", [NSThread currentThread]);
        }
    }];
    
    [queue addOperation:op1];
    [queue addOperation:op2];
    [queue addOperation:op3];
}

// 线程间通信
- (void)threadCom {
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"1 sub");
        }
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            for (int i = 0; i < 2; i++) {
                [NSThread sleepForTimeInterval:2];
                NSLog(@"1 main");
            }
        }];
    }];
    
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"2 sub");
        }
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            for (int i = 0; i < 2; i++) {
                [NSThread sleepForTimeInterval:2];
                NSLog(@"2 main");
            }
        }];
    }];
    
    [op2 addDependency:op1];
    
    [queue addOperation:op1];
    [queue addOperation:op2];
}

- (void)queuePriority {
    NSBlockOperation *blkop1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"执行block1");
    }];
    
    NSBlockOperation *blkop2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"执行block2");
    }];
    
    blkop1.queuePriority = NSOperationQueuePriorityVeryLow;
    blkop2.queuePriority = NSOperationQueuePriorityVeryHigh;
    
    NSLog(@"blkop1 == %@",blkop1);
    NSLog(@"blkop2 == %@",blkop2);
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [queue addOperation:blkop1];
    [queue addOperation:blkop2];
    
//    NSLog(@"%@", [queue operations]);
    
    for (NSOperation *op in [queue operations]) {
        NSLog(@"op == %@", op);
    }
}

@end
