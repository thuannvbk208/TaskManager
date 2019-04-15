//
//  UpcomingTaskViewController.swift
//  CustomTabbar
//
//  Created by Thuannv on 4/5/19.
//  Copyright © 2019 Thuannv. All rights reserved.
//

import UIKit

class SchedulerViewController: BaseViewController {

    private var viewModel = UpcomingTaskViewModel()
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.backgroundColor = .white
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setUp()
    }
    
    private func setUp() {
        viewModel.onDatabaseChanged = { (change, index) in
//            switch change {
//            case .insert:
//                self.tableView.beginUpdates()
//                self.tableView.insertSections(IndexSet(integer: index), with: .automatic)
//                self.tableView.endUpdates()
//            case .delete:
//                self.tableView.deleteSections(IndexSet(integer: index), with: .automatic)
//            case .modify:
//                self.tableView.beginUpdates()
//                self.tableView.reloadSections(IndexSet(integer: index), with: .automatic)
//                self.tableView.endUpdates()
//            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

extension SchedulerViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.getNumberSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberRowOfSections(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UpcomingTaskCell", for: indexPath) as! UpcomingTaskCell
        let task = viewModel.getTaskFromSectionIndex(section: indexPath.section, row: indexPath.row)
        cell.configureView(title: task.title, date: task.date.timeToString(),completed: task.isCompleted)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 48.0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20.0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UILabel()
        view.backgroundColor = .white
        view.textColor = UIColor(rgb: 0x243B6B)
        view.font = UIFont(name: "Avenir", size: 14.0)
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE, MMMM d, yyyy"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        let task = viewModel.getTaskFromSectionIndex(section: section, row: 0)
        view.text = task.date.isEqualTomorrow() ? "Tomorrow" : formatter.string(from: task.date)
        return view
    }
}

extension SchedulerViewController: UITableViewDelegate {
    
}
