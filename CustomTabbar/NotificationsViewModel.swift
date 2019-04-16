//
//  NotificationsViewModel.swift
//  CustomTabbar
//
//  Created by Thuannv on 4/13/19.
//  Copyright © 2019 Thuannv. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

class NotificationViewModel {
    
    var onDatabaseChanged: ((_ change: DatabaseChange,_ index: Int) -> Void)?
    private var notificationToken: NotificationToken? = nil
    private var notificationTaskResults: Results<Task>?
    private var tasks: [Task]
    private var notifyDictionary: [String: [Task]] = [:]
    private var sections: [String] = [String]()
    let dateFormatter: DateFormatter = DateFormatter()
    
    
    func parseDate() {
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        dateFormatter.dateFormat = "EEE, MMMM d, yyyy"
        notifyDictionary = Dictionary(grouping: tasks, by: { dateFormatter.string(from: $0.date) })
        sections = Array(notifyDictionary.keys).sorted(){ $0.toDate() < $1.toDate() }
    }
    
    func getNumberSections() -> Int {
        return sections.count
    }
    
    func getNumberRowOfSections(section: Int) -> Int {
        let key = sections[section]
        return notifyDictionary[key]!.count
    }
    
    func getTaskFromSectionIndex(section: Int, row: Int) -> Task {
        let key = sections[section]
        let array = notifyDictionary[key]!
        return array[row]
    }
    
    init() {
        let date = Date()
        let predicate = NSPredicate(format: "date >= %@ && isNotify == true", date.current as NSDate)
        notificationTaskResults = StorageManager.shared.fetch(predicate: predicate)
        tasks = notificationTaskResults?.toArray(type: Task.self) ?? [Task]()
        parseDate()
        notificationToken = notificationTaskResults?.observe({ [weak self] change in
            switch change {
            case .initial:
                print("initial notifications")
            case .update(_,let deletions, let insertions, let modifications):
                if deletions.count > 0 {
                    let index = deletions.first!
                    let _ = self?.tasks.remove(at: index)
                    self?.onDatabaseChanged?(.delete, index)
                }
                if insertions.count > 0 {
                    let index = insertions.first!
                    let task = self!.notificationTaskResults![index]
                    self?.tasks.insert(task, at: index)
                    self?.onDatabaseChanged?(.insert, insertions.first!)
                }
                if modifications.count > 0 {
                    self?.onDatabaseChanged?(.modify, modifications.first!)
                }
            case .error(let error):
                fatalError("\(error)")
            }
            self?.parseDate()
        })
    }
    
    deinit {
        notificationToken?.invalidate()
    }
}

