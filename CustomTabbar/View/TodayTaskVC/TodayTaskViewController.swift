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
    var confettiView: TTConfettiView!
    var timer: Timer?
    var timeLeft = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUp()
        self.initConfettiView()
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
    
    private func initConfettiView() {
        confettiView = TTConfettiView(frame: self.view.bounds)
        
        // Set colors (default colors are red, green and blue)
        confettiView.colors = [UIColor(red:0.95, green:0.40, blue:0.27, alpha:1.0),
                               UIColor(red:1.00, green:0.78, blue:0.36, alpha:1.0),
                               UIColor(red:0.48, green:0.78, blue:0.64, alpha:1.0),
                               UIColor(red:0.30, green:0.76, blue:0.85, alpha:1.0),
                               UIColor(red:0.58, green:0.39, blue:0.55, alpha:1.0)]
        
        // Set intensity (from 0 - 1, default intensity is 0.5)
        confettiView.intensity = 0.6
        
        // Set type
        confettiView.type = .confetti
        
        // Add subview
        view.addSubview(confettiView)
        confettiView.isHidden = true
    }
    
    // - MARK: TodayTaskCellDelegate
    func didCompletedTask(cell: TodayTaskCell?) {
        guard let validCell = cell else { return }
        let indexPath = tableView.indexPath(for: validCell)
        if let indexPath = indexPath {
            let completed = validCell.checkBox.isSelected
            viewModel.completedTask(index: indexPath.section, completed: completed)
            if completed {
                confettiView.isHidden = false
                confettiView.startConfetti()
                timeLeft = 2
                timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(onTimerFires), userInfo: nil, repeats: true)
            }
        }
    }
    
    @objc func onTimerFires() {
        timeLeft -= 1
        if timeLeft == 0 {
            timer?.invalidate()
            timer = nil
            confettiView.stopConfetti()
            confettiView.isHidden = true
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

