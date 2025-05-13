//
//  CheckBox.swift
//  JSZindigi
//
//  Created by Shahzaib Khan on 28/08/2023.
//

import Foundation
import UIKit

class CheckBox: UIButton {
    private var _checkedImage = UIImage(named: "checked")
    private var _uncheckedImage = UIImage(named: "unchecked")
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tintColor = .clear
        setImage(_checkedImage, for: .selected)
        setImage(_uncheckedImage, for: .normal)
        addTarget(self, action: #selector(checkboxTapped), for: .touchUpInside)
    }

    @objc private func checkboxTapped() {
        isSelected.toggle()
    }
}
