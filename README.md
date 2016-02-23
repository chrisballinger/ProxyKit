# [ProxyKit](https://github.com/chrisballinger/proxykit/)
[![Build Status](https://travis-ci.org/chrisballinger/ProxyKit.svg?branch=master)](https://travis-ci.org/chrisballinger/ProxyKit)
[![Version](https://cocoapod-badges.herokuapp.com/v/ProxyKit/badge.svg)](http://cocoadocs.org/docsets/ProxyKit)
[![Platform](https://cocoapod-badges.herokuapp.com/p/ProxyKit/badge.svg)](http://cocoadocs.org/docsets/ProxyKit)

Objective-C [SOCKS 5](http://en.wikipedia.org/wiki/SOCKS) / [RFC 1928](http://www.ietf.org/rfc/rfc1928.txt) proxy server and socket client libraries built upon [GCDAsyncSocket](https://github.com/robbiehanson/CocoaAsyncSocket).

## Usage

`SOCKSProxy` - Dead simple SOCKSv5 proxy server for OS X or iOS. Supports acting as background "VoIP" sockets on iOS via GCDAsyncSocket.

```obj-c
SOCKSProxy *proxy = [[SOCKSProxy alloc] init];
[proxy startProxyOnPort:9050];
```

`GCDAsyncProxySocket` - Proxy-compatible subclass and drop-in replacement for (most of) GCDAsyncSocket.

```obj-c
GCDAsyncProxySocket *socket = [[GCDAsyncProxySocket alloc] init];
[socket setProxyHost:@"127.0.0.1" port:9050 version:GCDAsyncSocketSOCKSVersion5];
[socket connectToHost:@"example.com" onPort:80 error:nil];
```

For more documentation check out [ProxyKit on Cocoadocs](http://cocoadocs.org/docsets/ProxyKit).

### Installation

We use Cocoapods. There are two subspecs for the server and client code. By default both are included. Put one of these your `Podfile`:

    pod 'ProxyKit'    
    pod 'ProxyKit/Server' # Just the server code
    pod 'ProxyKit/Client' # Just the client code

To install:
 
    $ pod install
    
### Tests

You can run tests by opening up `ProxyKit.xcworkspace` after installing the Pods.

## Dependencies

* [GCDAsyncSocket](https://github.com/robbiehanson/CocoaAsyncSocket) - GCD-based Async Objective-C socket library
* [CocoaLumberjack](https://github.com/CocoaLumberjack/CocoaLumberjack) - A fast & simple, yet powerful & flexible logging framework for Mac and iOS

## Apps Using This Library

* [Tether](https://github.com/chrisballinger/Tether-iOS) - Tethering for non-jailbroken iOS Devices over USB.
* [ChatSecure](https://github.com/chrisballinger/ChatSecure-iOS) - free and open source encrypted chat client for iPhone and Android that supports OTR encryption over XMPP.

## TODO

* Better documentation
* More tests

## Contributing

Thank you for your interest in contributing to ProxyKit! Check out the TODO for things that still need to be done.

1. Fork the project and work in a feature branch.
2. Ensure that the existing tests are passing and/or write more tests.
2. Open a pull request on GitHub.
3. Thank you!


## Author

[Chris Ballinger](https://github.com/chrisballinger)

## License

MIT