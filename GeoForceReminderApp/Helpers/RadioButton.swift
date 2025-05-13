//
//  RadioButton.swift
//  ZSportsTellerApp
//
//  Created by MacBook Pro on 15/08/2024.
//

import Foundation
import UIKit

class RadioButton: UIButton {
    
    // Images for selected and unselected states
    let selectedImage = UIImage(named: "radioCheck")
    let unselectedImage = UIImage(named: "radioUncheck")
    
    // Bool property to check the button state
    var isSelectedState: Bool = false {
        didSet {
            updateImage()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    private func setupButton() {
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        updateImage()
    }
    
    @objc private func buttonTapped() {
        isSelectedState.toggle()
    }
    
    private func updateImage() {
        let image = isSelectedState ? selectedImage : unselectedImage
        setImage(image, for: .normal)
    }
}
