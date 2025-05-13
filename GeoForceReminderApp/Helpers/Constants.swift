//
//  Constants.swift
//
//  Created by Usama  on 2022/6/24.
//

import Foundation
import UIKit
//
var SHOULD_GOTO_SIGNIN: Bool = false
var CURRENCY = "AED"
var CART_COUNT = 0

class Constants {
    
    // MARK: - Constant variables
    
    static let googleApiKey = "AIzaSyBDj-8NdQYiPol3ZNRl7EUdipFyMbq4VSI"
    static let googleSignInClientID = "166391383017-6f2jaqp6nr2i59hal5ugfbv11i4t8m8j.apps.googleusercontent.com"
    static let rsaPublicKey: String = "9213eccd434c9bed8848485fefc80d49" 
    static let bookmePublicKey: String = "BookMePublicKey"
    static let bookMeBaseURL = "https://bookme.pk/widgets?data="
    
    struct Static {
        static var screenWidth: CGFloat = UIScreen.main.bounds.width
        
    }
    
    open class func getDeviceId() -> String? {
        return UIDevice.current.identifierForVendor?.uuidString
    }

    open class func setFCMToken(token: String) {
        UserDefaults.standard.setValue(token, forKey: "FCM_Token")
        UserDefaults.standard.synchronize()
    }
    
    open class func getFCMToken() -> String? {
        guard let fcmToken = UserDefaults.standard.value(forKey: "FCM_Token") as? String else {
            return "abc"
        }
        return fcmToken
    }
    
    
}
