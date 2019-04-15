//
//  TodayTaskCell.swift
//  CustomTabbar
//
//  Created by Thuannv on 4/5/19.
//  Copyright © 2019 Thuannv. All rights reserved.
//

import UIKit

protocol TodayTaskCellDelegate {
    func didCompletedTask(cell: TodayTaskCell?) -> Void
}

class TodayTaskCell: UITableViewCell {

    @IBOutlet weak var checkBox: UICheckbox!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateTimeTabel: UILabel!
    
    var delegate: TodayTaskCellDelegate?
    
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
