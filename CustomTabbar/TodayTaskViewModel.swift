//
//  TodayViewModel.swift
//  CustomTabbar
//
//  Created by Thuannv on 4/9/19.
//  Copyright © 2019 Thuannv. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

typealias CompletionHandler = ((_ change: DatabaseChange,_ index: Int) -> Void)

class TodayTaskViewModel {
    
    var onDatabaseChanged: CompletionHandler?
    private var notificationToken: NotificationToken? = nil
    private var todayTaskResults: Results<Task>?
    private var tasks: [Task]
    
    func getTaskByIndex(index: Int) -> Task {
        return tasks[index]
    }
    
    func getTasksCount() -> Int {
        return tasks.count
    }
    
    func completedTask(index: Int, completed: Bool) {
        let task = getTaskByIndex(index: index)
        StorageManager.shared.modify(task: task, completed: completed)
    }
    
    init() {
        let date = Date()
        let predicate = NSPredicate(format: "date >= %@ && date < %@", date.current as NSDate, date.next as NSDate)
        todayTaskResults = StorageManager.shared.fetch(predicate: predicate)
        tasks = todayTaskResults?.toArray(type: Task.self) ?? [Task]()
        notificationToken = todayTaskResults?.observe({ [weak self] change in
            switch change {
            case .initial:
                 print("initial today")
            case .update(_,let deletions, let insertions, let modifications):
                if deletions.count > 0 {
                    let index = deletions.first!
                    let _ = self?.tasks.remove(at: index)
                    self?.onDatabaseChanged?(.delete, index)
                }
                if insertions.count > 0 {
                    let index = insertions.first!
                    let task = self!.todayTaskResults![index]
                    self?.tasks.insert(task, at: index)
                    self?.onDatabaseChanged?(.insert, insertions.first!)
                }
                if modifications.count > 0 {
                    self?.onDatabaseChanged?(.modify, modifications.first!)
                }
            case .error(let error):
                fatalError("\(error)")
            }

        })
    }
    
    deinit {
        notificationToken?.invalidate()
    }
}
