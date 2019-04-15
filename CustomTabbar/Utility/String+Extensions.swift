//
//  String+Extensions.swift
//  CustomTabbar
//
//  Created by Thuannv on 4/12/19.
//  Copyright © 2019 Thuannv. All rights reserved.
//

import Foundation

extension String {
    func toDate() -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE, MMMM d, yyyy"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter.date(from: self)!
    }
}
