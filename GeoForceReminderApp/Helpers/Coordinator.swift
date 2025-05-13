//
//  Coordinator.swift
//  TemployMe
//
//  Created by A2 MacBook Pro 2012 on 04/12/21.
//

import UIKit
import FittedSheets
import XLPagerTabStrip

struct Coordinator {
    
    static func gotoBack(delegate: UIViewController?) {
        if let _ = delegate?.navigationController {
            delegate?.navigationController?.popViewController(animated: true)
        }else {
            delegate?.dismiss(animated: true)
        }
    }
    
//    static func gotoVirtualCard(delegate: UIViewController?) {
//        if let _ = delegate?.navigationController {
//            delegate?.navigationController?.popViewController(animated: false)
//        }else {
//            delegate?.dismiss(animated: false)
//        }
//    }
//    
//    static func mainMenuViewController(controller: UIViewController?) {
//        let  VC = Storyboard.Main.instantiate(identifier: MainMenuViewController.self)
//        controller?.navigationController?.pushViewController(VC, animated: false)
//    }
//    
//    static func myProfileViewController(controller: UIViewController?) {
//        let  VC = Storyboard.Main.instantiate(identifier: MyProfileViewController.self)
//        controller?.navigationController?.pushViewController(VC, animated: false)
//    }
//    
//    static func gotOTPScreen(mobileNumber: String, pinCode: String, expDate: String) -> OTPViewController {
//        let VC = Storyboard.Main.instantiate(identifier: OTPViewController.self)
//        VC.mobileNumber = mobileNumber
//        VC.pinCode = pinCode
//        VC.expDate = expDate
//        return VC
//    }
//
//    static func virtualCardViewController(controller: UIViewController?) {
//        let viewController = Storyboard.Main.instantiate(identifier: VirtualCardVC.self)
//        controller?.navigationController?.pushViewController(viewController, animated: false)
//    }
//
//    static func virtualCardHistoryController(controller: UIViewController?) {
//        let viewController = Storyboard.Main.instantiate(identifier: VirtualCardHistoryVC.self)
//        controller?.navigationController?.pushViewController(viewController, animated: false)
//    }
//    
//    static func gatesViewController(title: String?, gates: [GatesBody], placeholder: String = "Select Gate") -> GatesViewController {
//        let VC = Storyboard.Main.instantiate(identifier: GatesViewController.self)
//        VC.titleText = title
//        VC.gates = gates
//        VC.placeholderText = placeholder
//        
//        return VC
//    }
    
}


