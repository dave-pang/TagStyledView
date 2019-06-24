#
# Be sure to run `pod lib lint TagStyledView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'TagStyledView'
  s.version          = '0.3.0'
  s.summary          = 'TagStyledView Class'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Easier view of the style of the tag view View to receive and display cells of the collection view
                       DESC

  s.homepage         = 'https://github.com/dave-pang/TagStyledView'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'dave.pang' => 'yainoma00@gmail.com' }
  s.source           = { :git => 'https://github.com/dave-pang/TagStyledView.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '11.0'
#  s.swift_version = '5.0'
  s.source_files = 'TagStyledView/Classes/**/*'
  
  # s.resource_bundles = {
  #   'TagStyledView' => ['TagStyledView/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
