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
//struct AppFontName {
//    
//    static let oblique = "Helvetica-Oblique"
//    static let boldOBlique = "Helvetica-BoldOblique"
//    static let halvetica = "Helvetica"
//    static let bold = "Helvetica-Bold"
//    
//    static let light = "helvetica-light"
//    static let roundedBold = "helvetica-rounded-bold"
//    static let compressed = "helvetica-compressed"
//    static let InterRegular = "Inter-Regular"
//    static let InterMedium = "Inter-Medium"
//    static let PoppinsMedium = "Poppins-Medium"
//    static let InterSemiBold = "Inter-SemiBold"
//    
//}
//
//extension UIFontDescriptor.AttributeName {
//    static let nsctFontUIUsage = UIFontDescriptor.AttributeName(rawValue: "NSCTFontUIUsageAttribute")
//}
//
//extension UIFont {
//    static var isOverrided: Bool = false
//
//    @objc class func mySystemFont(ofSize size: CGFloat) -> UIFont {
//        return UIFont(name: AppFontName.halvetica, size: size)!
//    }
//    
//    static var badgeFont: UIFont {
//        return UIFont(name: AppFontName.InterRegular, size: 8)!
//    }
//    
//    static var textFieldFont: UIFont {
//        return UIFont(name: AppFontName.PoppinsMedium, size: 14)!
//    }
//
//    static var buttonFont: UIFont {
//        return UIFont(name: AppFontName.InterSemiBold, size: 16)!
//    }
//    
//    static var primaryButtonFont: UIFont {
//        return UIFont(name: AppFontName.InterSemiBold, size: 14)!
//    }
//    
//    static var secondaryButtonFont: UIFont {
//        return UIFont(name: AppFontName.InterMedium, size: 14)!
//    }
//    
//    @objc class func myMediumSystemFont(ofSize size: CGFloat) -> UIFont {
//        return UIFont(name: AppFontName.oblique, size: size)!
//    }
//
//    @objc class func mySemiBoldSystemFont(ofSize size: CGFloat) -> UIFont {
//        return UIFont(name: AppFontName.bold, size: size)!
//    }
//    
//    @objc class func myLightSystemFont(ofSize size: CGFloat) -> UIFont {
//          return UIFont(name: AppFontName.light, size: size)!
//      }
//    
//
//    @objc convenience init(myCoder aDecoder: NSCoder) {
//        guard
//            let fontDescriptor = aDecoder.decodeObject(forKey: "UIFontDescriptor") as? UIFontDescriptor,
//            let fontAttribute = fontDescriptor.fontAttributes[.nsctFontUIUsage] as? String else {
//                self.init(myCoder: aDecoder)
//                return
//        }
//        var fontName = ""
//        switch fontAttribute {
//        case "CTFontRegularUsage":
//            fontName = AppFontName.halvetica
//        case "CTFontEmphasizedUsage", "CTFontBoldUsage":
//            fontName = AppFontName.bold
//        case "CTFontObliqueUsage":
//            fontName = AppFontName.oblique
//        default:
//            fontName = AppFontName.halvetica
//        }
//        self.init(name: fontName, size: fontDescriptor.pointSize)!
//    }
//
//    class func overrideInitialize() {
//        guard self == UIFont.self, !isOverrided else { return }
//
//        // Avoid method swizzling run twice and revert to original initialize function
//        isOverrided = true
//
//        if let systemFontMethod = class_getClassMethod(self, #selector(systemFont(ofSize:))),
//            let mySystemFontMethod = class_getClassMethod(self, #selector(mySystemFont(ofSize:))) {
//            method_exchangeImplementations(systemFontMethod, mySystemFontMethod)
//        }
//
//        if let boldSystemFontMethod = class_getClassMethod(self, #selector(boldSystemFont(ofSize:))),
//            let myBoldSystemFontMethod = class_getClassMethod(self, #selector(mySemiBoldSystemFont(ofSize:))) {
//            method_exchangeImplementations(boldSystemFontMethod, myBoldSystemFontMethod)
//        }
//
//        if let italicSystemFontMethod = class_getClassMethod(self, #selector(italicSystemFont(ofSize:))),
//            let myItalicSystemFontMethod = class_getClassMethod(self, #selector(myMediumSystemFont(ofSize:))) {
//            method_exchangeImplementations(italicSystemFontMethod, myItalicSystemFontMethod)
//        }
//
//        if let initCoderMethod = class_getInstanceMethod(self, #selector(UIFontDescriptor.init(coder:))), // Trick to get over the lack of UIFont.init(coder:))
//            let myInitCoderMethod = class_getInstanceMethod(self, #selector(UIFont.init(myCoder:))) {
//            method_exchangeImplementations(initCoderMethod, myInitCoderMethod)
//        }
//    }
//}
//
//
//extension AppDelegate{
//    
//    func GetAllFonts(){
//        for family: String in UIFont.familyNames
//        {
//            print(family)
//            for names: String in UIFont.fontNames(forFamilyName: family)
//            {
//                print("== \(names)")
//            }
//        }
//    }
//    
//   
//    
////    override convenience init() {
////         AppDelegate.init()
////         UIFont.overrideInitialize()
////     }
//
//}
