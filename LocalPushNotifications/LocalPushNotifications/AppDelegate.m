//
//  AppDelegate.m
//  LocalPushNotifications
//
//  Created by Thomas Lau on 2020/5/4.
//  Copyright © 2020 TLLTD. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
       
    [self registerNotifications: application withOptions: launchOptions];
    
    return YES;
}

// 注册本地通知
- (void)registerNotifications: (UIApplication *)application withOptions:(NSDictionary *)launchOptions {
    
    if (@available(iOS 10.0, *)) {
         // iOS10
         UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
         center.delegate = self;
         [center requestAuthorizationWithOptions:(UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionBadge) completionHandler:^(BOOL granted, NSError * _Nullable error) {
         }];
     } else {
          UIUserNotificationSettings *notificationSettings = [UIUserNotificationSettings settingsForTypes: UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert categories: nil];
          [application registerUserNotificationSettings: notificationSettings];
      }
    // 判断是否是通过点击通知打开了应用程序
    if (launchOptions[UIApplicationLaunchOptionsLocalNotificationKey]) {
        // 在app杀死的情况下，本地通知所走的地方
        NSLog(@"在app杀死的情况下，本地通知所走的地方");
    }
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(nonnull UILocalNotification *)notification
{
    NSLog(@"本地通知的点击");
    /**
     UIApplicationStateActive, 前台
     UIApplicationStateInactive, 进入前台
     UIApplicationStateBackground 在后台
     */
    if (application.applicationState == UIApplicationStateActive) {
        NSLog(@"前台状态");
    } else if (application.applicationState == UIApplicationStateInactive) {
        NSLog(@"进入前台状态");
    } else if (application.applicationState == UIApplicationStateBackground) {
        NSLog(@"后台状态,页面跳转");
    }
}

@end
