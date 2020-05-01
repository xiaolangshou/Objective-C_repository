//
//  TCPServer.h
//  NativeCameraDemo
//
//  Created by Thomas Lau on 2020/4/16.
//  Copyright © 2020 Liu Tao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GCDAsyncSocket.h"

NS_ASSUME_NONNULL_BEGIN

@interface TCPServer : NSObject

/**
 获取单例
 
 @return id
 */
+ (instancetype)shareInstance;


/**
 开启服务器

 @param port 端口号
 */
- (void)openSerViceWithPort:(uint16_t) port;

/**
 发送数据
 */
- (void)sendData:(NSData *)data;


@end

NS_ASSUME_NONNULL_END
