//
//  TodayTaskViewController.swift
//  CustomTabbar
//
//  Created by Thuannv on 4/5/19.
//  Copyright © 2019 Thuannv. All rights reserved.
//

import UIKit

class TodayTaskViewController: BaseViewController, TodayTaskCellDelegate {
   

    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel = TodayTaskViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUp()
    }

    private func setUp() {
        viewModel.onDatabaseChanged = { (change, index) in
            switch change {
            case .insert:
                self.tableView.beginUpdates()
                self.tableView.insertSections(IndexSet(integer: index), with: .automatic)
                self.tableView.endUpdates()
            case .delete:
                self.tableView.deleteSections(IndexSet(integer: index), with: .automatic)
            case .modify:
                self.tableView.beginUpdates()
                self.tableView.reloadSections(IndexSet(integer: index), with: .automatic)
                self.tableView.endUpdates()
            }
        }
    }
    
    // - MARK: TodayTaskCellDelegate
    func didCompletedTask(cell: TodayTaskCell?) {
        guard let validCell = cell else { return }
        let indexPath = tableView.indexPath(for: validCell)
        if let indexPath = indexPath {
            let completed = validCell.checkBox.isSelected
            viewModel.completedTask(index: indexPath.section, completed: completed)
        }
    }
    
}

extension TodayTaskViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.getTasksCount()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodayTaskCell", for: indexPath) as! TodayTaskCell
        cell.delegate = self
        let task = viewModel.getTaskByIndex(index: indexPath.section)
        cell.configureView(title: task.title, date: task.date.toString(),completed: task.isCompleted)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 48.0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }
        return 10.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }
}

extension TodayTaskViewController: UITableViewDelegate {
    
}

