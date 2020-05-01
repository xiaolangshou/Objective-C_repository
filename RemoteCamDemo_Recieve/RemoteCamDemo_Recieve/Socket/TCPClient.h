//
//  TCPClient.h
//  RemoteCamDemo_Recieve
//
//  Created by Thomas Lau on 2020/4/18.
//  Copyright © 2020 TLLTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GCDAsyncSocket.h"

NS_ASSUME_NONNULL_BEGIN

@protocol TCPClientDelegate <NSObject>

- (void)socket:(GCDAsyncSocket *)socket didReadData:(NSData *) data;

@end

@interface TCPClient : NSObject

@property(nonatomic,  weak) id<TCPClientDelegate> delegate;

+ (instancetype)sharedSocketClient;

- (void)connectServerWithHost: (NSString *)host andPort: (UInt16)port;
- (void)disConnectServer;
- (void)sendData:(NSData *)data;

@end

NS_ASSUME_NONNULL_END
