//
//  ViewController.h
//  MQTTDemo
//
//  Created by Liu Tao on 2020/6/30.
//  Copyright © 2020 Liu Tao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MQTTKit.h>

 #define WEAKSELF __typeof(&*self) __weak weakSelf = self;

#ifdef DEBUG
#define DLog(...) NSLog(@"%s(%p) %@", __PRETTY_FUNCTION__, self, [NSString stringWithFormat:__VA_ARGS__])
#else
#define DLog(...)
#endif

@interface ViewController : UIViewController

@property (nonatomic, strong) MQTTClient *client;

@end

