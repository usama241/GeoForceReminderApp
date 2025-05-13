//
//  RedirectHelper.swift

//
//  Created by Usama on 2022/5/2.
//

import UIKit

extension UILabel {
    func set(html: String) {
        if let htmlData = html.data(using: .unicode) {
            do {
                self.attributedText = try NSAttributedString(data: htmlData,
                                                             options: [.documentType: NSAttributedString.DocumentType.html],
                                                             documentAttributes: nil)
            } catch let e as NSError {
                print("Couldn't parse \(html): \(e.localizedDescription)")
            }
        }
        
    }
    
    
}

 
 
