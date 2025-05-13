//
//  UserSession.swift
//  Alazba
//
//  Created by Myansh Passi on 18/11/20.
//

import Foundation
import CoreMedia

class UserSession:NSObject {
    private static let _shared = UserSession()
    static var shared : UserSession {
        return _shared
    }
    var isShowingTracking = false
    var user : LocationsResponse? {
        didSet{
            do {
                guard let user = user else {return}
                let data = try JSONEncoder().encode(user)
                UserDefaults.standard.setUserSession(value: data)
            } catch let error {
                print(error)
            }
        }
    }

  
    
}


