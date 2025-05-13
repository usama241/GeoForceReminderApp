//
//  RedirectHelper.swift

//
//  Created by Usama on 2022/5/2.
//

import Foundation
import UIKit
import FittedSheets

extension UIViewController{
    //MARK:- Navigation transparent
    func transparentNavigation(tintColor: UIColor? = nil) {
        let bar:UINavigationBar! =  self.navigationController?.navigationBar
        bar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        bar.shadowImage = UIImage()
        if tintColor != nil {
            bar.tintColor = tintColor!
        }
    }
    
    func addNavigationGesture(parent: UIGestureRecognizerDelegate) {
        navigationController?.interactivePopGestureRecognizer?.delegate = parent
    }
    
    // UIGestureRecognizerDelegate
    @nonobjc func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if let navVc = navigationController {
          return navVc.viewControllers.count > 1
        }
        return false
    }
    
    func addNavBarImage() {
        
        let navController = navigationController!
        
        let image = UIImage(named: "watya_small_logo")
        let imageView = UIImageView(image: image)
        
        let bannerWidth = navController.navigationBar.frame.size.width / 2 - 20
        let bannerHeight = navController.navigationBar.frame.size.height / 2 - 20
        
        let bannerX = bannerWidth
        let bannerY = bannerHeight
        
        imageView.frame = CGRect(x: bannerX, y: bannerY, width: bannerWidth, height: bannerHeight)
        imageView.contentMode = .scaleAspectFit
        
        navigationItem.titleView = imageView
    }
}

extension UIViewController {
    func embed(_ viewController:UIViewController, inView view:UIView){
        viewController.willMove(toParent: self)
        viewController.view.frame = view.bounds
        view.addSubview(viewController.view)
        self.addChild(viewController)
        viewController.didMove(toParent: self)
    }
    
    func roundCorners(with CACornerMask: CACornerMask, radius: CGFloat) {
        self.view.layer.cornerRadius = radius
        self.view.layer.maskedCorners = [CACornerMask]
        self.view.layer.masksToBounds = true
    }
}


extension UIViewController {
    func hideNavigationBar(animated: Bool){
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        
    }
    
