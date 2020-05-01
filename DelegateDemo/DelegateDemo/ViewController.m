//
//  ViewController.m
//  DelegateDemo
//
//  Created by Thomas Lau on 2020/3/9.
//  Copyright © 2020 TLLTD. All rights reserved.
//

#import "ViewController.h"
#import "ColorView.h"

@interface ViewController () <TLProtocol>

@property (strong, nonatomic) ColorView *cView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.cView = [[ColorView alloc] init];
    self.cView.backgroundColor = UIColor.grayColor;
    self.cView.frame = CGRectMake(10, 60, 100, 100);
    self.cView.delegate = self;
    [self.view addSubview:self.cView];
}


- (void)changeColor:(nonnull UIColor *)color {
    self.view.backgroundColor = color;
}

@end
