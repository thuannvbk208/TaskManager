//
//  UpcomingTaskViewModel.swift
//  CustomTabbar
//
//  Created by Thuannv on 4/11/19.
//  Copyright © 2019 Thuannv. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

class UpcomingTaskViewModel {
    
    var onDatabaseChanged: CompletionHandler?
    private var notificationToken: NotificationToken? = nil
    private var upcomingTaskResults: Results<Task>?
    private var tasks: [Task]
    private var upcomes: [String: [Task]] = [:]
    private var sections: [String] = [String]()
    let dateFormatter: DateFormatter = DateFormatter()
    
    
    func parseDate() {
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        dateFormatter.dateFormat = "EEE, MMMM d, yyyy"
        upcomes = Dictionary(grouping: tasks, by: { dateFormatter.string(from: $0.date) })
        sections = Array(upcomes.keys).sorted(){ $0.toDate() < $1.toDate() }
    }
    
    func getNumberSections() -> Int {
        return sections.count
    }
    
    func getNumberRowOfSections(section: Int) -> Int {
        let key = sections[section]
        return upcomes[key]!.count
    }
    
    func getTaskFromSectionIndex(section: Int, row: Int) -> Task {
        let key = sections[section]
        let array = upcomes[key]!
        return array[row]
    }
    
    init() {
        let date = Date()
        let predicate = NSPredicate(format: "date >= %@", date.next as NSDate)
        upcomingTaskResults = StorageManager.shared.fetch(predicate: predicate)
        tasks = upcomingTaskResults?.toArray(type: Task.self) ?? [Task]()
        parseDate()
        notificationToken = upcomingTaskResults?.observe({ [weak self] change in
            switch change {
            case .initial:
                print("initial scheduler")
            case .update(_,let deletions, let insertions, let modifications):
                if deletions.count > 0 {
                    let index = deletions.first!
                    let _ = self?.tasks.remove(at: index)
                    self?.onDatabaseChanged?(.delete, index)
                }
                if insertions.count > 0 {
                    let index = insertions.first!
                    let task = self!.upcomingTaskResults![index]
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
