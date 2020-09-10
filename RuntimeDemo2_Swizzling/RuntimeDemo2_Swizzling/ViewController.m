//
//  ViewController.m
//  RuntimeDemo2_Swizzling
//
//  Created by Thomas Lau on 2020/9/7.
//  Copyright © 2020 TLLTD. All rights reserved.
//

#import "ViewController.h"
#import "ViewController2.h"
#import <Objc/runtime.h>

@interface ViewController ()

@property (strong, nonatomic) UIButton *btn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _btn = [[UIButton alloc] initWithFrame:CGRectMake(30, 100, 90, 35)];
    _btn.backgroundColor = UIColor.redColor;
    [self.view addSubview:_btn];
    [_btn addTarget:self action:@selector(btnTapped) forControlEvents:UIControlEventTouchUpInside];
}

- (void)btnTapped {
    
    [self presentViewController:[[ViewController2 alloc] init] animated:YES completion:nil];
}


@end
