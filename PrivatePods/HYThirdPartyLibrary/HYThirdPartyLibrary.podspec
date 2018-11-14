#
# Be sure to run `pod lib lint HYThirdPartyLibrary.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
s.name             = 'HYThirdPartyLibrary'
s.version          = '0.1.0'
s.summary          = 'A short description of HYThirdPartyLibrary.'

s.description      = <<-DESC
TODO: Add long description of the pod here.
DESC

s.homepage         = 'https://github.com/YHQiu@github.com/HYThirdPartyLibrary'
s.license          = { :type => 'MIT', :file => 'LICENSE' }
s.author           = { 'YHQiu@github.com' => '632244510@qq.com' }
s.source           = { :git => 'https://github.com/YHQiu@github.com/HYThirdPartyLibrary.git', :tag => s.version.to_s }

s.ios.deployment_target = '8.0'

s.source_files = 'HYThirdPartyLibrary/Classes/**/*.{h,m,mm}'
s.resource = 'HYThirdPartyLibrary/Assets/*.xcassets','HYThirdPartyLibrary/Classes/**/*.{xib,bundle,png,jpg,jpeg,storyboard}'

s.public_header_files = 'Pod/Classes/**/*.h'
#s.frameworks = 'UIKit', 'MapKit'
# s.dependency 'AFNetworking', '~> 2.3'
s.framework = 'Foundation'
end
