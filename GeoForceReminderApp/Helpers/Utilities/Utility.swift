//
//  Utility.swift
//  Alazba
//
//  Created by Myansh Passi on 17/11/20.
//

import Foundation
import UIKit
import Loaf

 class Utility {
    public typealias EmptyCompletion = () -> Void
    //MARK:-Alerts
    static func alertMessage(title: String, message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(
                title: title,
                message: message,
                preferredStyle: UIAlertController.Style.alert
            )
            alert.addAction(UIAlertAction(
                title: "OK",
                style: UIAlertAction.Style.default,
                handler: nil
            ))
            guard let window : UIWindow = UIApplication.shared.windows.filter({$0.isKeyWindow}).first else {return}
            var presentVC = window.rootViewController
            while let next = presentVC?.presentedViewController {
                presentVC = next
            }
            presentVC?.present(alert, animated: true, completion: nil)
        }
    }
    class func showAlertWithTryAgain(title: String, message: String = "Something wrong", completion: EmptyCompletion? = nil) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Try Again", style: .default, handler: {_ in
                completion?()
            }))
            alert.addAction(UIAlertAction(
                title: "Cancel",
                style: UIAlertAction.Style.default,
                handler: nil
            ))
            UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController?.present(
                alert,
                animated: true,
                completion: nil
            )
        }
    }
     
     class func showMultipleChoiceAlert(message: String, firstHandler: (()->())? = nil, secondHandler: (()->())? = nil) {
         generateWarningFeedback()
         let alertView = AlertPopupWithMultipleChoice.instanceFromNib()
         alertView.okayButton.setTitle("Yes", for: .normal)
         alertView.cancelButton.setTitle("Cancel", for: .normal)
         alertView.messageLabel.text = message
         alertView.firstAction = firstHandler
         alertView.secondAction = secondHandler
         alertView.show()
     }
//     chnage...
//     static func presentPlacePicker(viewController: UIViewController?, completion: ((_ coordinate: CLLocationCoordinate2D, _ address: String)->Void)?) {
//         let placePickerVC = UIStoryboard(name: "PlacePicker", bundle: nil).instantiateViewController(withIdentifier: "PlacePickerViewController") as! PlacePickerViewController
//         //        placePickerVC.pickedCoordinate = sourceLocation?.coordinate
//         placePickerVC.pickerMarkerImage = UIImage(named: "Location-Pin")
//         //   placePickerVC.titleString = "Select Location"
//         placePickerVC.placePicked = { (coordinate, address) in
//             completion?(coordinate, address)
//         }
//         viewController?.present(UINavigationController.init(rootViewController: placePickerVC), animated: true, completion: nil)
//     }
    class func showAlertWithYesAndNo(title: String, message: String = "", completion: EmptyCompletion? = nil) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: {_ in
                completion?()
            }))
            alert.addAction(UIAlertAction(
                title: "No",
                style: UIAlertAction.Style.default,
                handler: nil
            ))
            guard let window : UIWindow = UIApplication.shared.windows.filter({$0.isKeyWindow}).first else {return}
            var presentVC = window.rootViewController
            while let next = presentVC?.presentedViewController {
                presentVC = next
            }
            presentVC?.present(alert, animated: true, completion: nil)
        }
    }
    class func showAlertWithCustomButton(buttonTitle: String, title: String, message: String = "", completion: EmptyCompletion? = nil) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: {_ in
                completion?()
            }))
            guard let window : UIWindow = UIApplication.shared.windows.filter({$0.isKeyWindow}).first else {return}
            var presentVC = window.rootViewController
            while let next = presentVC?.presentedViewController {
                presentVC = next
            }
            presentVC?.present(alert, animated: true, completion: nil)
        }
    }
     
     class func showWarningAlert(message: String, okayHandler: (()->())? = nil) {
         generateWarningFeedback()
         let alertView = AlertPopup.instanceFromNib()
         alertView.messageLabel.text = message
         alertView.okayAction = okayHandler
         alertView.show()
     }
     
     class func showAlert(title: String?, message: String, okayHandler: (()->())? = nil) {
         generateWarningFeedback()
         let alertView = AlertPopup.instanceFromNib()
         alertView.titleLabel.text = title
         alertView.messageLabel.text = message
         alertView.okayAction = okayHandler
         alertView.show()
     }
     
     
     class func showQuestionAlert(message: String, okayHandler: (()->())? = nil) {
         generateWarningFeedback()
         let alertView = AlertPopupWithTwoButtons.instanceFromNib()
         alertView.messageLabel.text = message
         alertView.okayAction = okayHandler
         alertView.show()
     }
