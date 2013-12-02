# ProxyKit

Objective-C [SOCKS 5](http://en.wikipedia.org/wiki/SOCKS) / [RFC 1928](http://www.ietf.org/rfc/rfc1928.txt) proxy server and socket client libraries built upon [GCDAsyncSocket](https://github.com/robbiehanson/CocoaAsyncSocket).

## Usage

`SOCKSProxy` - Dead simple SOCKSv5 proxy server for OS X or iOS. Supports acting as background "VoIP" sockets on iOS via GCDAsyncSocket.

	SOCKSProxy *proxy = [[SOCKSProxy alloc] init];
	[proxy startProxyOnPort:9050];


`GCDAsyncProxySocket` - Proxy-compatible subclass and drop-in replacement for (most of) GCDAsyncSocket.

	GCDAsyncProxySocket *socket = [[GCDAsyncProxySocket alloc] init];
	[socket setProxyHost:@"127.0.0.1" port:9050 version:GCDAsyncSocketSOCKSVersion5];
	[socket connectToHost:@"example.com" onPort:80];

## Dependencies

* [GCDAsyncSocket](https://github.com/robbiehanson/CocoaAsyncSocket) - GCD-based Async Objective-C socket library

## Author

[Chris Ballinger](https://github.com/chrisballinger)

## License

MIT