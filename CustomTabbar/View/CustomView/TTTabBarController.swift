//
//  TTTabBarController.swift
//  CustomTabbar
//
//  Created by Thuannv on 4/5/19.
//  Copyright © 2019 Thuannv. All rights reserved.
//

import UIKit

public typealias TTTabBarControllerDidHandler = ((_ viewController: UIViewController, _ index: Int) -> Void)

@IBDesignable
class TTTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    @IBInspectable var colorUnderline: UIColor = .blue
    @IBInspectable var widthUnderline: CGFloat = 0
    
    var didHiFlashHandler: TTTabBarControllerDidHandler?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setUp()
    }
    
    private func setUp() {
        self.delegate = self
        if self.widthUnderline > 0 {
            tabBar.selectionIndicatorImage = UIImage().createSelectionIndicator(color: colorUnderline, size: CGSize(width: tabBar.frame.width/CGFloat(tabBar.items!.count), height: tabBar.frame.height), lineWidth: widthUnderline)
        }
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let viewControllers = tabBarController.viewControllers!
        let index = viewControllers.firstIndex(of: viewController)!
        if index == tabBar.items!.count / 2 {
            didHiFlashHandler?(viewController, index)
            return false
        }
        return true
    }

}
