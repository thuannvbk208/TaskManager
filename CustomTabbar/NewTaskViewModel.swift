//
//  NewTaskViewModel.swift
//  CustomTabbar
//
//  Created by Thuannv on 4/9/19.
//  Copyright © 2019 Thuannv. All rights reserved.
//

import Foundation

class NewTaskViewModel {
    let storage = StorageManager.shared
    
    internal func saveTask(title: String, description: String, date: Date, alarm: Bool, notify: Bool) {
        let task = Task(title: title, isCompleted: false, date: date, isAlarmed: alarm, isNotify: notify, description: description)
        storage.insert(task: task)
    }
    
}
