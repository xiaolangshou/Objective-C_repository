//
//  ViewController.m
//  RuntimeDemo1
//
//  Created by Thomas Lau on 2020/3/5.
//  Copyright © 2020 TLLTD. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[Person new] sendMessage:@"hello"];
    // objc_msgSend([Person new], @selector(sendMessage:), @"LGKODY");
}


@end
