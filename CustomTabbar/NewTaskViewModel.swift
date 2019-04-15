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
    
    internal func saveTask(title: String, date: Date) {
        let task = Task()
        task.title = title
        task.date = date
        storage.insert(task: task)
    }
    
}
