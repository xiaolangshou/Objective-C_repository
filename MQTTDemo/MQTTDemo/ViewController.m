//
//  ViewController.m
//  MQTTDemo
//
//  Created by Liu Tao on 2020/6/30.
//  Copyright © 2020 Liu Tao. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initMQTT:@"ID" username:@"username" password:@"password"];
}

// 初始化并建立连接
- (void)initMQTT:(NSString *)clientID username:(NSString *)username password:(NSString *)password
{
    WEAKSELF
    MQTTClient *client = [[MQTTClient alloc] initWithClientId:clientID];
    client.username = username;
    client.password = password;
    client.cleanSession = false;
    client.keepAlive = 20;
    client.port = 11883;
    self.client = client;
    
    // 链接MQTT
    [client connectToHost:@"链接的MQTT的URL" completionHandler:^(MQTTConnectionReturnCode code) {
        if (code == ConnectionAccepted) {
            NSLog(@"链接MQTT成功");
            // 链接成功
            [weakSelf.client subscribe:@"你需要订阅的主题" withQos:AtLeastOnce completionHandler:^(NSArray *grantedQos) {
                DLog(@"订阅 返回 %@", grantedQos);
            }];
        } else if (code == ConnectionRefusedBadUserNameOrPassword) {
            NSLog(@"MQTT 账号或验证码错误");
        } else if (code == ConnectionRefusedUnacceptableProtocolVersion) {
            NSLog(@"MQTT 不可接受的协议");
        } else if (code == ConnectionRefusedIdentiferRejected) {
            NSLog(@"MQTT不认可");
        } else if (code == ConnectionRefusedServerUnavailable) {
            NSLog(@"MQTT 拒绝链接");
        } else {
            NSLog(@"MQTT 未授权");
        }
    }];
    
    // 接受消息实体
    client.messageHandler = ^(MQTTMessage *message) {
        NSString *jsonStr = [[NSString alloc] initWithData:message.payload encoding:NSUTF8StringEncoding];
        NSLog(@"easymqttservice mqtt connect success %@", jsonStr);
    };
}

// 订阅主题
- (void)subscribeType:(NSString *)topic {
    
    [self.client subscribe:@"你需要订阅的主题" withQos:AtMostOnce completionHandler:^(NSArray *grantedQos) {
        NSLog(@"订阅 返回 %@", grantedQos);
    }];
}


// 关闭MQTT
- (void)closeMQTTClient {
    WEAKSELF
    [self.client disconnectWithCompletionHandler:^(NSUInteger code) {
        NSLog(@"MQTT Client is disconnected");
        [weakSelf.client unsubscribe:@"已经订阅的主题" withCompletionHandler:^{
            NSLog(@"取消订阅");
        }];
    }];
}

// 发送消息
- (void)sendMessage:(NSString *)postMsg {
    
    [self.client publishString: postMsg
                       toTopic: @"发送消息的主题 根据服务端定"
                       withQos: AtLeastOnce
                        retain: NO
             completionHandler: ^(int mid)
     {
//         if (cmd != METHOD_SOCKET_CHAT_TO) {
             NSLog(@"发送消息 返回 %d",mid);
//         }
     }];

}

@end
