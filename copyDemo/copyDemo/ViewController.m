//
//  ViewController.m
//  copyDemo
//
//  Created by Thomas Lau on 2020/9/2.
//  Copyright © 2020 TLLTD. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (copy, nonatomic) NSString *nameCopy;
@property (strong, nonatomic) NSString *nameStrong;

@end

@implementation ViewController

// 浅拷贝：只创建一个新的指针，指向元指针指向的内存
// 深拷贝：创建一个新的指针，内容拷贝自原指针指向的内存，并指向它
- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.nameCopy = @"copy";
//    self.nameStrong = @"strong";
//
//    NSLog(@"self.nameCopy = %p, address = %p", self.nameCopy, &_nameCopy);
//    NSLog(@"self.nameStrong = %p, address = %p", self.nameStrong, &_nameStrong);
    
    /// copy mutableCopy NSString
    NSString *string = @"Thomas";
    NSString *copyString = [string copy];//浅拷贝
    NSMutableString *mutableCopyString = [string mutableCopy];//深拷贝
    [mutableCopyString appendString:@"你好"];
    
    NSLog(@"string = %p copyString = %p mutableCopyString = %p", string, copyString, mutableCopyString);
    NSLog(@"string = %@ copyString = %@ mutableCopyString = %@", string, copyString, mutableCopyString);
    
    /// copy mutableCopy NSMutableString
    
}


@end
