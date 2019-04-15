//
//  NotificationCell.swift
//  CustomTabbar
//
//  Created by Thuannv on 4/13/19.
//  Copyright © 2019 Thuannv. All rights reserved.
//

import UIKit

class NotificationCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateTimeTabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
        let bgColorView = UIView()
        bgColorView.backgroundColor = selected ? UIColor(rgb: AppContants.backgroundColor):.white
        selectedBackgroundView = bgColorView
    }
    
    internal func configureView(title: String, date: String) {
        titleLabel.text = title
        dateTimeTabel.text = date
    }
}
