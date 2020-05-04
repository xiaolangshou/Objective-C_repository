//
//  ViewController.m
//  BlockDemo
//
//  Created by Thomas Lau on 2020/3/9.
//  Copyright © 2020 TLLTD. All rights reserved.
//

#import "ViewController.h"

typedef void (^CompletionBlock)(NSString *str);

@interface ViewController ()

- (void)performActionWithBlock: (CompletionBlock)completionBlock;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self performActionWithBlock:^(NSString *str) {
        NSLog(@"block str:%@", str);
    }];
}

- (void)performActionWithBlock:(CompletionBlock)completionBlock {
    
    NSLog(@"action performed");
    completionBlock(@"aaa");
}

@end
