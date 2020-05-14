//
//  TCPClient.m
//  RemoteCamDemo_Recieve
//
//  Created by Thomas Lau on 2020/4/18.
//  Copyright © 2020 TLLTD. All rights reserved.
//

#import "TCPClient.h"

@interface TCPClient()<GCDAsyncSocketDelegate>

@property (nonatomic, strong) GCDAsyncSocket *socket;
@property (nonatomic, strong) NSTimer *heartbeatTimer;
@property (nonatomic, assign) BOOL isConnection;

@end

@implementation TCPClient

+ (instancetype)sharedSocketClient{
    static TCPClient *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance=[[self alloc] init];
    });
    return sharedInstance;
}

- (void)connectServerWithHost:(NSString *)host andPort:(UInt16)port {
    
    self.socket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_global_queue(0, 0)];
    
    [self.socket disconnect];
    NSError *error = nil;
    [self.socket connectToHost: host onPort:port error:&error];
    if (error) {
        NSLog(@"socketError--%@", error);
    }
}

- (void)disConnectServer {
    
    self.socket.delegate = nil;
    self.isConnection = NO;
    if (self.heartbeatTimer) {
        [self.heartbeatTimer invalidate];
        self.heartbeatTimer = nil;
    }
    [self.socket disconnect];
}

- (void)sendData:(NSData *)data {
    
    [TCPClient.sharedSocketClient.socket writeData:data withTimeout:-1 tag:0];
}

#pragma mark - GCDSocketDelegate

- (void)socket:(GCDAsyncSocket*)sock didConnectToHost:(NSString*)host port:(UInt16)port{
    
    NSLog(@"--连接成功--");
    self.isConnection = YES;
    [sock readDataWithTimeout:-1 tag:0];
}


- (void)socketDidDisconnect:(GCDAsyncSocket*)sock withError:(NSError*)err{
    NSLog(@"--断开连接--");
    if (self.heartbeatTimer) {
        [self.heartbeatTimer invalidate];
        self.heartbeatTimer = nil;
    }
}

- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag{
    
    if ([self.delegate respondsToSelector:@selector(socket:didReadData:)]) {
        [self.delegate socket: self.socket didReadData:data];
    }
    [sock readDataWithTimeout:-1 tag:0];
}

@end
