//
//  RedirectHelper.swift
//  FaizanHelpingCode
//
//  Created by Usama  on 2022/5/2.
//

import UIKit

enum Stoyboard : String {
    case Main
}

final class RedirectHelper {
    private var window : UIWindow!
    
    init(window: UIWindow?) {
        if window != nil {
            self.window = window
        }else {
            guard let temp : UIWindow = UIApplication.shared.windows.filter({$0.isKeyWindow}).first else {return}
            self.window = temp
        }
    }
    
    func determineRoutes () {
        let transition = CATransition()
        transition.type = .reveal
        let screenSize: CGRect = UIScreen.main.bounds
        let myView = UIView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: self.window.bounds.height))
        myView.backgroundColor = .white
        window.addSubview(myView)

        self.checkUserSession(transition: transition)
    }
    
    func checkUserSession(transition :CATransition) {
        setRootToHome(transition: transition)
    }
    
    func setRootToHome(transition :CATransition) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let homeNav = storyboard.instantiateViewController(withIdentifier: "GeoForceViewControllerNav") as! UINavigationController
        window.set(rootViewController: homeNav, withTransition: transition)
        window.makeKeyAndVisible()
    }
  
    
    
}

