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

@interface ProxyKitTests : XCTestCase
@end

@implementation ProxyKitTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testServerInitialization
{
    SOCKSProxy *proxy = [[SOCKSProxy alloc] init];
    [proxy startProxyOnPort:9050];
    [proxy resetNetworkStatistics];
    [proxy disconnect];
}

- (void)testClientInitialization
{
    GCDAsyncProxySocket *socket = [[GCDAsyncProxySocket alloc] init];
    [socket setProxyHost:@"127.0.0.1" port:9050 version:GCDAsyncSocketSOCKSVersion5];
    NSError *error = nil;
    BOOL success = [socket connectToHost:@"example.com" onPort:80 error:&error];
    XCTAssertTrue(success, @"connectToHost:onPort:error: failed: %@", error);
}

@end
