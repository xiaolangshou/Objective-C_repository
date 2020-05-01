//
//  ViewController.m
//  CategoryAndExtension
//
//  Created by Liu Tao on 2020/2/24.
//  Copyright © 2020 Liu Tao. All rights reserved.
//

#import "ViewController.h"
#import "NSString+NSString_Category.h"
//#import "NSString+NSString_Extension.h"
// #import "Protocol+Arr.h"

@interface ViewController () /**<>*/

@property (strong, nonatomic) NSString *strrrs;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _strrrs = @"aaa";
    
    NSLog(@"original name = %@", _strrrs.name);
    
    _strrrs.name = @"names";
    
    NSLog(@"%@", [_strrrs add:@"bbb"]);
}

//- (nonnull NSString *)addd:(nonnull NSString *)str {
//    return str;
//}

@end
