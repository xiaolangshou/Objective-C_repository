//
//  ViewController.m
//  AVCaptureDemo
//
//  Created by Thomas Lau on 2020/5/7.
//  Copyright © 2020 TLLTD. All rights reserved.
//

#import "ViewController.h"
#import "ViewController2.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupView];
}

- (void)setupView {
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = UIColor.cyanColor;
    [btn setTitle:@"相机" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState: UIControlStateNormal];
    btn.frame = CGRectMake(self.view.frame.size.width * 0.5 - 50,
                           self.view.frame.size.height * 0.5 - 50,
                           100,
                           100);
    [btn addTarget:self action:@selector(presentCamera) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)presentCamera {
    
    ViewController2 *vc = [[ViewController2 alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:nil];
}

@end
