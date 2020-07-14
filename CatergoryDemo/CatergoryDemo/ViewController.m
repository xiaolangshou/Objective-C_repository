//
//  ViewController.m
//  CatergoryDemo
//
//  Created by Thomas Lau on 2020/7/14.
//  Copyright © 2020 TLLTD. All rights reserved.
//

#import "ViewController.h"
#import "NSString+NSString_Category.h"

@interface ViewController ()

@property (assign, nonatomic) NSString *thomas;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"%@", _thomas);
    
    _thomas = @"liu tao";
    
    NSLog(@"%@", _thomas);
    
    _thomas.name = @"thomas";
    
    NSLog(@"%@", _thomas.name);
    
    _thomas.Func;
}

@end
