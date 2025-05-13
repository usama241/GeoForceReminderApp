//
//  RedirectHelper.swift
//  FaizanHelpingCode
//
//  Created by Usama  on 2022/5/2.
//

import Foundation
import UIKit

enum UserSessionEnum : String {
    case userSessionData
    case deviceToken
    case userProfile
}

extension UserDefaults{
    //MARK: Save User Data

    func setMobileNumber(mobileNumber: String) {
        set(mobileNumber, forKey: "MobileNumber")
    }
    
    func getMobileNumber() -> String? {
        return UserDefaults.standard.string(forKey: "MobileNumber")
    }
    
    func setPreviousMobileNumber(mobileNumber: String) {
        set(mobileNumber, forKey: "PreviousMobileNumber")
    }
    
    func getPreviousMobileNumber() -> String? {
        return UserDefaults.standard.string(forKey: "PreviousMobileNumber")
    }
    
    func setUserSession(value: Data) {
        set(value, forKey: UserSessionEnum.userSessionData.rawValue)
    }
    
    //MARK: Retrieve User Data
    func getUserSession() -> Data? {
        return UserDefaults.standard.value(forKey: UserSessionEnum.userSessionData.rawValue) as? Data
    }
    
    func removeUserSession() {
        self.removeObject(forKey: UserSessionEnum.userSessionData.rawValue)
    }
    
}
