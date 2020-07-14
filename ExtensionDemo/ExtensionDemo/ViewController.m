//
//  ViewController.m
//  ExtensionDemo
//
//  Created by Thomas Lau on 2020/7/14.
//  Copyright © 2020 TLLTD. All rights reserved.
//

#import "ViewController.h"
#import "NSString+String_Extension.h"

@interface ViewController ()

@property (strong, nonatomic) NSString *str;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _str = @"thomas lau";
    
//    NSLog(@"_str = %lu", (unsigned long)_str.i);
    
    NSLog(@"_str = %@", [_str added:@"eat"]);
}

- (NSString *)added:(NSString *)str1 {
    return [_str stringByAppendingString:str1];
}



@end
