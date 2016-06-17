//
//  AnalyticsWatchConstants.swift
//  NSInternational
//
//  Created by Lammert Westerhoff on 16/06/16.
//  Copyright © 2016 NS International. All rights reserved.
//

import Foundation

let WatchAnalyticsKey = "WatchAnalytics"
let WatchAnalyticsActionKey = "action"

let WatchAnalyticsScreenNameKey = "screenName"
let WatchAnalyticsCustomDimensionsKey = "customDimensions"

let WatchAnalyticsCustomDimensionsIndexKey = "index"
let WatchAnalyticsCustomDimensionsValueKey = "value"

let WatchAnalyticsCategoryNameKey = "category"
let WatchAnalyticsCategoryActionKey = "categoryAction"
let WatchAnalyticsCategoryLabelKey = "label"
let WatchAnalyticsCategoryValueKey = "value"

public enum WatchAnalyticAction: String {
    case TrackPageView
    case TrackCategory
}
