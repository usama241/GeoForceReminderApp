//
//  RedirectHelper.swift
//  FaizanHelpingCode
//
//  Created by Usama on 2022/5/2.
//

import UIKit

extension UIWindow {

    static var topWindow: UIWindow {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = UIViewController()
        window.windowLevel = UIWindow.Level.normal
        window.makeKeyAndVisible()

        return window
    }

    func set(rootViewController newRootViewController: UIViewController, withTransition transition: CATransition? = nil) {
        let previousViewController = rootViewController

        if let transition = transition {
            // Add the transition
            layer.add(transition, forKey: kCATransition)
        }

        rootViewController = newRootViewController

        // Update status bar appearance using the new view controllers appearance - animate if needed
        if UIView.areAnimationsEnabled {
            UIView.animate(withDuration: CATransaction.animationDuration()) {
                newRootViewController.setNeedsStatusBarAppearanceUpdate()
            }
        } else {
            newRootViewController.setNeedsStatusBarAppearanceUpdate()
        }

        /// The presenting view controllers view doesn't get removed from the window as its currently transistioning and presenting a view controller
        /// In iOS 13 we don't want to remove the transition view as it'll create a blank screen
        /// TODO: fix leak on iOS 13
        if #available(iOS 13.0, *) {} else {
            if let transitionViewClass = NSClassFromString("UITransitionView") {
                for subview in subviews where subview.isKind(of: transitionViewClass) {
                    subview.removeFromSuperview()
                }
            }
        }

        if let previousViewController = previousViewController {
            // Allow the view controller to be deallocated
            previousViewController.dismiss(animated: false) {
                // Remove the root view in case its still showing
                previousViewController.view.removeFromSuperview()
            }
        }
    }
}

