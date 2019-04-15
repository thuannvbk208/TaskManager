//
//  ViewController.swift
//  CustomTabbar
//
//  Created by Thuannv on 4/5/19.
//  Copyright © 2019 Thuannv. All rights reserved.
//

import UIKit
import FAPanels

class RootViewController: TTTabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initViews()
    }
    
    func initViews() {
        tabBar.barTintColor = UIColor(rgb: AppContants.secondaryColor)
        self.didHiFlashHandler = { (viewController, index) in
            self.performSegue(withIdentifier: "Create Task", sender: nil)
        }
    }
}


