//
//  ViewController.m
//  shaollowCopyDemo
//
//  Created by Liu Tao on 2020/9/3.
//  Copyright © 2020 Liu Tao. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController


// 浅拷贝和深拷贝本质是地址是否相同
// 1.非容器不可变对象 NSString
// 2.非容器可变对象 NSMutableString
// 3.容器类不可变对象 NSArray
// 4.容器类可变对象 NSMutableArray

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self func1];
//    [self func2];
    [self func3];
}

// 非容器不可变对象
- (void)func1 {
    
    NSString *str1 = @"非容器不可变对象";
    NSString *str2 = [str1 copy];
    NSString *str3 = [str1 mutableCopy];
    
    NSLog(@"str1:%p, class: %@", str1, [str1 class]);
    NSLog(@"str2:%p, class: %@", str2, [str2 class]);
    NSLog(@"str3:%p, cladd: %@", str3, [str3 class]);
}

// 非容器可变对象
- (void)func2 {
    
    NSString *str1 = [NSMutableString stringWithFormat:@"非容器可变对象"];
    NSString *str2 = [str1 copy];
    NSString *str3 = [str1 mutableCopy];
    
    NSLog(@"str1:%p, class: %@", str1, [str1 class]);
    NSLog(@"str2:%p, class: %@", str2, [str2 class]);
    NSLog(@"str3:%p, class: %@", str3, [str3 class]);
}
 
// 容器不可变对象
- (void)func3 {
    
    NSString *str = [NSString stringWithFormat:@"容器不可变对象"];
    NSArray *array = [NSArray arrayWithObjects:str, nil];
    NSArray *copyArray = [array copy];
    NSArray *mutableArray = [array mutableCopy];
    
    NSLog(@"array:%p, class:%@", array, [array class]);
    NSLog(@"copyArray:%p, class:%@", copyArray, [copyArray class]);
    NSLog(@"mutableArray:%p, class:%@", mutableArray, [mutableArray class]);
}

// 容器可变对象
- (void)func4 {
    
}



@end
