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
    @objc dynamic var descriptionTask = ""
    @objc dynamic var isCompleted = false
    @objc dynamic var date = Date()
    @objc dynamic var isAlarm = true
    @objc dynamic var isNotify = true
    
    convenience init(title: String, isCompleted: Bool, date: Date, isAlarmed: Bool, isNotify: Bool, description: String) {
        self.init()
        self.title = title
        self.descriptionTask = description
        self.isCompleted = isCompleted
        self.date = date
        self.isAlarm = isAlarmed
        self.isNotify = isNotify
    }
}
