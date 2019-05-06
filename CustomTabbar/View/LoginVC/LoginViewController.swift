//
//  LoginViewController.swift
//  CustomTabbar
//
//  Created by Thuannv on 5/6/19.
//  Copyright © 2019 Thuannv. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func login(_ sender: UIButton) {
        self.openRootViewController()
    }
    
    private func openRootViewController() {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let centerVC = mainStoryboard.instantiateViewController(withIdentifier: "CenterVC") as! RootViewController
        panel?.configs.centerPanelTransitionType = .crossDissolve
        let _ = panel!.center(centerVC)
    }
}
