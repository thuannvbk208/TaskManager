//
//  NewTaskViewController.swift
//  CustomTabbar
//
//  Created by Thuannv on 4/5/19.
//  Copyright © 2019 Thuannv. All rights reserved.
//

import UIKit

class NewTaskViewController: BaseViewController {

    private var picker: DateTimePicker?
    private var newTaskVM = NewTaskViewModel()
    private var formatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a dd/MM/yyyy"
        return dateFormatter
    }()
    
    @IBOutlet weak var dateTextField: TTTextField! {
        didSet {
            dateTextField.addTarget(self, action: #selector(NewTaskViewController.showDatePicker(_:)), for: UIControl.Event.editingDidBegin)
        }
    }
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextField: TTTextField!
    @IBOutlet weak var alarmSwitch: UISwitch!
    @IBOutlet weak var notifySwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    @objc func showDatePicker(_ sender: TTTextField) {
        let min = Date().addingTimeInterval(-60 * 60 * 24 * 4)
        let max = Date().addingTimeInterval(60 * 60 * 24 * 4)
        let picker = self.initDatePicker(min: min, max: max)
        self.picker = picker
    }
    
    private func initDatePicker(min: Date, max: Date) -> DateTimePicker {
        let picker = DateTimePicker.show(selected: Date(), minimumDate: min, maximumDate: max)
        picker.highlightColor = UIColor(red: 255.0/255.0, green: 138.0/255.0, blue: 138.0/255.0, alpha: 1)
        picker.darkColor = UIColor.darkGray
        picker.doneButtonTitle = "Done"
        picker.doneBackgroundColor = UIColor(rgb: AppContants.backgroundColor)
        
        picker.todayButtonTitle = "Today"
        picker.is12HourFormat = true
        picker.dateFormat = "hh:mm a dd/MM/yyyy"
        picker.includeMonth = false
        
        picker.completionHandler = { date in
            self.dateTextField.text = self.formatter.string(from: date)
        }
        return picker
    }
    
    @IBAction func done(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func save(_ sender: UIButton) {
        guard let dateText = self.dateTextField.text,
            let titleText = self.titleTextField.text,
            let descriptionText = self.descriptionTextField.text else { return }
        if !dateText.isEmpty && !titleText.isEmpty && !descriptionText.isEmpty {
            let date = formatter.date(from: dateText)!
            newTaskVM.saveTask(title: titleText, description: descriptionText, date: date, alarm: self.alarmSwitch.isOn, notify: self.notifySwitch.isOn)
        }
    }
}

