//
//  ViewController.m
//  assignDemo
//
//  Created by Thomas Lau on 2020/9/2.
//  Copyright © 2020 TLLTD. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, assign) NSObject *obj1;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.obj1 = nil;
    {
        id obj0 = @[@1,@2,@3];
        self.obj1 = obj0;
        
        NSLog(@"A: %@", self.obj1);
    }
    // obj0变量超出其作用域，强引用失效，自动释放自己持有的对象，因为无持有者，变成废气对象(野指针)
    NSLog(@"B: %@", self.obj1);
}


@end
