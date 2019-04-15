//
//  StorageManager.swift
//  CustomTabbar
//
//  Created by Thuannv on 4/9/19.
//  Copyright © 2019 Thuannv. All rights reserved.
//

import Foundation
import Realm
import RealmSwift
import EventKit

class StorageManager {
    static let shared = StorageManager()
    private let realm = try! Realm()
    private let remiderNotification = ReminderNotification.shared
    
    internal func insert(task: Task) {
        do {
            try realm.write {
                realm.add(task)
            }

            //shedule notification
            let timeInterval = task.date.timeIntervalSinceNow
            if timeInterval > 0 {
                remiderNotification.createSchedulerNotification(title: task.title, timeInterval: timeInterval) { (success) in
                    if success {
                        print("Add notifiaction success")
                    } else {
                        print("Add notification fail")
                    }
                }
            }
        } catch let error as NSError {
            print(error)
        }
    }
    
    internal func fetchAllData() -> Results<Task> {
        let tasks = realm.objects(Task.self).sorted(byKeyPath: "date", ascending: false)
        return tasks
    }
    
    internal func fetch(predicate: NSPredicate) -> Results<Task> {
        let tasks = realm.objects(Task.self).filter(predicate).sorted(byKeyPath: "date", ascending: true)
        return tasks
    }

    internal func deleteAll() {
        realm.deleteAll()
    }
    
    internal func delete(task: Task) {
        realm.delete(task)
    }
}

extension Results {
    func toArray<T>(type: T.Type) -> [T] {
        return compactMap { $0 as? T }
    }
}
