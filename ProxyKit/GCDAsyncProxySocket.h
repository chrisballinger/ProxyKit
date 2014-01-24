//
//  GCDAsyncProxySocket.h
//  OnionKit
//
//  Created by Christopher Ballinger on 11/19/13.
//  Copyright (c) 2013 ChatSecure. All rights reserved.
//

#import "GCDAsyncSocket.h"

typedef NS_ENUM(int16_t, GCDAsyncSocketSOCKSVersion) {
    GCDAsyncSocketSOCKSVersion4 = 0,    // Not implemented
    GCDAsyncSocketSOCKSVersion4a,       // Not implemented
    GCDAsyncSocketSOCKSVersion5         // WIP
};

typedef NS_ENUM(int16_t, GCDAsyncProxySocketError) {
	GCDAsyncProxySocketNoError = 0,           // Never used
    GCDAsyncProxySocketAuthenticationError
};

@interface GCDAsyncProxySocket : GCDAsyncSocket <GCDAsyncSocketDelegate>

// SOCKS proxy settings
@property (nonatomic, strong, readonly) NSString *proxyHost;
@property (nonatomic, readonly) uint16_t proxyPort;
@property (nonatomic, readonly) GCDAsyncSocketSOCKSVersion proxyVersion;

@property (nonatomic, strong, readonly) NSString *proxyUsername;
@property (nonatomic, strong, readonly) NSString *proxyPassword;

/**
 * SOCKS Proxy settings
 **/
- (void) setProxyHost:(NSString*)host port:(uint16_t)port version:(GCDAsyncSocketSOCKSVersion)version;
- (void) setProxyUsername:(NSString *)username password:(NSString*)password;

@end
