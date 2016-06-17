//
//  GoogleAnalytics.swift
//  NSInternational
//
//  Created by Lammert Westerhoff on 16/06/16.
//  Copyright © 2016 NS International. All rights reserved.
//

import Foundation
import AnalyticsWatchAdapter

class GoogleAnalytics: Analytics {

    private var tracker: GAITracker {
        return GAI.sharedInstance().defaultTracker
    }

    static func startTracker() -> Analytics {
        let instance = GoogleAnalytics()
        GAI.sharedInstance().trackerWithName("iOS-tracker", trackingId: "[your key]")
        GAI.sharedInstance().dispatchInterval = 30
        instance.tracker.allowIDFACollection = false
        analyticsInstance = instance
        return instance
    }

    func trackPageViewAsString(screenName: String) {
        trackPageViewAsString(screenName, customDimensions: [])
    }

    func trackPageViewAsString(screenName: String, customDimensions: [CustomDimension]) {
        print("Track Page: \(screenName)")
        tracker.set(kGAIScreenName, value: screenName)
        customDimensions.forEach { customDimension in
            tracker.set(GAIFields.customDimensionForIndex(UInt(customDimension.index)), value: customDimension.value)
        }
        tracker.send(GAIDictionaryBuilder.createScreenView().set("test", forKey: GAIFields.customDimensionForIndex(1)).build() as [NSObject : AnyObject])
    }

    func trackCategory(category: String, action: String) {
        trackCategory(category, action: action, label: nil, value: nil)
    }

    func trackCategory(category: String, action: String, label: String?, value: NSNumber?) {
        tracker.send(GAIDictionaryBuilder.createEventWithCategory(category, action: action, label: label ?? "", value: value ?? 0).build() as [NSObject : AnyObject])
    }

    func trackTimingWithCategory(category: String, starting startTime: NSDate) {
        trackTimingWithCategory(category, starting: startTime, withName: nil, withLabel: nil)
    }

    func trackTimingWithCategory(category: String, starting startTime: NSDate, withName name: String?, withLabel label: String?) {
        let duration = -startTime.timeIntervalSinceNow
        tracker.send(GAIDictionaryBuilder.createTimingWithCategory(category, interval: duration, name: name ?? "", label: label ?? "").build() as [NSObject : AnyObject])
    }
    
}
