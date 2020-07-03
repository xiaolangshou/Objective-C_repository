//
//  ViewController.m
//  MQTTDemo
//
//  Created by Liu Tao on 2020/6/30.
//  Copyright © 2020 Liu Tao. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, assign) NSString *ClientID;
@property (nonatomic, assign) NSString *host;
@property (nonatomic, assign) NSString *username;
@property (nonatomic, assign) NSString *password;
@property (nonatomic, assign) NSString *topic;
@property (nonatomic, assign) unsigned short keepAlive;
@property (nonatomic, assign) unsigned short port;

@property (nonatomic, strong) UIButton *startBtn;
@property (nonatomic, strong) UIButton *subscribeBtn;
@property (nonatomic, strong) UIButton *closeBtn;
@property (nonatomic, strong) UIButton *sendBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _ClientID = @"mqttjs_279852cbdf";
    _host = @"127.0.0.1";
    _username = @"jimmy_ou";
    _password = @"123456789";
    _keepAlive = 60;
    _port = 43052;
    _topic = @"testtopic";
    
    [self setupView];
}

- (void)setupView {
    
    _startBtn = [[UIButton alloc] initWithFrame:CGRectMake(60, 120, 100, 50)];
    _startBtn.backgroundColor = UIColor.cyanColor;
    [self.view addSubview:_startBtn];
    [_startBtn setTitle:@"连接" forState:UIControlStateNormal];
    [_startBtn addTarget:self action:@selector(startBtnTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    _subscribeBtn = [[UIButton alloc] initWithFrame:CGRectMake(60, 200, 100, 50)];
    _subscribeBtn.backgroundColor = UIColor.cyanColor;
    [self.view addSubview:_subscribeBtn];
    [_subscribeBtn setTitle:@"订阅" forState:UIControlStateNormal];
    [_subscribeBtn addTarget:self action:@selector(subscribeBtnTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    _closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(60, 280, 100, 50)];
    _closeBtn.backgroundColor = UIColor.cyanColor;
    [self.view addSubview:_closeBtn];
    [_closeBtn setTitle:@"关闭" forState:UIControlStateNormal];
    [_closeBtn addTarget:self action:@selector(closeBtnTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    _sendBtn = [[UIButton alloc] initWithFrame:CGRectMake(60, 360, 100, 50)];
    _sendBtn.backgroundColor = UIColor.cyanColor;
    [self.view addSubview:_sendBtn];
    [_sendBtn setTitle:@"发送消息" forState:UIControlStateNormal];
    [_sendBtn addTarget:self action:@selector(sendBtnTapped:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)startBtnTapped: (UIButton *)btn {
    
    NSLog(@"当前方法名称：%s",__FUNCTION__);
    [self initMQTT:_ClientID
          username:_username
          password:_password
         keepAlive:_keepAlive
              port:_port];
}

- (void)subscribeBtnTapped: (UIButton *)btn {
    
    NSLog(@"当前方法名称：%s",__FUNCTION__);
    [self subscribeType:_topic];
}

- (void)closeBtnTapped: (UIButton *)btn {
    
    NSLog(@"当前方法名称：%s",__FUNCTION__);
    [self closeMQTTClient];
}

- (void)sendBtnTapped: (UIButton *)btn {
    
    NSLog(@"当前方法名称：%s",__FUNCTION__);
    [self sendMessage:@"你好啊"];
}

// 初始化并建立连接
- (void)initMQTT:(NSString *)clientID
        username:(NSString *)username
        password:(NSString *)password
        keepAlive:(unsigned short)keepAlive
        port:(unsigned short)port
{
    WEAKSELF
    MQTTClient *client = [[MQTTClient alloc] initWithClientId:clientID];
    client.username = username;
    client.password = password;
    client.cleanSession = true;
    client.keepAlive = keepAlive;
    client.port = port;
    self.client = client;
    
    // 链接MQTT
    [client connectToHost:_host completionHandler:^(MQTTConnectionReturnCode code) {
        if (code == ConnectionAccepted) {
            NSLog(@"链接MQTT成功");
            // 链接成功
            [weakSelf.client subscribe:self.topic withQos:AtLeastOnce completionHandler:^(NSArray *grantedQos) {
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
    
    [self.client subscribe:topic withQos:AtMostOnce completionHandler:^(NSArray *grantedQos) {
        NSLog(@"订阅 返回 %@", grantedQos);
    }];
}


// 关闭MQTT
- (void)closeMQTTClient {
    WEAKSELF
    [self.client disconnectWithCompletionHandler:^(NSUInteger code) {
        NSLog(@"MQTT Client is disconnected");
        [weakSelf.client unsubscribe:self.topic withCompletionHandler:^{
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
