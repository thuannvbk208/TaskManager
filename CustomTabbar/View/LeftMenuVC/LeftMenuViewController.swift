//
//  LeftMenuViewController.swift
//  CustomTabbar
//
//  Created by Thuannv on 4/6/19.
//  Copyright © 2019 Thuannv. All rights reserved.
//

import UIKit

class LeftMenuViewController: UIViewController {

    private var contents = ["To-do", "Scheduler", "Notifications", "Profile", "Logout"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

extension LeftMenuViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TitleCell", for: indexPath)
        cell.textLabel?.text = contents[indexPath.row]
        return cell
    }
}

extension LeftMenuViewController: UITableViewDelegate {
    //change center panel
    private func changeCenterPanel(_ title: String) {
        let centerVC = panel?.center as! RootViewController
        switch title {
        case "To-do":
             centerVC.selectedIndex = 0
        case "Scheduler":
            centerVC.selectedIndex = 1
        case "Notifications":
            centerVC.selectedIndex = 3
        case "Profile":
            centerVC.selectedIndex = 4
        case "Logout": print("Logout Account")
        default:
            print("not instantiateViewController")
        }
        panel?.closeLeft()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let title = contents[indexPath.row]
        changeCenterPanel(title)
    }
}
