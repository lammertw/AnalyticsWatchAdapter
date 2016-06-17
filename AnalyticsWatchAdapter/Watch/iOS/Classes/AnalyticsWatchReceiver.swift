//
//  AnalyticsWatchReceiver.swift
//  NSInternational
//
//  Created by Lammert Westerhoff on 16/06/16.
//  Copyright © 2016 NS International. All rights reserved.
//

import Foundation
import WatchConnectivity

@available(iOS 9.0, *)
public class AnalyticsWatchReceiver: NSObject, WCSessionDelegate {

    public static let instance = AnalyticsWatchReceiver()

    private override init() {
        super.init()
    }

    public func session(session: WCSession, didReceiveUserInfo userInfo: [String : AnyObject]) {
        dispatch_async(dispatch_get_main_queue()) {
            if let object = userInfo[WatchAnalyticsKey] as? [String: AnyObject], action = (object[WatchAnalyticsActionKey] as? String).flatMap({ WatchAnalyticAction(rawValue: $0)}) {
                switch action {
                case .TrackPageView:
                    if let screenName = object[WatchAnalyticsScreenNameKey] as? String {
                        if let customDimensions = (object[WatchAnalyticsCustomDimensionsKey] as? [[String: AnyObject]])?.flatMap({ dict -> CustomDimension? in
                            if let index = dict[WatchAnalyticsCustomDimensionsIndexKey] as? Int, value = dict[WatchAnalyticsCustomDimensionsValueKey] as? String {
                                return CustomDimension(index: index, value: value)
                            }
                            return nil
                        }) {
                            analyticsInstance?.trackPageViewAsString(screenName, customDimensions: customDimensions)
                        } else {
                            analyticsInstance?.trackPageViewAsString(screenName)
                        }
                    }
                case .TrackCategory:
                    if let name = object[WatchAnalyticsCategoryNameKey] as? String, action = object[WatchAnalyticsCategoryActionKey] as? String {
                        let label = object[WatchAnalyticsCategoryLabelKey] as? String
                        let value = object[WatchAnalyticsCategoryValueKey] as? NSNumber
                        analyticsInstance?.trackCategory(name, action: action, label: label, value: value)
                    }
                }
            }
        }
    }

    public static func isAnalyticUserInfo(userInfo: [String: AnyObject]) -> Bool {
        return userInfo[WatchAnalyticsKey] as? [String: AnyObject] != nil
    }
}
