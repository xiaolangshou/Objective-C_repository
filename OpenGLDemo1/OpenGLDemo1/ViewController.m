//
//  ViewController.m
//  OpenGLDemo1
//
//  Created by Thomas Lau on 2020/4/3.
//  Copyright © 2020 TLLTD. All rights reserved.
//

#import "ViewController.h"
#import "GLKViewController.h"
#import "GLSLViewController.h"

@interface ViewController ()

@property (strong, nonatomic) UIButton *btn;
@property (strong, nonatomic) UIButton *btn2;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.btn = [[UIButton alloc] initWithFrame: CGRectMake(30, 120, 100, 50)];
    self.btn.backgroundColor = [UIColor greenColor];
    [self.btn setTitle:@"nihao" forState: UIControlStateNormal];
    [self.view addSubview:self.btn];
    [self.btn addTarget:self action:@selector(btnTapped) forControlEvents: UIControlEventTouchUpInside];
    
    self.btn2 = [[UIButton alloc] initWithFrame:CGRectMake(30, 240, 100, 50)];
    self.btn2.backgroundColor = [UIColor greenColor];
    [self.btn2 setTitle:@"nihao2" forState: UIControlStateNormal];
    [self.view addSubview: self.btn2];
    [self.btn2 addTarget:self action:@selector(btnTapped) forControlEvents: UIControlEventTouchUpInside];
}

- (void)btnTapped {
    
    [self presentViewController:[[GLKViewController alloc] init] animated: YES completion: nil];
}

- (void)btn2Tapped {
    
    [self presentViewController:[[GLSLViewController alloc] init] animated: YES completion: nil];
}



@end
