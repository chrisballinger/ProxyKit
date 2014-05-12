//
//  SOCKSProxySocket.h
//  Tether
//
//  Created by Christopher Ballinger on 11/26/13.
//  Copyright (c) 2013 Christopher Ballinger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GCDAsyncSocket.h"

@class SOCKSProxySocket;

@protocol SOCKSProxySocketDelegate <NSObject>
@optional
- (void) proxySocketDidDisconnect:(SOCKSProxySocket*)proxySocket withError:(NSError *)error;
- (void) proxySocket:(SOCKSProxySocket*)proxySocket didReadDataOfLength:(NSUInteger)numBytes;
- (void) proxySocket:(SOCKSProxySocket*)proxySocket didWriteDataOfLength:(NSUInteger)numBytes;
@end

@interface SOCKSProxySocket : NSObject <GCDAsyncSocketDelegate>

@property (nonatomic, readonly) uint16_t destinationPort;
@property (nonatomic, strong, readonly) NSString* destinationHost;
@property (nonatomic, weak) id<SOCKSProxySocketDelegate> delegate;
@property (nonatomic) dispatch_queue_t callbackQueue;
@property (nonatomic, readonly) NSUInteger totalBytesWritten;
@property (nonatomic, readonly) NSUInteger totalBytesRead;

- (id) initWithSocket:(GCDAsyncSocket*)socket delegate:(id<SOCKSProxySocketDelegate>)delegate;

@end
