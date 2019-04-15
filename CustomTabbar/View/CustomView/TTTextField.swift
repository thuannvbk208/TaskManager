//
//  TTTextField.swift
//  CustomTabbar
//
//  Created by Thuannv on 4/5/19.
//  Copyright © 2019 Thuannv. All rights reserved.
//

import UIKit

class TTTextField: UITextField {

    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        let path = UIBezierPath(roundedRect: rect, cornerRadius: 8.0)
        path.lineWidth = 2.0
        path.addClip()
        UIColor(rgb: 0x243B6B, a: 0.3).setStroke()
        path.stroke()
    }
    
    public var textInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10) {
        didSet { setNeedsDisplay() }
    }
    
    open override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textInsets)
    }
    
    open override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textInsets)
    }
    
    open override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textInsets)
    }
    
    open override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: textInsets))
    }
    
}
