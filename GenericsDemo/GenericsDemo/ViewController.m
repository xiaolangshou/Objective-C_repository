//
//  ViewController.m
//  GenericsDemo
//
//  Created by Thomas Lau on 2020/9/26.
//  Copyright © 2020 TLLTD. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"

@interface ViewController ()

@end

@implementation ViewController



// 泛型：不声明具体类型（或可限制内容的类型），以便编写出灵活的，可重用的方法和类型。

- (void)viewDidLoad {
    [super viewDidLoad];
    
 // [self demo1];
    [self demo2];
}

- (void)demo1 {
    
    // 元素类型为NSString的数组
    NSArray<NSString *> *arr = @[@"a",@"b"];
    
    // 元素类型为<NSString: NSNumber>的字典
    NSDictionary<NSString *, NSNumber *> *dic = @{@"a": @1};
    
    NSLog(@"%@", arr);
    NSLog(@"%@", dic);
}


- (void)demo2 {
    
    NSMutableArray<Person *> *personArr;
    
    personArr = [[NSMutableArray alloc] init];
    [personArr addObject:@1];
    
    Person *cl = [[Person alloc] init];
    cl.name = @"Thomas";
    cl.age = [NSNumber numberWithInt:29];
    cl.jobs = @[@"tencent", @"alibaba", @"baidu"];
    
    Person *c2 = [[Person alloc] init];
    c2.name = @"Lily";
    c2.age = [NSNumber numberWithInt:24];
    c2.jobs = @[@"dji",@"xiaomi"];
    
    [personArr addObject:cl];
    [personArr addObject:c2];
    
    NSLog(@"personArr = %@", personArr);
}

@end
