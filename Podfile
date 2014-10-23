source 'https://github.com/CocoaPods/Specs.git'

target :ProxyKitTestsMac do
    platform :osx, '10.9'
    # Waiting for CocoaAsyncSocket 7.4.1 to be pushed to trunk
    pod 'CocoaAsyncSocket', :git => 'https://github.com/robbiehanson/CocoaAsyncSocket.git', :commit => 'c0bbcbcc5e039ca5d732f9844bf95c3d8ee31a5b'
    pod 'ProxyKit', :path => './ProxyKit.podspec'
    pod 'Expecta', '~> 0.3'
end

target :ProxyKitTestsiOS do
    platform :ios, '7.0'
    # Waiting for CocoaAsyncSocket 7.4.1 to be pushed to trunk
    pod 'CocoaAsyncSocket', :git => 'https://github.com/robbiehanson/CocoaAsyncSocket.git', :commit => 'c0bbcbcc5e039ca5d732f9844bf95c3d8ee31a5b'
    pod 'ProxyKit', :path => './ProxyKit.podspec'
    pod 'Expecta', '~> 0.3'
end