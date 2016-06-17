//
//  AnalyticsWatchSender.swift
//  NSInternational
//
//  Created by Lammert Westerhoff on 16/06/16.
//  Copyright © 2016 NS International. All rights reserved.
//

import Foundation
import WatchConnectivity

public class AnalyticsWatchSender: NSObject, Analytics {

    private let session: WCSession

    private init(session: WCSession) {
        self.session = session
        super.init()
    }

    public static func start(session: WCSession) -> Analytics {
        let instance = AnalyticsWatchSender(session: session)
        analyticsInstance = instance
        return instance
    }

    public func trackPageViewAsString(screenName: String) {
        trackPageViewAsString(screenName, customDimensions: [])
    }

    public func trackPageViewAsString(screenName: String, customDimensions: [CustomDimension]) {
        var object: [String: AnyObject] = [WatchAnalyticsScreenNameKey: screenName]
        if customDimensions.count > 0 {
            object[WatchAnalyticsCustomDimensionsKey] = customDimensions.map { [WatchAnalyticsCustomDimensionsIndexKey: $0.index, WatchAnalyticsCustomDimensionsValueKey: $0.value] }
        }
        transfer(object, action: .TrackPageView)
    }

    public func trackCategory(category: String, action: String) {
        trackCategory(category, action: action, label: nil, value: nil)
    }

    public func trackCategory(category: String, action: String, label: String?, value: NSNumber?) {
        var object: [String: AnyObject] = [WatchAnalyticsCategoryNameKey: category, WatchAnalyticsCategoryActionKey: action]
        object[WatchAnalyticsCategoryLabelKey] = label
        object[WatchAnalyticsCategoryValueKey] = value

        transfer(object, action: .TrackCategory)
    }

    private func transfer(object: [String: AnyObject], action: WatchAnalyticAction) {
        var object = object
        object[WatchAnalyticsActionKey] = action.rawValue
        session.transferUserInfo([WatchAnalyticsKey: object])
    }
}