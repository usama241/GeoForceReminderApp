//
//  RedirectHelper.swift
//  FaizanHelpingCode
//
//  Created by Usama on 2022/5/2.
//

//import Foundation
//
//import UIKit
//
//class RadioButtonController: NSObject {
//    var buttonsArray: [UIButton]! {
//        didSet {
//            for b in buttonsArray {
//                b.setBackgroundImage(UIImage(named: "uncheck"), for: .normal)
//                b.setBackgroundImage(UIImage(named: "check"), for: .selected)
//            
//            }
//        }
//    }
//    var selectedButton: UIButton?
//    var defaultButton: UIButton = UIButton() {
//        didSet {
//            buttonArrayUpdated(buttonSelected: self.defaultButton)
//        }
//    }
//
//    func buttonArrayUpdated(buttonSelected: UIButton) {
//        for b in buttonsArray {
//            if b == buttonSelected {
//                selectedButton = b
//                b.isSelected = true
//            } else {
//                b.isSelected = false
//            }
//        }
//    }
//}
