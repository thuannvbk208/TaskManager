//
//  UpcomingTaskCell.swift
//  CustomTabbar
//
//  Created by Thuannv on 4/11/19.
//  Copyright © 2019 Thuannv. All rights reserved.
//

import UIKit

protocol SchudulerTaskCellDelegate {
    func didCompletedTask(cell: UpcomingTaskCell?) -> Void
}

class UpcomingTaskCell: UITableViewCell {

    @IBOutlet weak var checkBox: UICheckbox!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateTimeTabel: UILabel!
    
    var delegate: SchudulerTaskCellDelegate?
    
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

    internal func configureView(title: String, date: String, completed: Bool) {
        titleLabel.text = title
        checkBox.isSelected = completed
        dateTimeTabel.text = date
    }
    
    @IBAction func completedTask(_ sender: UICheckbox) {
        self.delegate?.didCompletedTask(cell: self)
    }
}
