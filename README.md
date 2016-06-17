# AnalyticsWatchAdapter

[![Version](https://img.shields.io/cocoapods/v/AnalyticsWatchAdapter.svg?style=flat)](http://cocoapods.org/pods/AnalyticsWatchAdapter)
[![License](https://img.shields.io/cocoapods/l/AnalyticsWatchAdapter.svg?style=flat)](http://cocoapods.org/pods/AnalyticsWatchAdapter)
[![Platform](https://img.shields.io/cocoapods/p/AnalyticsWatchAdapter.svg?style=flat)](http://cocoapods.org/pods/AnalyticsWatchAdapter)

At the moment of creating this library (June 2016) there is no watchos support for the Google Analytics library. To still be able to send your analytics to Google or any other analytics service this library provides an interface that can be used by watchos apps. It uses the WatchConnectivity framework under the hood to first send analytics requests from the Watch app to the iPhone app. Then it's send automatically from the iPhone app to the analytics service.

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

Since this library is using the WatchConnectivity framework it will only work on iOS 9+ and watchos 2+. Though due to the use of `#availablity` it is source compatible with iOS 8.

## Installation

AnalyticsWatchAdapter is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "AnalyticsWatchAdapter"
```

Include this both in your iOS target and WatchKit extension target.

## Usage

Tracking analytics is done through the `Analytics` protocol. Wether it's used from the iOS or watchos target, the usuage is the same though setup differs (see sections below). An instance of this protocol is obtained through the global `analyticsInstance` singleton instance.

To track a page/screen view use:

```swift
analyticsInstance?.trackPageViewAsString("Welcome screen")
```

You can also track a category:

```swift
analyticsInstance?.trackCategory("store", action: "purchase")
```

For more options, see the `Analytics` protocol.

### Setup iOS 1: implementation analytics service

For this library to work you must provide an implementation of the `Analytics` protocol in your iOS target. 

This library does not include a default implementation of the `Analytics` protocol. However, an implementation using Google Analytics is included in the sample code in GoogleAnalytics.swift. For that to work, copy this file into your project and add a pod dependency to 'GoogleAnalytics'. (Because the GoogleAnalytics library contains static libraries it cannot be a transitive dependency of this library, see https://github.com/CocoaPods/CocoaPods/issues/2926).

You can provide your own implementation of `Analytics`. Make sure to set the global `analyticsInstance` to refer to an instance of your implementation.

### Setup iOS 2: receiving analytic events from the watch app

The previous step is enough if you only want send analytic events from your iOS target. If however you also want to send events from your watchos target (which is actually the prupose of this library) you need to set the `AnalyticsWatchReceiver` as delegate of your `WCSession`. To learn how to setup a `WCSession` see the documentation at https://developer.apple.com/library/ios/documentation/WatchConnectivity/Reference/WCSession_class/.

You can either use the `AnalyticsWatchReceiver` directly as delegate ...

    if WCSession.isSupported() {
        let session = WCSession.defaultSession()
        session.delegate = AnalyticsWatchReceiver.instance
        session.activateSession()
    }

... or if you also need to receive other events from the Watch App implement a proxy that forwards the `session:didReceiveUserInfo:` method to `AnalyticsWatchReceiver`. You can use the `isAnalyticUserInfo` method to check if something should be handled by the `AnalyticsWatchReceiver`:

    func session(session: WCSession, didReceiveUserInfo userInfo: [String : AnyObject]) {
        if AnalyticsWatchReceiver.isAnalyticUserInfo(userInfo) {
            AnalyticsWatchReceiver.instance.session(session, didReceiveUserInfo: userInfo)
        }
    }

### Setup watchos extension target

In your watchos extension target you need to start the `AnalyticsWatchSender` with the `WCSession`:

    let session = WCSession.defaultSession()
    session.delegate = WatchModel.instance
    session.activateSession()
    AnalyticsWatchSender.start(session)

This will set an implementation of the `Analytics` protocol to the global `analyticsInstance` that sends the events to the phone. A good place for this would be inside `awakeWithContext` of your initial Interface Controller.

After that you can send analytic events from the watch app just like you would from you iOS app:

```swift
analyticsInstance?.trackPageViewAsString("Welcome screen in Watch App")
```

## Author

Lammert Westerhoff, westerhoff@gmail.com

## License

AnalyticsWatchAdapter is available under the MIT license. See the LICENSE file for more info.