    func showNavigationBar(animated: Bool) {
        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func alertMessage(title: String, msg: String)  {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

 
 class DynamicHeightCollectionView: UICollectionView {
     override func layoutSubviews() {
         super.layoutSubviews()
         if bounds.size != intrinsicContentSize {
             self.invalidateIntrinsicContentSize()
         }
     }
     override var intrinsicContentSize: CGSize {
         return collectionViewLayout.collectionViewContentSize
     }
 }

//MARK: Alerts
extension UIViewController {
    @MainActor
    func showAlert(title: String?, message: String?, icon: AlertIcon, buttonTitle: String = "Okay", showCloseButton: Bool = true, dismissOnTapOutside: Bool = false, animated: Bool = true, buttonAction: @escaping (() -> Void) = {}) {
//        let viewController = Storyboard.Main.instantiateViewController(withIdentifier: AlertViewController.storyboardIdentifier) as! AlertViewController
        let  viewController = Storyboard.Main.instantiate(identifier: AlertViewController.self)
        let sheetController = SheetViewController.getDefaultSheet(viewController: viewController, sizes: [.intrinsic])
        sheetController.dismissOnPull = false
        sheetController.dismissOnOverlayTap = dismissOnTapOutside
        viewController.crossButton.isHidden = !showCloseButton
        viewController.alertTitle = title
        viewController.message = message
        viewController.icon = icon
        viewController.buttonTitle = buttonTitle
        viewController.closeAction = {
            sheetController.dismiss(animated: animated)
        }
        viewController.doneAction = {
            sheetController.dismiss(animated: animated) {
                buttonAction()
            }
        }
        self.present(sheetController, animated: animated, completion: nil)
    }
    
    func showAlert(title: String?, message: String?, icon: AlertIcon, buttonTitle: String = "Okay", showCloseButton: Bool = true, dismissOnTapOutside: Bool = false, animated: Bool = true, buttonAction: @escaping (() -> Void) = {}, closeAction: @escaping (() -> Void) = {}) {
//        let viewController = Storyboard.main.instantiateViewController(withIdentifier: AlertViewController.storyboardIdentifier) as! AlertViewController
        let  viewController = Storyboard.Main.instantiate(identifier: AlertViewController.self)
        let sheetController = SheetViewController.getDefaultSheet(viewController: viewController, sizes: [.intrinsic])
        sheetController.dismissOnPull = false
        sheetController.dismissOnOverlayTap = dismissOnTapOutside
        viewController.alertTitle = title
        viewController.message = message
        viewController.buttonTitle = buttonTitle
        viewController.icon = icon
        viewController.crossButton.isHidden = !showCloseButton
        viewController.closeAction = {
            sheetController.dismiss(animated: animated) {
                closeAction()
            }
        }
        viewController.doneAction = {
            sheetController.dismiss(animated: animated) {
                buttonAction()
            }
        }
        self.present(sheetController, animated: animated, completion: nil)
    }
    
    func showAlert(title: String?, attributedMessage: NSAttributedString?, titleAnimation: String, buttonTitle: String = "Okay", showCloseButton: Bool = true, dismissOnTapOutside: Bool = false, animated: Bool = true, buttonAction: @escaping (() -> Void) = {}, closeAction: @escaping (() -> Void) = {}) {
//        let viewController = Storyboard.main.instantiateViewController(withIdentifier: AlertViewController.storyboardIdentifier) as! AlertViewController
        let  viewController = Storyboard.Main.instantiate(identifier: AlertViewController.self)
        let sheetController = SheetViewController.getDefaultSheet(viewController: viewController, sizes: [.intrinsic])
        sheetController.dismissOnPull = false
        sheetController.dismissOnOverlayTap = dismissOnTapOutside
        viewController.alertTitle = title
        viewController.buttonTitle = buttonTitle
        viewController.attributedMessage = attributedMessage
        viewController.titleAnimation = titleAnimation
        viewController.crossButton.isHidden = !showCloseButton
        viewController.closeAction = {
            sheetController.dismiss(animated: animated) {
                closeAction()
            }
        }
        viewController.doneAction = {
            sheetController.dismiss(animated: animated) {
                buttonAction()
            }
        }
        self.present(sheetController, animated: animated, completion: nil)
    }
    
    func showAlert(title: String?, message: String?, titleAnimation: String, buttonTitle: String = "Okay", showCloseButton: Bool = true, dismissOnTapOutside: Bool = false, animated: Bool = true, buttonAction: @escaping (() -> Void) = {}, closeAction: @escaping (() -> Void) = {}) {
//        let viewController = Storyboard.main.instantiateViewController(withIdentifier: AlertViewController.storyboardIdentifier) as! AlertViewController
        let  viewController = Storyboard.Main.instantiate(identifier: AlertViewController.self)
        let sheetController = SheetViewController.getDefaultSheet(viewController: viewController, sizes: [.intrinsic])
        sheetController.dismissOnPull = false
        sheetController.dismissOnOverlayTap = dismissOnTapOutside
        viewController.alertTitle = title
        viewController.message = message
        viewController.buttonTitle = buttonTitle
        viewController.titleAnimation = titleAnimation
        viewController.crossButton.isHidden = !showCloseButton
        viewController.closeAction = {
            sheetController.dismiss(animated: animated) {
                closeAction()
            }
        }
        viewController.doneAction = {
            sheetController.dismiss(animated: animated) {
                buttonAction()
            }
        }
        self.present(sheetController, animated: animated, completion: nil)
    }
    
    func showAlert(title: String?, message: String?, titleAnimation: String, buttonTitle: String = "Okay", showCloseButton: Bool = true, dismissOnTapOutside: Bool = false, animated: Bool = true, buttonAction: @escaping (() -> Void)) {
//        let viewController = Storyboard.main.instantiateViewController(withIdentifier: AlertViewController.storyboardIdentifier) as! AlertViewController
        let  viewController = Storyboard.Main.instantiate(identifier: AlertViewController.self)
        let sheetController = SheetViewController.getDefaultSheet(viewController: viewController, sizes: [.intrinsic])
        sheetController.dismissOnPull = false
        sheetController.dismissOnOverlayTap = dismissOnTapOutside
        viewController.alertTitle = title
        viewController.message = message
        viewController.titleAnimation = titleAnimation
        viewController.buttonTitle = buttonTitle
        viewController.crossButton.isHidden = !showCloseButton
        viewController.closeAction = {
            sheetController.dismiss(animated: animated)
        }
        viewController.doneAction = {
            sheetController.dismiss(animated: animated) {
                buttonAction()
            }
        }
        self.present(sheetController, animated: animated, completion: nil)
    }
//        
//    func showCancelableAlert(title: String?, message: String?, icon: AlertIcon, showCloseButton: Bool = true, cancelButtonTitle: String?, defaultButtonTitle: String?, cancelButtonStyle: AlertButtonStyle = .secondary, defaultButtonStyle: AlertButtonStyle = .primary,  dismissOnTapOutside: Bool = false, animated: Bool = true, cancelButtonAction: @escaping () -> Void, defaultButtonAction: @escaping () -> Void, closeButtonAction: @escaping (() -> Void) = {} ) {
//        
//        let viewController = Storyboard.main.instantiateViewController(withIdentifier: DoubleActionAlertViewController.storyboardIdentifier) as! DoubleActionAlertViewController
//        let sheetController = SheetViewController.getDefaultSheet(viewController: viewController, sizes: [.intrinsic])
//        viewController.alertTitle = title
//        sheetController.dismissOnPull = false
//        sheetController.dismissOnOverlayTap = dismissOnTapOutside
//        viewController.message = message
//        viewController.messageLabel.numberOfLines = 0
//        viewController.icon = icon
//        viewController.crossButton.isHidden = !showCloseButton
//        viewController.cancelButtonTitle = cancelButtonTitle
//        viewController.defaultButtonTitle = defaultButtonTitle
//        viewController.cancelButtonStyle = cancelButtonStyle
//        viewController.defaultButtonStyle = defaultButtonStyle
//        viewController.cancelButtonAction = {
//            sheetController.dismiss(animated: animated) {
//                cancelButtonAction()
//            }
//        }
//        viewController.defaultButtonAction = {
//            sheetController.dismiss(animated: animated) {
//                defaultButtonAction()
//            }
//        }
//        viewController.closeAction = {
//            sheetController.dismiss(animated: animated)
//            closeButtonAction()
//        }
//        self.present(sheetController, animated: animated, completion: nil)
//    }
//    
//    func showCancelableAlert(title: String?, message: String?, titleAnimation: String, showCloseButton: Bool = true, cancelButtonTitle: String?, defaultButtonTitle: String?, cancelButtonStyle: AlertButtonStyle = .secondary, defaultButtonStyle: AlertButtonStyle = .primary,  dismissOnTapOutside: Bool = false, animated: Bool = true, cancelButtonAction: @escaping () -> Void, defaultButtonAction: @escaping () -> Void) {
//        
//        let viewController = Storyboard.main.instantiateViewController(withIdentifier: DoubleActionAlertViewController.storyboardIdentifier) as! DoubleActionAlertViewController
//        let sheetController = SheetViewController.getDefaultSheet(viewController: viewController, sizes: [.intrinsic])
//        sheetController.dismissOnPull = false
//        sheetController.dismissOnOverlayTap = dismissOnTapOutside
//        viewController.alertTitle = title
//        viewController.message = message
//        viewController.titleAnimation = titleAnimation
//        viewController.crossButton.isHidden = !showCloseButton
//        viewController.cancelButtonTitle = cancelButtonTitle
//        viewController.defaultButtonTitle = defaultButtonTitle
//        viewController.cancelButtonStyle = cancelButtonStyle
//        viewController.defaultButtonStyle = defaultButtonStyle
//        viewController.cancelButtonAction = {
//            sheetController.dismiss(animated: animated) {
//                cancelButtonAction()
//            }
//        }
//        viewController.defaultButtonAction = {
//            sheetController.dismiss(animated: animated) {
//                defaultButtonAction()
//            }
//        }
//        viewController.closeAction = {
//            sheetController.dismiss(animated: animated)
//        }
//        self.present(sheetController, animated: animated, completion: nil)
//    }
//    
    func showCancelableAlert(title: String?, attribuitedMessage: NSAttributedString?, icon: AlertIcon, showCloseButton: Bool = true, cancelButtonTitle: String?, defaultButtonTitle: String?, cancelButtonStyle: AlertButtonStyle = .secondary, defaultButtonStyle: AlertButtonStyle = .primary,  dismissOnTapOutside: Bool = false, animated: Bool = true, cancelButtonAction: @escaping () -> Void, defaultButtonAction: @escaping () -> Void, closeButtonAction: @escaping (() -> Void) = {} ) {
        let  viewController = Storyboard.Main.instantiate(identifier: DoubleActionAlertViewController.self)
        let sheetController = SheetViewController.getDefaultSheet(viewController: viewController, sizes: [.intrinsic])
        viewController.alertTitle = title
        sheetController.dismissOnPull = false
        sheetController.dismissOnOverlayTap = dismissOnTapOutside
        viewController.attributedMessage = attribuitedMessage
        viewController.messageLabel.numberOfLines = 0
        viewController.icon = icon
        viewController.crossButton.isHidden = !showCloseButton
        viewController.cancelButtonTitle = cancelButtonTitle
        viewController.defaultButtonTitle = defaultButtonTitle
        viewController.cancelButtonStyle = cancelButtonStyle
        viewController.defaultButtonStyle = defaultButtonStyle
        viewController.cancelButtonAction = {
            sheetController.dismiss(animated: animated) {
                cancelButtonAction()
            }
        }
        viewController.defaultButtonAction = {
            sheetController.dismiss(animated: animated) {
                defaultButtonAction()
            }
        }
        viewController.closeAction = {
            sheetController.dismiss(animated: animated)
            closeButtonAction()
        }
        self.present(sheetController, animated: animated, completion: nil)
    }
    
    func showCancelableAlert(title: String?, message: String?, icon: AlertIcon, titleAnimation: String,showCancelButton: Bool = false, showCloseButton: Bool = true, cancelButtonTitle: String?, defaultButtonTitle: String?, cancelButtonStyle: AlertButtonStyle = .secondary, defaultButtonStyle: AlertButtonStyle = .primary, dismissOnTapOutside: Bool = false, animated: Bool = true, cancelButtonAction: @escaping () -> Void, defaultButtonAction: @escaping () -> Void) {
        let  viewController = Storyboard.Main.instantiate(identifier: DoubleActionAlertViewController.self)
        let sheetController = SheetViewController.getDefaultSheet(viewController: viewController, sizes: [.intrinsic])
        sheetController.dismissOnPull = false
        sheetController.dismissOnOverlayTap = dismissOnTapOutside
        viewController.alertTitle = title
        viewController.message = message
        viewController.icon = icon
        viewController.titleAnimation = titleAnimation
        viewController.crossButton.isHidden = !showCloseButton
        viewController.cancelButton.isHidden = showCancelButton
        viewController.cancelButtonTitle = cancelButtonTitle
        viewController.defaultButtonTitle = defaultButtonTitle
        viewController.cancelButtonStyle = cancelButtonStyle
        viewController.defaultButtonStyle = defaultButtonStyle
        viewController.cancelButtonAction = {
            sheetController.dismiss(animated: animated) {
                cancelButtonAction()
            }
        }
        viewController.defaultButtonAction = {
            sheetController.dismiss(animated: animated) {
                defaultButtonAction()
            }
        }
        viewController.closeAction = {
            sheetController.dismiss(animated: animated)
        }
        self.present(sheetController, animated: animated, completion: nil)
    }
    
    func showZSportsCancelableAlert(title: String?, message: String?, titleAnimation: String, showCloseButton: Bool = true, defaultButtonTitle: String?, cancelButtonStyle: AlertButtonStyle = .secondary, defaultButtonStyle: AlertButtonStyle = .primary,  dismissOnTapOutside: Bool = false, animated: Bool = true, defaultButtonAction: @escaping () -> Void) {
        let  viewController = Storyboard.Main.instantiate(identifier: DoubleActionAlertViewController.self)
        let sheetController = SheetViewController.getDefaultSheet(viewController: viewController, sizes: [.intrinsic])
        sheetController.dismissOnPull = false
        sheetController.dismissOnOverlayTap = dismissOnTapOutside
        viewController.alertTitle = title
        viewController.message = message
        viewController.cancelButton.isHidden = true
        viewController.titleAnimation = titleAnimation
        viewController.crossButton.isHidden = !showCloseButton
        viewController.defaultButtonTitle = defaultButtonTitle
        viewController.cancelButtonStyle = cancelButtonStyle
        viewController.defaultButtonStyle = defaultButtonStyle
        viewController.defaultButtonAction = {
            sheetController.dismiss(animated: animated) {
                defaultButtonAction()
            }
        }
        viewController.closeAction = {
            sheetController.dismiss(animated: animated)
        }
        self.present(sheetController, animated: animated, completion: nil)
    }
//
//    func showCancelableAlert(title: String?, attribuitedMessage: NSAttributedString?, titleAnimation: String, showCloseButton: Bool = true, cancelButtonTitle: String?, defaultButtonTitle: String?, cancelButtonStyle: AlertButtonStyle = .secondary, defaultButtonStyle: AlertButtonStyle = .primary,  dismissOnTapOutside: Bool = false, animated: Bool = true, cancelButtonAction: @escaping () -> Void, defaultButtonAction: @escaping () -> Void, closeButtonAction: @escaping (() -> Void) = {} ) {
//        
//        let viewController = Storyboard.main.instantiateViewController(withIdentifier: DoubleActionAlertViewController.storyboardIdentifier) as! DoubleActionAlertViewController
//        let sheetController = SheetViewController.getDefaultSheet(viewController: viewController, sizes: [.intrinsic])
//        viewController.alertTitle = title
//        sheetController.dismissOnPull = false
//        sheetController.dismissOnOverlayTap = dismissOnTapOutside
//        viewController.attributedMessage = attribuitedMessage
//        viewController.messageLabel.numberOfLines = 0
//        viewController.titleAnimation = titleAnimation
//        viewController.crossButton.isHidden = !showCloseButton
//        viewController.cancelButtonTitle = cancelButtonTitle
//        viewController.defaultButtonTitle = defaultButtonTitle
//        viewController.cancelButtonStyle = cancelButtonStyle
//        viewController.defaultButtonStyle = defaultButtonStyle
//        viewController.cancelButtonAction = {
//            sheetController.dismiss(animated: animated) {
//                cancelButtonAction()
//            }
//        }
//        viewController.defaultButtonAction = {
//            sheetController.dismiss(animated: animated) {
//                defaultButtonAction()
//            }
//        }
//        viewController.closeAction = {
//            sheetController.dismiss(animated: animated)
//            closeButtonAction()
//        }
//        self.present(sheetController, animated: animated, completion: nil)
//    }
    
}

extension UIViewController {
    static var storyboardIdentifier: String {
        return String(describing: self)
    }
    
    func screen() -> UIScreen? {
        var parent = self.parent
        var lastParent = parent
        while parent != nil {
            lastParent = parent
            parent = parent!.parent
        }
        return lastParent?.view.window?.windowScene?.screen
    }
}
