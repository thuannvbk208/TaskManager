//
//  BaseViewController.swift
//  CustomTabbar
//
//  Created by Thuannv on 4/6/19.
//  Copyright © 2019 Thuannv. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initViews()
    }
    
    private func initViews() {
        let navbar = self.navigationController?.navigationBar
        navbar?.barTintColor = UIColor(rgb: AppContants.secondaryColor)
        navbar?.tintColor = UIColor(rgb: AppContants.primaryColor)
        let font = UIFont(name: AppContants.fontTitle, size: 24.0)!
        let textAttributes: [NSAttributedString.Key : Any] = [.font:font,
                                                              .foregroundColor:UIColor(rgb: AppContants.primaryColor)]
        navbar?.titleTextAttributes = textAttributes
    }

    @IBAction func showLeftMenu(_ sender: UIBarButtonItem) {
        panel?.openLeft(animated: true)
    }
}
