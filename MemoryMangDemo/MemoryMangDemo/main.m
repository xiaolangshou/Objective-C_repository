//
//  main.m
//  MemoryMangDemo
//
//  Created by Liu Tao on 2020/2/21.
//  Copyright © 2020 Liu Tao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
//#import "Person.h"
#import <objc/runtime.h>
#import <objc/message.h>

/// 使用此例子时记得把buildsetting中auto-refernceConting改为no
int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
//        Person *p = [[Person alloc] init];
//        [p release];
//        p = nil;
//        [p release];
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
//    return 0;
}
