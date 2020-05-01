//
//  ViewController.m
//  PassAndReactChainDemo
//
//  Created by Liu Tao on 2020/2/22.
//  Copyright © 2020 Liu Tao. All rights reserved.
//

#import "ViewController.h"
#import "YellowView.h"
#import "CyanView.h"

@interface ViewController ()

@property (strong, nonatomic) CyanView *cyanView;
@property (strong, nonatomic) YellowView *yellowView;
@property (strong, nonatomic) UIButton *btn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"uiview");
    
    [self setupView];
}

- (void)setupView {
     
    _cyanView = [[CyanView alloc] initWithFrame:CGRectMake(UIScreen.mainScreen.bounds.size.width - 200, 200, 100, 100)];
    [self.view addSubview:_cyanView];
    
    _yellowView = [[YellowView alloc] initWithFrame:CGRectMake(60, 190, 100, 100)];
    [self.view addSubview:_yellowView];
    
    
    _btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 64, 50, 30)];
    _btn.backgroundColor = UIColor.redColor;
    [self.view addSubview:_btn];
    
    [_btn addTarget:self action:@selector(btnTapped) forControlEvents: UIControlEventTouchUpInside];
    
}

- (void)btnTapped {
    NSLog(@"btn tapped ...");
}

@end