//
//     class func showMultipleChoiceAlert(message: String, firstHandler: (()->())? = nil, secondHandler: (()->())? = nil) {
//         generateWarningFeedback()
//         let alertView = AlertPopupWithMultipleChoice.instanceFromNib()
//         alertView.messageLabel.text = message
//         alertView.firstAction = firstHandler
//         alertView.secondAction = secondHandler
//         alertView.show()
//     }
     
     class func showSuccessAlert(message: String, okayHandler: (()->())? = nil) {
         generateSuccessFeedback()
         let alertView = AlertPopup.instanceFromNib()
         alertView.messageLabel.text = message
         alertView.okayAction = okayHandler
         alertView.show()
     }
     
     class func generateSuccessFeedback() {
         let notificationFeedbackGenerator = UINotificationFeedbackGenerator()
         notificationFeedbackGenerator.prepare()
         notificationFeedbackGenerator.notificationOccurred(.success)
     }
     
     class func showAlertWithComments(message: String, okayHandler: ((String)->())? = nil) {
         generateWarningFeedback()
         let alertView = AlertPopupWithComments.instanceFromNib()
         alertView.messageLabel.text = message
         alertView.okayAction = okayHandler
         alertView.show()
     }
     
     class func generateWarningFeedback() {
         let notificationFeedbackGenerator = UINotificationFeedbackGenerator()
         notificationFeedbackGenerator.prepare()
         notificationFeedbackGenerator.notificationOccurred(.warning)
     }
     //animation  code...
     
     class func addToCartAnimation(vc: UIViewController?, frame: CGRect, image: UIImage?) {
         let imgViewTemp = UIImageView(frame: frame)
         imgViewTemp.image = image
         imgViewTemp.layer.cornerRadius = 25
         imgViewTemp.clipsToBounds = true
         imgViewTemp.contentMode = .scaleAspectFill
         imgViewTemp.alpha = 0
         
         let currentWindow: UIWindow? = UIApplication.shared.keyWindow
         currentWindow?.addSubview(imgViewTemp)
         
         let fromPoint = CGPoint(x: frame.origin.x + frame.size.width/2, y: frame.origin.y + frame.size.height/2)
         let toPoint = CGPoint(x: (vc?.view.frame.maxX ?? 0), y: 24 + (vc?.view.safeAreaInsets.top ?? 0))
         
//         let fromPoint = CGPoint(x: 220, y: 450)
//
//         let toPoint = CGPoint(x: 340, y: 44)
         
         let animGroup = getCartAnimationGroup(fromPoint: fromPoint, toPoint: toPoint, imageView: imgViewTemp)
 //        animGroup.completionBlock { (_, _) in
 //            imgViewTemp.removeFromSuperview()
 //        }
         imgViewTemp.layer.add(animGroup, forKey: "curvedAnim")
     }
     
     class func getCartAnimationGroup(fromPoint: CGPoint, toPoint: CGPoint, imageView: UIImageView) -> CAAnimationGroup {
         let moveAnim = CABasicAnimation(keyPath: "position")
         moveAnim.fromValue = NSValue(cgPoint: fromPoint)
         moveAnim.toValue = NSValue(cgPoint: toPoint)
         moveAnim.timingFunction = CAMediaTimingFunction(name: .easeOut)
         moveAnim.fillMode = CAMediaTimingFillMode.forwards
         
         let scaleAnim = CABasicAnimation(keyPath: "transform")
         scaleAnim.fromValue = NSValue(caTransform3D: CATransform3DIdentity)
         scaleAnim.toValue = NSValue(caTransform3D: CATransform3DMakeScale(0.1, 0.1, 1.0))
         scaleAnim.timingFunction = CAMediaTimingFunction(name: .easeOut)
         scaleAnim.fillMode = CAMediaTimingFillMode.forwards
         
         let opacityAnim = CABasicAnimation(keyPath: #keyPath(CALayer.opacity))
         opacityAnim.fromValue = NSNumber(value: 1.0)
         opacityAnim.toValue = NSNumber(value: 0)
         opacityAnim.timingFunction = CAMediaTimingFunction(name: .easeIn)
         opacityAnim.fillMode = CAMediaTimingFillMode.forwards
         
         let cornerRadiusAnim = CABasicAnimation(keyPath: "cornerRadius")
         cornerRadiusAnim.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
         cornerRadiusAnim.fromValue = 50
         cornerRadiusAnim.toValue = imageView.frame.height/2
         cornerRadiusAnim.fillMode = CAMediaTimingFillMode.forwards
         
         let animGroup = CAAnimationGroup()
         animGroup.setValue("curvedAnim", forKey: "animationName")
         animGroup.animations = [moveAnim, scaleAnim, opacityAnim, cornerRadiusAnim]
         animGroup.duration = 0.8
         return animGroup
     }

     class func openLinkInBrowser(urlString: String) {
         
         if let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) {
             UIApplication.shared.open(url)
         }
     }
  
     
     static func mapNumbersToWeekdays(from daysAvailableArray: [String]) -> [String] {
         let weekDays = ["Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"]

         // Check if the input contains numbers (by trying to convert the first element to an Int)
         let input = daysAvailableArray.map { $0.trimmingCharacters(in: .whitespaces) }
         if let firstElement = input.first, Int(firstElement) != nil {
             // Convert numbers to corresponding weekdays
             let mappedWeekDays = input.compactMap { numberString -> String? in
                 if let number = Int(numberString), number >= 1, number <= 7 {
                     return weekDays[number - 1]
                 }
                 return nil  // In case of invalid numbers
             }
             return mappedWeekDays
         } else {
             // If the input is already weekdays, validate and return them
             let validatedWeekDays = input.filter { weekDays.contains($0) }
             print(validatedWeekDays)
             return validatedWeekDays
         }
     }
     
     static func mapWeekdaysToNumbers(from input: [String]) -> String {
         let weekDays = ["Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"]

         // Check if the input contains numbers
         if let firstElement = input.first, Int(firstElement) != nil {
             // If it's already numbers, return them as a comma-separated string (assuming valid day numbers)
             let validNumbers = input.filter { numberString in
                 if let number = Int(numberString), number >= 1, number <= 7 {
                     return true
                 }
                 return false
             }
             print(validNumbers.joined(separator: ", "))
             return validNumbers.joined(separator: ", ")
         } else {
             // Convert weekday names to their corresponding numbers
             let mappedNumbers = input.compactMap { weekday -> String? in
                 if let index = weekDays.firstIndex(where: { $0.caseInsensitiveCompare(weekday) == .orderedSame }) {
                     return String(index + 1) // Convert index to 1-based day number
                 }
                 return nil // In case of invalid weekdays
             }
             print(mappedNumbers.joined(separator: ", "))
             return mappedNumbers.joined(separator: ", ")
         }
     }
     
     class func timeString(time: TimeInterval) -> String {
         let hours = Int(time) / 3600
         let minutes = Int(time) / 60 % 60
         let seconds = Int(time) % 60
         return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
     }
     
     class func timeMinString(time: TimeInterval) -> String {
         let minutes = Int(time) / 60 % 60
         let seconds = Int(time) % 60
         return String(format:"%02i:%02i", minutes, seconds)
     }
     
     class func convertTo24HourFormat(_ timeString: String) -> String? {
         let dateFormatter = DateFormatter()
         dateFormatter.dateFormat = "h:mm a" // Input format: hours:minutes AM/PM
         
         if let date = dateFormatter.date(from: timeString) {
             dateFormatter.dateFormat = "HH:mm:ss" // Output format: hours:minutes:seconds
             return dateFormatter.string(from: date)
         }
         
         return nil
     }
     class func convertToAMPMHourFormat(_ timeString: String) -> String? {
         let dateFormatter = DateFormatter()
         dateFormatter.dateFormat = "HH:mm:ss" // Input format: hours:minutes AM/PM
         
         if let date = dateFormatter.date(from: timeString) {
             dateFormatter.dateFormat = "h:mm a" // Output format: hours:minutes:seconds
             return dateFormatter.string(from: date)
         }
         
         return nil
     }
 }



// MARK: DataDetector

class DataDetector {

    private class func _find(all type: NSTextCheckingResult.CheckingType,
                             in string: String, iterationClosure: (String) -> Bool) {
        guard let detector = try? NSDataDetector(types: type.rawValue) else { return }
        let range = NSRange(string.startIndex ..< string.endIndex, in: string)
        let matches = detector.matches(in: string, options: [], range: range)
        loop: for match in matches {
            for i in 0 ..< match.numberOfRanges {
                let nsrange = match.range(at: i)
                let startIndex = string.index(string.startIndex, offsetBy: nsrange.lowerBound)
                let endIndex = string.index(string.startIndex, offsetBy: nsrange.upperBound)
                let range = startIndex..<endIndex
                guard iterationClosure(String(string[range])) else { break loop }
            }
        }
    }

    class func find(all type: NSTextCheckingResult.CheckingType, in string: String) -> [String] {
        var results = [String]()
        _find(all: type, in: string) {
            results.append($0)
            return true
        }
        return results
    }

    class func first(type: NSTextCheckingResult.CheckingType, in string: String) -> String? {
        var result: String?
        _find(all: type, in: string) {
            result = $0
            return false
        }
        return result
    }
    

}
