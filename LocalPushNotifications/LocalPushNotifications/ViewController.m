//
//  ViewController.m
//  LocalPushNotifications
//
//  Created by Thomas Lau on 2020/5/4.
//  Copyright © 2020 TLLTD. All rights reserved.
//

#import "ViewController.h"
#import <UserNotifications/UserNotifications.h>

@interface ViewController ()

// 设置通知弹出的时间
@property(nullable, nonatomic, copy) NSDate *fireDate;

// 时区，默认系统使用的时区
@property(nullable, nonatomic, copy) NSTimeZone *timeZone;

// 通知的重复间隔
@property(nonatomic) NSCalendarUnit repeatInterval;

// 重复日期
@property(nullable, nonatomic, copy) NSCalendar *repeatCalendar;

// 区域：当进入该区域时，就会发出一个通知
@property(nullable, nonatomic, copy) CLRegion *region NS_AVAILABLE_IOS(8_0);

// YES：进入某一个时区只会发出一次通知，NO：每次进入该区域都会发出通知
@property(nonatomic, assign) BOOL regionTriggersOnce NS_AVAILABLE_IOS(8_0);

// 提示信息
@property(nullable, nonatomic, copy) NSString *alertBody;

// 用于决定 alertAction 是否生效
@property(nonatomic) BOOL hasAction;

// 锁屏界面滑块下显示的文字
@property(nullable, nonatomic, copy) NSString *alertAction;

// 不需要设置
@property(nullable, nonatomic, copy) NSString *alertLaunchImage;

// 通知中心的标题
@property(nullable, nonatomic, copy) NSString *alertTitle NS_AVAILABLE_IOS(8_2);

// 设置通知发出时音效
@property(nullable, nonatomic, copy) NSString *soundName;

// 应用程序右上角的数字
@property(nonatomic) NSInteger applicationIconBadgeNumber;

// 额外信息
@property(nullable, nonatomic, copy) NSDictionary *userInfo;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNotifications];
}

// 创建并且发出通知
- (void)setupNotifications {
    
    if (@available(iOS 10.0, *)) {

         // 消息标识
         NSString *identifier = @"request1";
         // 获取通知中心用来激活新建的通知
         UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
         // 通知的内容
         UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
         content.badge = [NSNumber numberWithInt:1];
         content.title = @"测试";
         content.body = @"干嘛呢";
         content.sound = [UNNotificationSound defaultSound];
        
         // 间隔多久推送一次
         //UNTimeIntervalNotificationTrigger 延时推送
         //UNCalendarNotificationTrigger 定时推送
         //UNLocationNotificationTrigger 位置变化推送
         
         // 当前时间之后的10s后推送一次(如果重复的话时间要大于等于60s)
         UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:5 repeats:NO];
        
         // 定时推送
         // NSDateComponents *dateCom = [[NSDateComponents alloc] init];
         // 每天下午3点10分推送
         // dateCom.hour = 15;
         // dateCom.minute = 10;
         // UNCalendarNotificationTrigger *trigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:dateCom repeats: YES];
         
         // 建立通知请求
         UNNotificationRequest *notificationRequest = [UNNotificationRequest requestWithIdentifier: identifier content: content trigger: trigger];
         // 将建立的通知请求添加到通知中心
         [center addNotificationRequest: notificationRequest withCompletionHandler:^(NSError * _Nullable error) {
             if (error) {
                   NSLog(@"%@本地推送 :( 报错 %@", identifier, error);
             } else {
                   NSLog(@"通知请求添加到通知中心 Success");
             }
         }];
    } else {
         // 1.创建本地通知
         UILocalNotification *localNotification = [[UILocalNotification alloc] init];
         // 2.设置通知显示的内容
         // 2.1、设置通知弹出的时间
         localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow: 2];
         // 2.2、设置通知中心的标题
         localNotification.alertTitle = @"测试";
         // 2.3、设置提示信息
         localNotification.alertBody = @"干嘛呢";
         // 2.4、设置滑块显示的文字
         localNotification.alertAction = @"快点";
         // 2.5、设置通知的声音
         // 自定义声音
         // localNotification.soundName = @"buyao.wav";
         // 系统默认声音
        if (@available(iOS 10.0, *)) {
            localNotification.soundName = [UNNotificationSound defaultSound];
        } else {
            // Fallback on earlier versions
        }
         // 2.6、设置应用程序图标右上角的数字
         localNotification.applicationIconBadgeNumber = 1;
         
         // 3、调度本地通知(调度之后某个时刻会弹出通知)
         [[UIApplication sharedApplication] scheduleLocalNotification: localNotification];
    }
}

@end
