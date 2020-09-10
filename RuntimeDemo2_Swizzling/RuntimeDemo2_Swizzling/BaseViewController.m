//
//  BaseViewController.m
//  RuntimeDemo2_Swizzling
//
//  Created by Thomas Lau on 2020/9/7.
//  Copyright © 2020 TLLTD. All rights reserved.
//

#import "BaseViewController.h"
#import <Objc/runtime.h>
#import "Common.m"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSLog(@"%s", __FUNCTION__);
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    NSLog(@"%s", __FUNCTION__);
}

+ (void)load {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        SEL originalSelector = @selector(viewWillAppear:);
        SEL swizzledSelector = @selector(jKviewWillAppear);
        SEL originalSelector2 = @selector(viewWillDisappear:);
        SEL swizzledSelector2 = @selector(jKviewWillDisappear);
        
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method originalMethod2 = class_getInstanceMethod(class, originalSelector2);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        Method swizzledMethod2 = class_getInstanceMethod(class, swizzledSelector2);
        
        // judged the method named
        BOOL didAddMethod = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        BOOL didAddMethod2 = class_addMethod(class, originalSelector2, method_getImplementation(swizzledMethod2), method_getTypeEncoding(swizzledMethod2));
        
        // if swizzledMethod is already existed
        if (didAddMethod) {
            class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
        
        if (didAddMethod2) {
            class_replaceMethod(class, swizzledSelector2, method_getImplementation(originalMethod2), method_getTypeEncoding(originalMethod2));
        } else {
            method_exchangeImplementations(originalMethod2, swizzledMethod2);
        }
    });
}

- (void)jKviewWillAppear {
    
    NSLog(@"%s", __FUNCTION__);
    num += 1;
    NSLog(@"count: %d", num);
    // 需要注入的代码写在此处
    [self jKviewWillAppear];
}

- (void)jKviewWillDisappear {
    
    NSLog(@"%s", __FUNCTION__);
    num -= 1;
    NSLog(@"count: %d", num);
    
    [self jKviewWillDisappear];
}

@end
