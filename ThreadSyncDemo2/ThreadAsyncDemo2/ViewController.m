//
//  ViewController.m
//  ThreadAsyncDemo2
//
//  Created by Liu Tao on 2020/8/14.
//  Copyright © 2020 Liu Tao. All rights reserved.
//

#import "ViewController.h"
#import <os/lock.h>

@interface ViewController () {
    dispatch_semaphore_t semaphreLock;
    os_unfair_lock lock;
}

@property (assign, nonatomic) NSInteger ticket;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //[self semaphoreSync];
    [self semaphoreSync2];
    //[self os_lock];
}

- (void)semaphoreSync {
    
    NSLog(@"thread: %@", [NSThread currentThread]);
    NSLog(@"semaphore begin");
    
    // 阻塞当前线程，等待block执行完再恢复
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

// 两个队列同时进行写操作，需要加锁实现同步 semaphore
- (void)semaphoreSync2 {
    
    self.ticket = 20;
    
    semaphreLock = dispatch_semaphore_create(1);
    
    NSLog(@"thread: %@", [NSThread currentThread]);
    NSLog(@"semaphore begin");
    
    dispatch_queue_t queue1 = dispatch_queue_create("queue", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t queue2 = dispatch_queue_create("queue2", DISPATCH_QUEUE_SERIAL);
    
    __weak typeof(self) weakSelf = self;
    dispatch_async(queue1, ^{
        [weakSelf saleTicket];
    });
    
    dispatch_async(queue2, ^{
        [weakSelf saleTicket];
    });
    
    NSLog(@"semaphore end");
}

- (void)saleTicket {
    
    NSLog(@"%ld", (long)self.ticket);
    
    dispatch_semaphore_wait(semaphreLock, DISPATCH_TIME_FOREVER);
    
    while (self.ticket > 0) {
        self.ticket -= 1;
        NSLog(@"%@", [NSString stringWithFormat:@"剩余票数: %ld 窗口: %@", (long)self.ticket, [NSThread currentThread]]);
        [NSThread sleepForTimeInterval:0.2];
    }
    
    NSLog(@"票已售完");
    
    dispatch_semaphore_signal(semaphreLock);
}

// 两个队列同时进行写操作，需要加锁实现同步 os_unfair_lock
- (void)os_lock {
    
    self.ticket = 2000;
    
    lock = OS_UNFAIR_LOCK_INIT;
    
    NSOperationQueue *queue1 = [[NSOperationQueue alloc] init];
    NSOperationQueue *queue2 = [[NSOperationQueue alloc] init];
    
    __weak typeof(self) weakSelf = self;
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        [weakSelf saleTicketSafe];
    }];
    
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        [weakSelf saleTicketSafe];
    }];
    
    [queue1 addOperation:op1];
    [queue2 addOperation:op2];
}

- (void)saleTicketSafe {
    
    os_unfair_lock_lock(&lock);
    
    while (self.ticket > 0) {
        self.ticket -= 1;
        NSLog(@"%@", [NSString stringWithFormat:@"剩余票数: %ld 窗口: %@", (long)self.ticket, [NSThread currentThread]]);
        [NSThread sleepForTimeInterval:0.2];
    }
    
    os_unfair_lock_unlock(&lock);
}

@end
