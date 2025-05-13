//
//  DatePickerViewController.swift
//  JSZindigi
//
//  Created by Umar Awais on 14/08/2023.
//

import UIKit

class DatePickerViewController: UIViewController {
    
    @IBOutlet weak var datePicker: UIDatePicker!  {
        didSet {
            datePicker.addTarget(self, action: #selector(onDateSelectionChange), for: .valueChanged)
        }
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func doneAction(_ sender: Any) {
        selectedDate = datePicker.date
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.completion(self.selectedDate)
            self.dismissCompletion()
        }
        dismiss(animated: false)
    }
    @IBOutlet weak var dateLabel: UILabel!{
        didSet {
            dateLabel.text = dateFormatter.string(from: selectedDate)
        }
    }
    @IBOutlet weak var yearLabel: UILabel!{
        didSet {
            yearLabel.text = dateFormatter2.string(from: selectedDate)
        }
    }
    private var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, MMM dd"
        return dateFormatter
    }
    private var dateFormatter2: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        return dateFormatter
    }
    var completion: ((Date) -> Void)!
    var dismissCompletion: (() -> Void)!
    var selectedDate = Date()
    var minimumDate: Date?
    var maximumDate: Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePicker.date = selectedDate
        datePicker.minimumDate = minimumDate
        datePicker.maximumDate = maximumDate
    }
    
    @objc func onDateSelectionChange() {
        dateLabel.text = dateFormatter.string(from: datePicker.date)
        yearLabel.text = dateFormatter2.string(from: datePicker.date)
        
    }
    
}
