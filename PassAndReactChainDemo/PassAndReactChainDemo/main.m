//
//  main.m
//  PassAndReactChainDemo
//
//  Created by Liu Tao on 2020/2/22.
//  Copyright © 2020 Liu Tao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
    }
    NSLog(@"app delegate");
    
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
