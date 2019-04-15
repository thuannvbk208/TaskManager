//
//  Task.swift
//  CustomTabbar
//
//  Created by Thuannv on 4/9/19.
//  Copyright © 2019 Thuannv. All rights reserved.
//

import Foundation
import RealmSwift

class Task: Object {
    @objc dynamic var title = ""
    @objc dynamic var isCompleted = false
    @objc dynamic var date = Date()
    @objc dynamic var isAlarmed = true
    @objc dynamic var isNotify = true
    @objc dynamic var priority = 0
    
    convenience init(title: String, isCompleted: Bool, date: Date, isAlarmed: Bool, isNotify: Bool, priority: Int) {
        self.init()
        self.title = title
        self.isCompleted = isCompleted
        self.date = date
        self.isAlarmed = isAlarmed
        self.isNotify = isNotify
        self.priority = priority
    }
}
