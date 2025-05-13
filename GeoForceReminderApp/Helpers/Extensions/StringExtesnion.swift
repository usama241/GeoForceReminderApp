//
//  RedirectHelper.swift
//  FaizanHelpingCode
//
//  Created by Usama on 2022/5/2.
//

import UIKit

extension String {
//    var isValidEmail: Bool {
//        return NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}").evaluate(with: self)
//    }
    var isValidPassword: Bool {
        let passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[d$@$!%*?&#])[A-Za-z\\dd$@$!%*?&#]{8,}"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: self)
    }
    
    func extractTotalMinutes() -> Int? {
            // Define a regex pattern to extract the time components
            let pattern = "\\d{4}-\\d{2}-\\d{2}T(\\d{2}):(\\d{2}):(\\d{2})"
            
            // Use a regular expression to extract the hours and minutes
            let regex = try? NSRegularExpression(pattern: pattern)
            let range = NSRange(location: 0, length: self.utf16.count)
            
            if let match = regex?.firstMatch(in: self, options: [], range: range) {
                // Extract hours and minutes
                if let hoursRange = Range(match.range(at: 1), in: self),
                   let minutesRange = Range(match.range(at: 2), in: self) {
                    let hours = Int(self[hoursRange]) ?? 0
                    let minutes = Int(self[minutesRange]) ?? 0
                    
                    // Calculate total minutes
                    return hours * 60 + minutes
                }
            }
            
            return nil
        }
    
    /// Checks if the string contains any numeric digit.
      var containsNumber: Bool {
          let numberPattern = ".*[0-9]+.*"
          let numberRegex = try? NSRegularExpression(pattern: numberPattern)
          let range = NSRange(location: 0, length: self.utf16.count)
          
          return numberRegex?.firstMatch(in: self, options: [], range: range) != nil
      }
    
    var isValidName: Bool {
        let nameRegex = "^(?=.*[a-z])(?=.*[A-Z]){8,}"
        return NSPredicate(format: "SELF MATCHES %@", nameRegex).evaluate(with: self)
    }
    func isValidEmail() -> Bool {
        // here, `try!` will always succeed because the pattern is valid
        let emailRegEx = "(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"+"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"+"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"+"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"+"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"+"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"+"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        
        let emailTest = NSPredicate(format:"SELF MATCHES[c] %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    func toCurrencyFormat(locale: Locale = .current) -> String {
        guard let amount = Double(self) else { return self }
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = locale
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        if let formatted = formatter.string(from: NSNumber(value: amount)) {
            return formatted
        }
        return self
    }

}

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}

extension String {
    mutating func addString(str: String) {
        self = self + str
    }
}

//extension String {
//    func strikeThrough(size: CGFloat, color: UIColor) -> NSAttributedString {
//        let regularAttribute = [
//            NSAttributedString.Key.font: UIFont(font: .avenirNextDemiBold, size: size)!,
//            NSAttributedString.Key.foregroundColor: color
//        ]
//        let attributeString =  NSMutableAttributedString(string: " \(self) ")
//        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 1, range: NSMakeRange(0, attributeString.length))
//        attributeString.addAttributes(regularAttribute, range: NSMakeRange(0, attributeString.length))
//        return attributeString
//    }
//}


extension NSAttributedString {

    /// Returns a new instance of NSAttributedString with same contents and attributes with strike through added.
     /// - Parameter style: value for style you wish to assign to the text.
     /// - Returns: a new instance of NSAttributedString with given strike through.
     func withStrikeThrough(_ style: Int = 1) -> NSAttributedString {
         let attributedString = NSMutableAttributedString(attributedString: self)
         attributedString.addAttribute(.strikethroughStyle,
                                       value: style,
                                       range: NSRange(location: 0, length: string.count))
         return NSAttributedString(attributedString: attributedString)
     }
}
extension String {
  
    func split(by length: Int) -> [String] {
        var startIndex = self.startIndex
        var results = [Substring]()
        
        while startIndex < self.endIndex {
            let endIndex = self.index(startIndex, offsetBy: length, limitedBy: self.endIndex) ?? self.endIndex
            results.append(self[startIndex..<endIndex])
            startIndex = endIndex
        }
        
        return results.map({ String($0) })
    }
    
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            let options: [NSAttributedString.DocumentReadingOptionKey : Any] = [
                .documentType: NSAttributedString.DocumentType.html,
                .characterEncoding: String.Encoding.utf8.rawValue
            ]
            let attributedString = try NSMutableAttributedString(data: data, options: options, documentAttributes: nil)
            return attributedString
        } catch {
            return NSAttributedString()
        }
    }
    
    func customHTMLAttributedString(withFont font: UIFont?, textColor: UIColor) -> NSAttributedString? {
        guard let font = font else {
            return self.htmlToAttributedString
        }
        let hexCode = textColor.hexCodeString
        let css = "<style>body{font-family: '\(font.fontName)'; font-size:\(font.pointSize)px; color: \(hexCode);}</style>"
        let modifiedString = css + self
        return modifiedString.htmlToAttributedString
    }
  
}

extension UITextView {
    
    var htmlText: String? {
        set(value) {
            let newValue = value ?? ""
            self.attributedText = newValue.customHTMLAttributedString(withFont: self.font, textColor: self.textColor ?? .black)
        }
        get {
            return self.attributedText.string
        }
    }
    
}

extension UIColor {
    
    var hexCodeString: String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0

        getRed(&r, green: &g, blue: &b, alpha: &a)

        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0

        return String(format:"#%06x", rgb)
    }
    
    
  
}


