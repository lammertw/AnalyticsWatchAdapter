//
//  Analytics.swift
//  NS International
//
//  Created by Lammert Westerhoff on 04/09/15.
//  Copyright © 2015 NS International. All rights reserved.
//

import UIKit

public struct CustomDimension {
    public let index: Int
    public let value: String

    public init(index: Int, value: String) {
        self.index = index
        self.value = value
    }
}

public protocol Analytics {

    func trackPageViewAsString(screenName: String)
    func trackPageViewAsString(screenName: String, customDimensions: [CustomDimension])

    func trackCategory(category: String, action: String)
    func trackCategory(category: String, action: String, label: String?, value: NSNumber?)
}

public extension Analytics {
    
    public func trackTimingWithCategory(category: String, starting startTime: NSDate) {

    }

    public func trackTimingWithCategory(category: String, starting startTime: NSDate, withName name: String?, withLabel label: String?) {

    }
}

public var analyticsInstance: Analytics?

public extension String {

    public func trackPageView() {
        analyticsInstance?.trackPageViewAsString(self)
    }
}
