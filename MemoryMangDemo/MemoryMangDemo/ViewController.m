//
//  ViewController.m
//  MemoryMangDemo
//
//  Created by Liu Tao on 2020/2/21.
//  Copyright © 2020 Liu Tao. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)loadView {
    [super loadView];
    
    NSLog(@"load view");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"view did load");
    
    // 模拟从网络获取到一个字符串
    NSMutableString *strM = [NSMutableString stringWithString:@"BOSS"];
    // 将得到的字符串赋值给 Person对象的 title 属性
    Person *p = [[Person alloc] init];
    
    p.copName = strM; //copy
    p.mutableCopName = strM;  //copy
    p.strongName = strM;  //strong
    
    [strM setString:@"11"];
    
    NSLog(@"strM %@, copyName %@, mutableCopyName: %@, strongName: %@", strM, p.copName, p.mutableCopName, p.strongName);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSLog(@"view will appear");
}

@end
