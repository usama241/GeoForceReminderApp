//
//  CustomPickerPanelViewController.swift
//  My Ahmed
//
//  Created by Apple on 9/18/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class CustomPickerPanelViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var titleLabel: UILabel!
    
    weak var delegate: CustomPickerPanelDelegate?
    
    var items: [PickerItem] = [] {
        didSet {
            if isViewLoaded {
                self.pickerView.reloadAllComponents()
            }
        }
    }
    var items2: [PickerItem] = []
    private var items1Used: [PickerItem] {
        get {
            if !isViewLoaded,
               self.pickerView.numberOfComponents == 0 {
                return items
            }
            if isDateMonth && self.pickerView.numberOfComponents > 1 {
                let selectedRow2 = self.pickerView.selectedRow(inComponent: 1)
                let month = (self.items2[selectedRow2].value as? Month) ?? .jan
                return month.days.map({ PickerItem(name: "\($0)") })
            } else {
                return items
            }
        }
    }
    
    var have2Items: Bool = false
    var isDateMonth: Bool = false
    var pageTitle: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.roundTopCorners(radius: 25)
        pickerView.dataSource = self
        pickerView.delegate = self
        titleLabel.text = pageTitle
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return have2Items ? 2:1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return items1Used.count
        } else {
            return items2.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 35
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        var text = ""
        if component == 0 {
            if row < items1Used.count {
                text = items1Used[row].name
            } else {
                text = items1Used[items1Used.count - 1].name
            }
        } else {
            text = items2[row].name
        }
        
        let width = (Constants.Static.screenWidth - 64) / (self.have2Items ? 2:1)
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: 35))
        label.font = .systemFont(ofSize: 20)
        label.text = text
        if have2Items {
            label.textAlignment = (component == 0) ? .right:.left
        } else {
            label.textAlignment = .center
        }
        
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if  isDateMonth,
            component == 1 {
            self.pickerView.reloadComponent(0)
        }
    }
    
    // MARK: - Actions
    
    @IBAction func onDonePressed(_ sender: Any) {
        if have2Items {
            if self.pickerView.numberOfComponents > 1 {
                let item1 = self.items1Used[self.pickerView.selectedRow(inComponent: 0)]
                let item2 = self.items2[self.pickerView.selectedRow(inComponent: 1)]
                delegate?.CustomPickerPanelSelected?(item1: item1, item2: item2)
            }
        } else {
            delegate?.CustomPickerPanelSelected?(item: self.items1Used[self.pickerView.selectedRow(inComponent: 0)])
        }
    }
}

// MARK: - Protocol

@objc protocol CustomPickerPanelDelegate: AnyObject {
    @objc optional func CustomPickerPanelSelected(item: PickerItem)
    @objc optional func CustomPickerPanelSelected(item1: PickerItem, item2: PickerItem)
}

// MARK: - Struct

@objc class PickerItem: NSObject {
    var name: String!
    var value: Any?
    
    init(name: String) {
        self.name = name
        self.value = nil
    }
    
    init(name: String, value: Any?) {
        self.name = name
        self.value = value
    }
}


enum Month: Int {
    case jan = 1
    case feb = 2
    case mar = 3
    case apr = 4
    case may = 5
    case jun = 6
    case jul = 7
    case aug = 8
    case sep = 9
    case oct = 10
    case nov = 11
    case dec = 12
    
    var title: String {
        switch self {
        case .jan:
            return "January"
        case .feb:
            return "February"
        case .mar:
            return "March"
        case .apr:
            return "April"
        case .may:
            return "May"
        case .jun:
            return "June"
        case .jul:
            return "July"
        case .aug:
            return "August"
        case .sep:
            return "September"
        case .oct:
            return "October"
        case .nov:
            return "November"
        case .dec:
            return "December"
        }
    }
    var days: [Int] {
        switch self {
        case .jan, .mar, .may, .jul, .aug, .oct, .dec:
            return Array(1...31)
        case .apr, .jun, .sep, .nov:
            return Array(1...30)
        case .feb:
            return Array(1...29)
        }
    }
}


extension UIView {
    
func roundTopCorners(radius: CGFloat) {
    self.layer.cornerRadius = radius
    self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
}

}
