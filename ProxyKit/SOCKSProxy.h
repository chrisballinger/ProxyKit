//
//  SOCKSProxy.h
//  Tether
//
//  Created by Christopher Ballinger on 11/26/13.
//  Copyright (c) 2013 Christopher Ballinger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GCDAsyncSocket.h"
#import "SOCKSProxySocket.h"

@interface SOCKSProxy : NSObject <GCDAsyncSocketDelegate, SOCKSProxySocketDelegate>

@property (nonatomic, readonly) uint16_t listeningPort;

- (void) startProxy; // defaults to port 9050
- (void) startProxyOnPort:(uint16_t)port;

@end
