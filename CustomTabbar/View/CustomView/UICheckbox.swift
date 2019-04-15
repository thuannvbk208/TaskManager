//
//  UICheckbox.swift
//  CustomTabbar
//
//  Created by Thuannv on 4/5/19.
//  Copyright © 2019 Thuannv. All rights reserved.
//

import UIKit

@IBDesignable
class UICheckbox: UIButton {
    
    @IBInspectable var checkImage: UIImage? {
        didSet {
            setCheckboxImage()
        }
    }
    
    @IBInspectable var noneCheckImage: UIImage? {
        didSet {
            setCheckboxImage()
        }
    }
    
    var onSelectStateChanged: ((_ checkbox: UICheckbox, _ selected: Bool) -> Void)?
    
    override var isSelected: Bool {
        didSet {
            super.isSelected = isSelected
            setCheckboxImage()
            onSelectStateChanged?(self, isSelected)
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initDefaultParams()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        initDefaultParams()
    }
    
    override open func prepareForInterfaceBuilder() {
        setTitle("", for: UIControl.State())
        setCheckboxImage()
    }
}

extension UICheckbox {
    fileprivate func initDefaultParams() {
        addTarget(self, action: #selector(UICheckbox.checkboxTapped), for: .touchUpInside)
        setTitle(nil, for: UIControl.State())
        setCheckboxImage()
    }
    
    private func setCheckboxImage() {
        setImage(isSelected ? checkImage : noneCheckImage, for: .normal)
    }
    
    @objc fileprivate func checkboxTapped(_ sender: UICheckbox) {
        isSelected = !isSelected
    }
}
