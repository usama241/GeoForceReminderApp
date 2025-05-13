//
//  UISegmentedControlExtension.swift
//  JSZindigi
//
//  Created by Anis Ur Rehman on 02/08/2023.
//

import Foundation
import UIKit

extension UISegmentedControl
{
    open override func awakeFromNib() {
        super.awakeFromNib()
     //   addTarget(self, action: #selector(setSegments), for: .valueChanged)
    }
    
    func setOldLayout(tintColor: UIColor, backgroundColor: UIColor, borderColor: UIColor, separatorColor: UIColor = UIColor.clear)
    {
        if #available(iOS 13, *)
        {
            let bg = UIImage(color: backgroundColor, size: CGSize(width: 1, height: 32))
             let devider = UIImage(color: tintColor, size: CGSize(width: 1, height: 32))

             //set background images
             self.setBackgroundImage(bg, for: .normal, barMetrics: .default)
             self.setBackgroundImage(devider, for: .selected, barMetrics: .default)

             // Remove divider using same background color
            let separatorImage = UIImage(color: backgroundColor, size: CGSize(width: 1, height: 15))
            
            self.setDividerImage(separatorImage, forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)

             //set border
            self.layer.borderWidth = 1
            self.layer.borderColor = borderColor.cgColor
            
            self.layer.cornerRadius = 8

             //set label color
            self.setTitleTextAttributes([.foregroundColor: UIColor.black, .font: UIFont.buttonFontSize], for: .normal)
            self.setTitleTextAttributes([.foregroundColor: UIColor.white, .font: UIFont.labelFontSize], for: .selected)
        }
        else
        {
            self.tintColor = tintColor
        }
    }
}
