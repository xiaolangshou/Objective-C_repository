//
//  ViewController.m
//  BlockVSWeak
//
//  Created by Thomas Lau on 2020/5/8.
//  Copyright © 2020 TLLTD. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"

typedef void (^Block)(NSString *str);

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    Person *str1 = [[Person alloc] init];
//    __weak Person *str2 = str1;
//
//    str1 = nil;
//
//    NSLog(@"__weak 修饰 p1 = %@   p2 = %@", str1, str2);
//
//    // __block可以解决block内部无法修改外部auto变量的问题
//    __block int age = 10;
//    NSLog(@"%p", &age);
//    void (^myblock)(void) = ^{
//        NSLog(@"%d", age);
//    };
//    age = 20;
//    NSLog(@"%p", &age);
//    myblock();
    

    static int number = 1;
    NSLog(@"%d", number);
    number += 2;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
    number -= 1;
    });
    NSLog(@"%d", number);
}



@end
