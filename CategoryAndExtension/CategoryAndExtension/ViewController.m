//
//  ViewController.m
//  CategoryAndExtension
//
//  Created by Liu Tao on 2020/2/24.
//  Copyright © 2020 Liu Tao. All rights reserved.
//

#import "ViewController.h"
#import "NSString+Operations.h"
#import "NSString+NSString_Extension.h"
// #import "Protocol+Arr.h"

@interface ViewController ()

@property (strong, nonatomic) NSString *str;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"original name1 = %@", _str.name);
    
    _str = @"aaa";
    
    NSLog(@"original name2 = %@", _str.name);
    
    _str.name = @"bbb";
    
    NSLog(@"%@", [_str add:@"ccc"]);
    [_str added:@"ddd"];
}


@end
