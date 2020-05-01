//
//  ViewController2.m
//  TabBarVC2
//
//  Created by Liu Tao on 2020/2/19.
//  Copyright © 2020 Liu Tao. All rights reserved.
//

#import "ViewController2.h"
#import "son.h"

@interface ViewController2 ()

@property (strong, nonatomic) UIButton * btn;

@end

@implementation ViewController2

+ (id)sharedInstance {
    static ViewController2 *sharedInstance = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.brownColor;
    
    self.btn = [[UIButton alloc] initWithFrame:CGRectMake(60, 100, 50, 25)];
    self.btn.backgroundColor = UIColor.blackColor;
    [self.view addSubview:self.btn];
    [self.btn addTarget:self action:@selector(btnTapped) forControlEvents: UIControlEventTouchUpInside];
}


- (void)btnTapped {
    UIViewController *vc = [[son alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
