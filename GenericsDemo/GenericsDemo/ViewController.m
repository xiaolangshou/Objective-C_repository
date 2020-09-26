//
//  ViewController.m
//  GenericsDemo
//
//  Created by Thomas Lau on 2020/9/26.
//  Copyright © 2020 TLLTD. All rights reserved.
//

#import "ViewController.h"
#import "TLCollection.h"

@interface ViewController ()

@property (strong, nonatomic) NSMutableArray<TLCollection *> *personArr;

@end

@implementation ViewController



// 泛型：不声明具体类型，以便编写出灵活的，可重用的方法和类型。

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self demo1];
    [self demo2];
}

- (void)demo1 {
    
    // 元素类型为NSString的数组
    NSArray<NSString *> *arr = @[@"a",@"b"];
    
    // 字典
    NSDictionary<NSString *, NSNumber *> *dic = @{@"a": @1};
    
    NSLog(@"%@", arr);
    NSLog(@"%@", dic);
}


- (void)demo2 {
    
    self.personArr = [[NSMutableArray alloc] init];
    [self.personArr addObject:@1];
    
    TLCollection *cl = [[TLCollection alloc] init];
    cl.name = @"Thomas";
    cl.age = [NSNumber numberWithInt:29];
    cl.jobs = @[@"tecenct", @"alibaba", @"baidu"];
    
    [self.personArr addObject:cl];
    
    NSLog(@"self.personArr = %@", self.personArr);
}

@end
