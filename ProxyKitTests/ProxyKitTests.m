//
//  ProxyKitTests.m
//  ProxyKitTests
//
//  Created by Christopher Ballinger on 7/18/14.
//  Copyright (c) 2014 Christopher Ballinger. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SOCKSProxy.h"
#import "GCDAsyncProxySocket.h"

#define EXP_SHORTHAND YES
#import "Expecta.h"

@interface ProxyKitTests : XCTestCase <GCDAsyncSocketDelegate, SOCKSProxyDelegate>
@property (nonatomic) BOOL didConnect;
@property (nonatomic) BOOL didRead;
@end

@implementation ProxyKitTests

- (void)setUp
{
    [super setUp];
    [Expecta setAsynchronousTestTimeout:60];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testClientInitialization
{
    GCDAsyncProxySocket *socket = [[GCDAsyncProxySocket alloc] init];
    [socket setProxyHost:@"127.0.0.1" port:9050 version:GCDAsyncSocketSOCKSVersion5];
    NSError *error = nil;
    BOOL success = [socket connectToHost:@"example.com" onPort:80 error:&error];
    XCTAssertTrue(success, @"connectToHost:onPort:error: failed: %@", error);
}

- (void) testUsernamePasswordAuth {
    NSError *error = nil;
    SOCKSProxy *proxy = [[SOCKSProxy alloc] init];
    BOOL success = [proxy startProxyOnPort:9050 error:&error];
    XCTAssertTrue(success, @"could not start proxy: %@", error);
    GCDAsyncProxySocket *socket = [[GCDAsyncProxySocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    [socket setProxyHost:@"127.0.0.1" port:9050 version:GCDAsyncSocketSOCKSVersion5];
    [socket setProxyUsername:@"username" password:@"password"];
    error = nil;
    success = [socket connectToHost:@"example.com" onPort:80 error:&error];
    XCTAssertTrue(success, @"connectToHost:onPort:error: failed: %@", error);
    expect(_didConnect).willNot.equal(NO);
    expect(_didRead).willNot.equal(NO);
}

- (void) socksProxy:(SOCKSProxy*)socksProxy clientDidConnect:(SOCKSProxySocket*)clientSocket {
    NSLog(@"clientDidConnect: %@", clientSocket);
}

- (void) socksProxy:(SOCKSProxy*)socksProxy clientDidDisconnect:(SOCKSProxySocket*)clientSocket {
    NSLog(@"clientDidDisconnect: %@", clientSocket);
}

- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port {
    NSLog(@"didConnectToHost (%d): %@", port, host);
    self.didConnect = YES;
    [sock readDataWithTimeout:-1 tag:314159];

}

- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag {
    NSLog(@"didReadData (%ld): %@", tag, data);
    self.didRead = YES;
}

@end
