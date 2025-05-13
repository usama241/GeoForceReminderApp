//
//  TimePickerViewController.swift
//  ZSportsTellerApp
//
//  Created by MacBook Pro on 01/07/2024.
//

import UIKit

class TimePickerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var timePicker: UIPickerView!
    @IBOutlet weak var timeLabel: UILabel!
    
    var completion: ((String) -> Void)!
    var dismissCompletion: (() -> Void)!
    var selectedTime: String = "00:00"
    
    let hours = Array(0..<24).map { String(format: "%02d", $0) }
    let minutes = Array(0..<60).map { String(format: "%02d", $0) }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set initial selected time if needed
        updateTimeLabel()
        
        timePicker.delegate = self
        timePicker.dataSource = self
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func doneAction(_ sender: Any) {
        DispatchQueue.main.async {
            self.completion(self.selectedTime)
            self.dismissCompletion()
            self.dismiss(animated: true)
        }
    }
    
    // MARK: - UIPickerViewDataSource
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2 // Hours and Minutes
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return hours.count
        } else {
            return minutes.count
        }
    }
    
    // MARK: - UIPickerViewDelegate
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return hours[row] + " hr"
        } else {
            return minutes[row] + " min"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        updateTimeLabel()
    }
    
    // MARK: - Helper methods
    
    func updateTimeLabel() {
        let selectedHour = hours[timePicker.selectedRow(inComponent: 0)]
        let selectedMinute = minutes[timePicker.selectedRow(inComponent: 1)]
        
        selectedTime = "\(selectedHour):\(selectedMinute)"
        timeLabel.text = selectedTime
    }
}
