//
//  ProxyKitTests.m
//  ProxyKitTests
//
//  Created by Christopher Ballinger on 7/18/14.
//  Copyright (c) 2014 Christopher Ballinger. All rights reserved.
//

@import XCTest;
@import ProxyKit;
@import CocoaLumberjack;
@import CocoaAsyncSocket;

@interface ProxyKitTests : XCTestCase <GCDAsyncSocketDelegate, SOCKSProxyDelegate>
@property (nonatomic, strong) XCTestExpectation *didConnect;
@property (nonatomic, strong) XCTestExpectation *didRead;

@property (nonatomic, strong) SOCKSProxy *proxy;
@property (nonatomic, strong) GCDAsyncProxySocket *clientSocket;
@property (nonatomic) uint16_t portNumber;
@end

@implementation ProxyKitTests

- (void)setUp
{
    [super setUp];
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    self.portNumber = [self randomPort];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [DDLog removeAllLoggers];
    if (self.proxy) {
        [self.proxy disconnect];
    }
    [super tearDown];
}

- (uint16_t) randomPort {
    return arc4random() % (65535 - 1024) + 1024;
}

- (void)testClientInitialization
{
    GCDAsyncProxySocket *socket = [[GCDAsyncProxySocket alloc] init];
    [socket setProxyHost:@"127.0.0.1" port:self.portNumber version:GCDAsyncSocketSOCKSVersion5];
    NSError *error = nil;
    BOOL success = [socket connectToHost:@"example.com" onPort:80 error:&error];
    XCTAssertTrue(success, @"connectToHost:onPort:error: failed: %@", error);
}

- (void) testNoAuth {
    NSError *error = nil;
    self.proxy = [[SOCKSProxy alloc] init];
    self.proxy.delegate = self;
    self.proxy.callbackQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    BOOL success = [self.proxy startProxyOnPort:self.portNumber error:&error];
    XCTAssertTrue(success, @"could not start proxy: %@", error);
    self.clientSocket = [[GCDAsyncProxySocket alloc] initWithDelegate:self delegateQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)];
    [self.clientSocket setProxyHost:@"127.0.0.1" port:self.portNumber version:GCDAsyncSocketSOCKSVersion5];
    error = nil;
    success = [self.clientSocket connectToHost:@"example.com" onPort:80 error:&error];
    XCTAssertTrue(success, @"connectToHost:onPort:error: failed: %@", error);
    self.didConnect = [self expectationWithDescription:@"Did Connect"];
    self.didRead = [self expectationWithDescription:@"Did Read"];
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@",error);
        }
    }];
}

- (void) testUsernamePasswordAuth {
    NSError *error = nil;
    self.proxy = [[SOCKSProxy alloc] init];
    self.proxy.delegate = self;
    self.proxy.callbackQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    NSString *username = @"username";
    NSString *password = @"password";
    BOOL success = [self.proxy startProxyOnPort:self.portNumber error:&error];
    [self.proxy addAuthorizedUser:username password:password];
    XCTAssertTrue(success, @"could not start proxy: %@", error);
    self.clientSocket = [[GCDAsyncProxySocket alloc] initWithDelegate:self delegateQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)];
    [self.clientSocket setProxyHost:@"127.0.0.1" port:self.portNumber version:GCDAsyncSocketSOCKSVersion5];
    [self.clientSocket setProxyUsername:username password:password];
    error = nil;
    success = [self.clientSocket connectToHost:@"example.com" onPort:80 error:&error];
    XCTAssertTrue(success, @"connectToHost:onPort:error: failed: %@", error);
    self.didConnect = [self expectationWithDescription:@"Did Connect"];
    self.didRead = [self expectationWithDescription:@"Did Read"];
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@",error);
        }
    }];
}

- (void) socksProxy:(SOCKSProxy*)socksProxy clientDidConnect:(SOCKSProxySocket*)clientSocket {
    NSLog(@"clientDidConnect: %@", clientSocket);
}

- (void) socksProxy:(SOCKSProxy*)socksProxy clientDidDisconnect:(SOCKSProxySocket*)clientSocket {
    NSLog(@"clientDidDisconnect: %@", clientSocket);
}

- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port {
    NSLog(@"didConnectToHost (%d): %@", port, host);
    [self.didConnect fulfill];
    NSString * getRequest = @"GET / HTTP/1.0\r\n\r\n";
    NSData *data = [getRequest dataUsingEncoding:NSUTF8StringEncoding];
    [self.clientSocket writeData:data withTimeout:-1 tag:111222];
}

- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag {
    NSLog(@"didReadData (%ld): %@", tag, data);
    [self.didRead fulfill];
}

- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag {
    if (tag == 111222) {
        [self.clientSocket readDataWithTimeout:-1 tag:314159];
    }
}

@end
