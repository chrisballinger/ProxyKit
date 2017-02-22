Pod::Spec.new do |s|
  s.name         = "ProxyKit"
  s.version      = "1.2.0"
  s.summary      = "SOCKS proxy server and socket client built upon GCDAsyncSocket."
  s.homepage     = "https://github.com/chrisballinger/ProxyKit"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Chris Ballinger" => "chrisballinger@gmail.com" }
  s.social_media_url   = "https://github.com/chrisballinger"
  s.ios.deployment_target = "8.0"
  s.osx.deployment_target = "10.9"
  s.requires_arc = true
  s.source       = { :git => "https://github.com/chrisballinger/ProxyKit.git", :tag => s.version.to_s }

  s.default_subspec = 'standard'

  s.subspec 'common' do |ss|
    ss.dependency 'CocoaAsyncSocket', '~> 7.6'
    ss.dependency 'CocoaLumberjack' # Don't pin version because of 2->3 dependency upgrade nightmare
    ss.requires_arc = true
  end

  s.subspec 'Server' do |ss|
    ss.source_files = 'ProxyKit/Server/*.{h,m}'
    ss.dependency 'ProxyKit/common'
    ss.requires_arc = true
  end

  s.subspec 'Client' do |ss|
    ss.source_files = 'ProxyKit/Client/*.{h,m}'
    ss.dependency 'ProxyKit/common'
    ss.requires_arc = true
  end

  s.subspec 'standard' do |ss|
    ss.dependency 'ProxyKit/Client'
    ss.dependency 'ProxyKit/Server'
    ss.requires_arc = true
  end

end
