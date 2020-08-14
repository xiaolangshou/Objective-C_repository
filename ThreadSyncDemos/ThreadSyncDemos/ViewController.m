//
//  ViewController.m
//  ThreadSyncDemos
//
//  Created by Thomas Lau on 2020/8/14.
//  Copyright © 2020 TLLTD. All rights reserved.
//

#import "ViewController.h"
#import <os/lock.h>
#import <pthread.h>

@interface ViewController ()

@end

@implementation ViewController


// 线程同步方案性能优先级排列
// os_unfair_lock > dispatch_semaphore > pthread_mutex > pdispatch_queue(DISPATCH_QUEUE_SERIAL) > NSLock > NSCondition > NSConditionLock > @synchronized

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self osLock];
    [self mutexLock];
}

- (void)osLock {
    os_unfair_lock lock = OS_UNFAIR_LOCK_INIT;
    os_unfair_lock_lock(&lock);
    
    NSLog(@"os lock excute");
    
    os_unfair_lock_unlock(&lock);
}

- (void)mutexLock {
    
    // 静态初始化
    pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;
    
    // 初始化属性
    pthread_mutexattr_t attr;
    pthread_mutexattr_init(&attr);
    pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_DEFAULT);
    
    // 初始化锁
    pthread_mutex_init(&mutex, &attr);
    
    // 销毁属性
    pthread_mutexattr_destroy(&attr);
    
    // 初始化锁 NULL表示默认属性
    pthread_mutex_init(&mutex, NULL);
    
    pthread_mutex_lock(&mutex);
    //codeing here...
    NSLog(@"mutex lock excute");
    pthread_mutex_unlock(&mutex);
    
}

- (void)dealloc {
//    pthread_mutex_destroy(&mutex);
}

- (void)NSConditionLock {
    int start = 0;
    NSConditionLock *conditionLock = [[NSConditionLock alloc] initWithCondition:start];
    
    [conditionLock lock];
    [conditionLock lockWhenCondition:1];
    [conditionLock unlockWithCondition:0];
    [conditionLock unlock];
}

- (void)semaphoreLock {
    
    // 初始值为1，代表只允许一条线程访问资源，从而实现线程同步
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
    
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);//减一
    
    dispatch_semaphore_signal(semaphore);//加一
}

@end
