//
//  TitleCell.swift
//  CustomTabbar
//
//  Created by Thuannv on 4/7/19.
//  Copyright © 2019 Thuannv. All rights reserved.
//

import UIKit

class TitleCell: UITableViewCell {

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

}
