//
//  ViewController.m
//  MQTTDemo2
//
//  Created by Thomas Lau on 2020/7/3.
//  Copyright © 2020 TLLTD. All rights reserved.
//

#import "ViewController.h"
#import "MQTTClient.h"

@interface ViewController ()<MQTTSessionDelegate>

@property (nonatomic, strong) MQTTSession *session;
@property (nonatomic, strong) UIButton *subscribeBtn;
@property (nonatomic, strong) UIButton *sendBtn;
@property (nonatomic, strong) UILabel *stateLbl;
@property (nonatomic, strong) UILabel *subscriptionStatusLbl;
@property (nonatomic, strong) UITextView *messagesLbl;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MQTTCFSocketTransport *transport = [[MQTTCFSocketTransport alloc] init];
    transport.host = @"10.161.222.114";
    transport.port = 1883;
        
    self.session = [[MQTTSession alloc] init];
    self.session.delegate = self;
    self.session.transport = transport;
    [self.session connectWithConnectHandler:^(NSError *error) {
        // Do some work
        NSLog(@"connectWithConnectHandler success");
    }];
    
    self.subscribeBtn = [[UIButton alloc] initWithFrame:CGRectMake(30, 100, 100, 50)];
    [self.subscribeBtn setTitle:@"订阅" forState:UIControlStateNormal];
    self.subscribeBtn.backgroundColor = UIColor.cyanColor;
    [self.view addSubview:self.subscribeBtn];
    [self.subscribeBtn addTarget:self action:@selector(subscribeBtnTapped) forControlEvents:UIControlEventTouchUpInside];
    
    self.sendBtn = [[UIButton alloc] initWithFrame:CGRectMake(30, 180, 100, 50)];
    [self.sendBtn setTitle:@"发送" forState:UIControlStateNormal];
    self.sendBtn.backgroundColor = UIColor.cyanColor;
    [self.view addSubview:self.sendBtn];
    [self.sendBtn addTarget:self action:@selector(sendBtnTapped) forControlEvents:UIControlEventTouchUpInside];
    
    self.stateLbl = [[UILabel alloc] initWithFrame:CGRectMake(20, 250, 300, 50)];
    self.stateLbl.backgroundColor = UIColor.lightTextColor;
    [self.view addSubview:self.stateLbl];
    
    self.messagesLbl = [[UITextView alloc] initWithFrame:CGRectMake(20, 320, 320, 100)];
    [self.view addSubview:self.messagesLbl];
    self.messagesLbl.backgroundColor = UIColor.systemGroupedBackgroundColor;
    
    self.subscriptionStatusLbl = [[UILabel alloc] initWithFrame:CGRectMake(20, 460, 100, 50)];
    self.subscriptionStatusLbl.text = @"...";
    self.subscriptionStatusLbl.backgroundColor = UIColor.systemGroupedBackgroundColor;
    [self.view addSubview:self.subscriptionStatusLbl];
}

- (void)subscribeBtnTapped {
    
    [self.session subscribeToTopic:@"testtopic" atLevel:MQTTQosLevelExactlyOnce subscribeHandler:^(NSError *error, NSArray<NSNumber *> *gQoss) {
       if (error) {
           NSLog(@"Subscription failed %@", error.localizedDescription);
       } else {
           NSLog(@"Subscription sucessfull! Granted Qos: %@", gQoss);
       }
    }];
}

- (void)sendBtnTapped {
    
    NSString *str = @"Hello world！";
    //NSData *data = UIImagePNGRepresentation([UIImage imageNamed:@"111"]);
    
    [self.session publishData: [str dataUsingEncoding:NSUTF8StringEncoding]
                      onTopic:@"testtopic"
                       retain:NO
                          qos:MQTTQosLevelAtMostOnce
               publishHandler:^(NSError *error) {
        
    }];
}

#pragma delegate

- (void)newMessage:(MQTTSession *)session
              data:(NSData *)data
           onTopic:(NSString *)topic
               qos:(MQTTQosLevel)qos
          retained:(BOOL)retained
               mid:(unsigned int)mid
{
    
    NSLog(@"topic = %@", topic);
    NSLog(@"data = %@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    self.messagesLbl.text = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

- (void)handleEvent:(MQTTSession *)session event:(MQTTSessionEvent)eventCode error:(NSError *)error {
    
    switch (eventCode) {
        case MQTTSessionEventConnected:
            self.stateLbl.text = @"Connected";
            self.messagesLbl.text = @"";
            break;
        case MQTTSessionEventConnectionClosed:
            self.stateLbl.text = @"Closed";
            break;
        case MQTTSessionEventConnectionClosedByBroker:
            self.stateLbl.text = @"ClosedByBroker";
            break;
        case MQTTSessionEventConnectionError:
            self.stateLbl.text = @"ConnectionError";
            break;
        case MQTTSessionEventProtocolError:
            self.stateLbl.text = @"ProtocolError";
            break;
        case MQTTSessionEventConnectionRefused:
            self.stateLbl.text = @"ConnectionRefused";
            break;
        default:
            break;
    }
}

- (void)subAckReceived:(MQTTSession *)session
                 msgID:(UInt16)msgID
           grantedQoss:(NSArray<NSNumber *> *)qoss
{
    self.subscriptionStatusLbl.text = @"Subscribed";
}

- (void)unsubAckReceived:(MQTTSession *)session msgID:(UInt16)msgID {
    
    self.subscriptionStatusLbl.text = @"Unsubscribed";
}

@end
