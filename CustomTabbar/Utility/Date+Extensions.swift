//
//  Date+Extensions.swift
//  CustomTabbar
//
//  Created by Thuannv on 4/9/19.
//  Copyright © 2019 Thuannv. All rights reserved.
//

import Foundation

extension Date {
    func isEqual(to date: Date) -> Bool {
        let result = Calendar.current.compare(self, to: date, toGranularity: .day)
        if result == .orderedSame {
            return true
        }
        return false
    }
    
    var current: Date {
        let calendar = Calendar.current
        var components = calendar.dateComponents([.day, .month, .year], from: self)
        components.timeZone = TimeZone(secondsFromGMT: 0)
        return calendar.date(from: components)!
    }
    
    var next: Date {
        return Date(timeInterval: 24*3600, since: current)
    }
    
    func isEqualTomorrow() -> Bool {
        let today = Date()
        let tomorrow = today.next
        let theDayAfterTomorrow = Date(timeInterval: 24*3600, since: tomorrow)
        return (self >= tomorrow && self < theDayAfterTomorrow)
    }
    
    func isEqualToday() -> Bool {
        let today = Date().current
        let tomorrow = today.next
        return (self >= today && self < tomorrow)
    }
    
    func toString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm EEEE, d MMMM, yyyy"
        return formatter.string(from: self)
    }
    
    func timeToString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        return formatter.string(from: self)
    }
}

