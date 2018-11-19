#
# Be sure to run `pod lib lint HYScanter.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'HYScanter'
  s.version          = '0.1.0'
  s.summary          = 'A short description of HYScanter.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/YHQiu@github.com/HYScanter'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'YHQiu@github.com' => '632244510@qq.com' }
  s.source           = { :git => 'https://github.com/YHQiu@github.com/HYScanter.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'HYScanter/Classes/**/*'
  
  # s.resource_bundles = {
  #   'HYScanter' => ['HYScanter/Assets/*.png']
  # }
  s.prefix_header_contents = '#import <YYKit/YYKit.h>' , '#import <Masonry/Masonry.h>', '#import <HYRoute/HYRouteHeader.h>'

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit', 'AVKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  s.dependency 'YYKit'
  s.dependency 'Masonry'
  s.dependency 'HYConfig' , '~> 0.1.0'
  s.dependency 'HYCategory', '~> 0.1.0'
  s.dependency 'HYRoute', '~> 0.1.0'
  s.dependency 'HYThirdPartyLibrary', '~> 0.1.0'
  s.dependency 'HYDB', '~> 0.1.0'
  s.dependency 'HYCore', '~> 0.1.0'
end
