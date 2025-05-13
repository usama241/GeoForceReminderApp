//
//  AppDelegate.swift

//
//  Created by apple on 06/03/2023.
//

import UIKit
import IQKeyboardManagerSwift
import SDWebImage
import CoreData
import SDWebImageSVGCoder
import FittedSheets

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var redirect : RedirectHelper!
    var logoutTimer: Timer?
    let logoutTimeInterval: TimeInterval = 1200 // 20 minutes
    let vc = BaseViewController()
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
//        IQKeyboardManager.shared.enable = true
        let SVGCoder = SDImageSVGCoder.shared
        SDImageCodersManager.shared.addCoder(SVGCoder)
        let frame = UIScreen.main.bounds
        self.window = UIWindow(frame: frame)
        redirect = RedirectHelper(window: window)
        redirect.determineRoutes()
        return true
    }
 
    func applicationWillTerminate(_ application: UIApplication) {
        UserDefaults.standard.removeUserSession()
        UserSession.shared.user = nil
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}

extension UIApplication{
    
    static func window() -> UIWindow {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.window!
    }
}
