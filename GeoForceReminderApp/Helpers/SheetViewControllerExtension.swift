//
//  SheetViewControllerExtension.swift
//  JSZindigi
//
//  Created by Umar Awais on 06/09/2023.
//

import Foundation
import UIKit
import FittedSheets

extension SheetViewController {
    static func getDefaultSheet(viewController: UIViewController, sizes: [SheetSize]) -> SheetViewController {
        let options = SheetOptions(
            shrinkPresentingViewController: false
        )
        let sheetController = SheetViewController(controller: viewController, sizes: sizes, options: options)
        sheetController.gripSize = CGSize.zero
        sheetController.autoAdjustToKeyboard = false
        sheetController.cornerRadius = 16
        sheetController.overlayColor = UIColor(white: 0, alpha: 0.8)
        return sheetController
    }
}
