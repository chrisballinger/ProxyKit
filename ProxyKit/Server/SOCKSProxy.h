//
//  SOCKSProxy.h
//  Tether
//
//  Created by Christopher Ballinger on 11/26/13.
//  Copyright (c) 2013 Christopher Ballinger. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CocoaAsyncSocket;
#import "SOCKSProxySocket.h"

@class SOCKSProxy;

@protocol SOCKSProxyDelegate <NSObject>
- (void) socksProxy:(SOCKSProxy*)socksProxy clientDidConnect:(SOCKSProxySocket*)clientSocket;
- (void) socksProxy:(SOCKSProxy*)socksProxy clientDidDisconnect:(SOCKSProxySocket*)clientSocket;
@end

/**
 *  SOCKS proxy server implementation.
 */
@interface SOCKSProxy : NSObject <GCDAsyncSocketDelegate, SOCKSProxySocketDelegate>

@property (nonatomic, readonly) uint16_t listeningPort;
@property (nonatomic, weak) id<SOCKSProxyDelegate> delegate;
@property (nonatomic) dispatch_queue_t callbackQueue;
@property (nonatomic, readonly) NSUInteger connectionCount;

/**
 *  Total number of bytes written during lifetime of SOCKSProxy.
 *  @see resetNetworkStatistics
 */
@property (nonatomic, readonly) NSUInteger totalBytesWritten;

/**
 *  Total number of bytes read during lifetime of SOCKSProxy.
 *  @see resetNetworkStatistics
 */
@property (nonatomic, readonly) NSUInteger totalBytesRead;

/**
 *  Sets `totalBytesWritten` and `totalBytesRead` to 0.
 *  @see totalBytesWritten
 *  @see totalBytesRead
 */
- (void) resetNetworkStatistics;


- (BOOL) startProxy; // defaults to port 9050
- (BOOL) startProxyOnPort:(uint16_t)port;
- (BOOL) startProxyOnPort:(uint16_t)port error:(NSError**)error;
- (void) disconnect;


// SOCKS authorization
// btw this is horribly insecure, especially over the open internet
- (void) addAuthorizedUser:(NSString*)username password:(NSString*)password;
- (void) removeAuthorizedUser:(NSString*)username;
- (void) removeAllAuthorizedUsers;
- (BOOL) checkAuthorizationForUser:(NSString*)username password:(NSString*)password;

@end
