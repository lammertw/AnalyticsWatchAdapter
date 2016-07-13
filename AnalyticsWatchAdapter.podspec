#
# Be sure to run `pod lib lint AnalyticsWatchAdapter.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'AnalyticsWatchAdapter'
  s.version          = '0.1.1'
  s.summary          = 'An adapter to send analytics (like Google Analytics) from your Watch App'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
At the moment of creating this library (June 2016) there is no watchos support for the Google Analytics library. To still be able to send your analytics to Google or any other analytics service this library provides an interface that can be used by watchos apps. It uses the WatchConnectivity framework under the hood to first send analytics requests from the Watch app to the iPhone app. Then it's send automatically from the iPhone app to the analytics service.
                       DESC

  s.homepage         = 'https://github.com/lammertw/AnalyticsWatchAdapter'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Lammert Westerhoff' => 'westerhoff@gmail.com' }
  s.source           = { :git => 'https://github.com/lammertw/AnalyticsWatchAdapter.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/lwesterhoff'

  s.ios.deployment_target = '8.0'
  s.watchos.deployment_target = '2.0'
  s.default_subspecs = 'Watch'

  s.subspec 'Core' do |ss|
    ss.source_files = 'AnalyticsWatchAdapter/Core/Classes/**/*'
    ss.frameworks = 'Foundation'
  end

  s.subspec 'Watch' do |ss|
    ss.dependency 'AnalyticsWatchAdapter/Core'
    ss.source_files = 'AnalyticsWatchAdapter/Watch/Shared/Classes/**/*'
    ss.ios.source_files = 'AnalyticsWatchAdapter/Watch/iOS/Classes/**/*'
    ss.watchos.source_files = 'AnalyticsWatchAdapter/Watch/WatchOS/Classes/**/*'
    ss.weak_frameworks = 'WatchConnectivity'
  end

end
