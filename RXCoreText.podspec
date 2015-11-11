Pod::Spec.new do |s|
  s.name     = 'RXCoreText'
  s.version  = '0.1'
  s.license  = 'MIT'
  s.summary  = 'Image and text use CoreText to show.'
  s.homepage = 'https://github.com/xzjxylophone/RXCoreText'
  s.author   = { 'Rush.D.Xzj' => 'xzjxylophoe@gmail.com' }
  s.social_media_url = "http://weibo.com/xzjxylophone"
  s.source   = { :git => 'https://github.com/xzjxylophone/RXCoreText.git', :tag => "v#{s.version}" }
  s.description = %{
    RXCoreText is a simple image and text show.
  }
  s.source_files = 'RXCoreText/*.{h,m}’
  s.ios.framework = 'Foundation', 'UIKit', 'CoreText', 'CoreGraphics'
  s.public_header_files = 'RXCoreText/RXCTHeader.h'
  s.ios.deployment_target = '6.0'
  s.requires_arc = true
end

