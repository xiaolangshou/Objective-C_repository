//
//  ViewController.m
//  RuntimeDemo1
//
//  Created by Thomas Lau on 2020/3/5.
//  Copyright © 2020 TLLTD. All rights reserved.
//

#import "ViewController.h"
#import "UIView+DefaultColor.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIView *test = [[UIView alloc] init];
    test.defaultColor = [UIColor redColor];
    
    NSLog(@"%@", test.defaultColor);
}


@end
