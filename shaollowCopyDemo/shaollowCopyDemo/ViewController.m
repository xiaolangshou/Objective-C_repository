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

/*
 1.非容器不可变对象 NSString
 2.非容器可变对象 NSMutableString
 3.容器不可变对象 NSArray
 4.容器可变对象 NSMutableArray
 */

- (void)viewDidLoad {
    [super viewDidLoad];

    [self func1];
    // [self func2];
    // [self func3];
    // [self func4];
}

// 1.非容器不可变对象 NSString
- (void)func1 {
    
    NSString *str1 = @"aaa";
    NSString *str2 = [str1 copy];
    NSString *str3 = [str1 mutableCopy];
    
    str1 = @"ccc";
    
    NSLog(@"str1: %@, str1: %p, class:%@", str1, str1, [str1 class]);
    NSLog(@"str2: %@, str2: %p, class:%@", str2, str2, [str2 class]);
    NSLog(@"str3: %@, str3: %p, class:%@", str3, str3, [str3 class]);
}

// 2.非容器可变对象 NSMutableString
- (void)func2 {
    
    NSMutableString *str1 = [NSMutableString stringWithFormat:@"aaa"];
    NSMutableString *str2 = [str1 copy];
    NSMutableString *str3 = [str1 mutableCopy];
    
    NSLog(@"str1: %p, class:%@", str1, [str1 class]);
    NSLog(@"str2: %p, class:%@", str2, [str1 class]);
    NSLog(@"str3: %p, class:%@", str3, [str1 class]);
}

// 3.容器不可变对象 NSArray  (开辟新的内存空间，但是容器里元素地址没变，任然是浅拷贝)
- (void)func3 {
    
    NSString *str1 = [NSMutableString stringWithFormat:@"aaa"];
    
    NSArray *array1 = [NSArray arrayWithObjects:str1, @"bbb", nil];
    NSArray *array2 = [array1 copy];
    NSArray *array3 = [array1 mutableCopy];
    
    NSLog(@"array1: %p, class:%@", array1, [array1 class]);
    NSLog(@"array2: %p, class:%@", array2, [array2 class]);
    NSLog(@"array3: %p, class:%@", array3, [array3 class]);
    
    NSLog(@"原对象");
    NSLog(@"array1[0]:%p, class: %@", array1[0], [array1[0] class]);
    NSLog(@"array1[1]:%p, class: %@", array1[1], [array1[1] class]);
    
    NSLog(@"copy对象");
    NSLog(@"array2[0]:%p, class: %@", array2[0], [array2[0] class]);
    NSLog(@"array2[1]:%p, class: %@", array2[1], [array2[1] class]);
    
    NSLog(@"mutableCopy对象");
    NSLog(@"array3[0]:%p, class: %@", array3[0], [array3[0] class]);
    NSLog(@"array3[0]:%p, class: %@", array3[1], [array3[1] class]);
}

// 4.容器可变对象 NSMutableArray (开辟新的内存空间，但是容器内元素地址没变，依然是浅拷贝)
- (void)func4 {
    
    NSString *str1 = [NSMutableString stringWithFormat:@"aaa"];
    
    NSMutableArray *array1 = [NSMutableArray arrayWithObjects:str1, @"bbb", nil];
    NSArray *array2 = [array1 copy];
    NSArray *array3 = [array1 mutableCopy];
    
    NSLog(@"array1: %p, class: %@", array1, [array1 class]);
    NSLog(@"array2: %p, class: %@", array2, [array2 class]);
    NSLog(@"array3: %p, class: %@", array3, [array3 class]);
    
    NSLog(@"原对象");
    NSLog(@"array1[0]: %p, array1[1]: %p", array1[0], array1[1]);
    
    NSLog(@"copy对象");
    NSLog(@"array2[0]: %p, array2[1]: %p", array2[0], array2[1]);
    
    NSLog(@"mutableCopy对象");
    NSLog(@"array3[0]: %p, array3[1]: %p", array3[0], array3[1]);
}

@end
