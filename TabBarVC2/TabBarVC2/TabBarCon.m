//
//  TabBarCon.m
//  TabBarVC2
//
//  Created by Liu Tao on 2020/2/19.
//  Copyright © 2020 Liu Tao. All rights reserved.
//

#import "TabBarCon.h"
#import "ViewController1.h"
#import "ViewController2.h"

@interface TabBarCon ()

@end

@implementation TabBarCon

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupView];
}

- (void)setupView {
    
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController: ViewController1.sharedInstance];
    UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController: ViewController2.sharedInstance];
    nav1.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"11" image: NULL selectedImage: NULL];
    nav2.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"22" image: NULL selectedImage: NULL];
    [arr addObject: nav1];
    [arr addObject: nav2];
    
    [self setViewControllers:arr animated: YES];
}

@end
