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
  
    
   class func getTheDateFromString(dateString: String, formate: DateFormat) -> Date? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formate.rawValue
        //according to date format your date string
        guard let theDate = dateFormatter.date(from: dateString) else {
            return nil
        }
        return theDate
    }
     
    class func gotoEmailApp() {
         
         let email = ""
         if let url = URL(string: "mailto:\(email)") {
           if #available(iOS 10.0, *) {
             UIApplication.shared.open(url)
           } else {
             UIApplication.shared.openURL(url)
           }
         }
     }
     
    static func convertDateFormat(dateString: String) -> String? {
         let inputFormatter = DateFormatter()
         inputFormatter.dateFormat = "yyyy-MM-dd"
         
         // Convert the string to Date
         if let date = inputFormatter.date(from: dateString) {
             let outputFormatter = DateFormatter()
             outputFormatter.dateFormat = "dd-MM-yyyy"
             
             // Convert Date back to String in the new format
             return outputFormatter.string(from: date)
         }
         return nil
     }

     // Function to extract time range from input string
    static func extractTimeRange(from text: String) -> String? {
         let pattern = "Time: (\\d{2}:\\d{2} [APM]{2} - \\d{2}:\\d{2} [APM]{2})"
         
         // Create regular expression
         if let regex = try? NSRegularExpression(pattern: pattern, options: []) {
             let range = NSRange(location: 0, length: text.utf16.count)
             
             // Search for the first match
             if let match = regex.firstMatch(in: text, options: [], range: range) {
                 // Extract the matched group (time range)
                 if let range = Range(match.range(at: 1), in: text) {
                     return String(text[range])
                 }
             }
         }
         return nil
     }
     
    class func getTime(from dateString: String, fromFormat: DateFormat = .fullDate, toFormate: DateFormat = .onlyTime) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = fromFormat.rawValue  //Your date format
        dateFormatter.locale = Locale(identifier: "en_US")
        //according to date format your date string
        guard let theDate = dateFormatter.date(from: dateString) else {
            return nil
        }
        dateFormatter.dateFormat = toFormate.rawValue// "HH:mm"
        return dateFormatter.string(from: theDate)
    }
    
     static func parseDate(from timeString: String, format: String) -> Date? {
         let dateFormatter = DateFormatter()
         dateFormatter.dateFormat = format
         dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
         dateFormatter.defaultDate = Date()
         return dateFormatter.date(from: timeString)
     }
     
    static func convertTimeFormathhmma(timeString: String) -> String? {
         // Create a DateFormatter instance for the input format
         let inputFormatter = DateFormatter()
         inputFormatter.dateFormat = "HH:mm:ss"
         
         // Create a DateFormatter instance for the output format
         let outputFormatter = DateFormatter()
         outputFormatter.dateFormat = "hh:mm a"
         
         // Convert the string to a Date
         if let date = inputFormatter.date(from: timeString) {
             // Convert the Date to the desired output format string
             let formattedTimeString = outputFormatter.string(from: date)
             return formattedTimeString
         }
         
         // Return nil if the input string is not valid
         return nil
     }
     
     static func convertTimeFormatWithUnderScore(timeString: String, outputFormat: String) -> String? {
         let timeComponents = timeString.split(separator: "-").map { $0.trimmingCharacters(in: .whitespaces) }
         guard timeComponents.count == 2 else {
             return nil
         }
         
         let inputFormatter = DateFormatter()
         let outputFormatter = DateFormatter()
         outputFormatter.dateFormat = outputFormat
         
         // Detect input format based on the time string
         let timePart = timeComponents[0]
         
         if timePart.contains(":") {
             // Check if AM/PM is present to detect the format
             if timePart.contains("AM") || timePart.contains("PM") {
                 inputFormatter.dateFormat = "hh:mm a"
             } else {
                 inputFormatter.dateFormat = "HH:mm:ss" // 24-hour format with seconds
             }
         }
         
         if let startTime = inputFormatter.date(from: timeComponents[0]),
            let endTime = inputFormatter.date(from: timeComponents[1]) {
             let formattedStartTime = outputFormatter.string(from: startTime)
             let formattedEndTime = outputFormatter.string(from: endTime)
             return "\(formattedStartTime.lowercased()) - \(formattedEndTime.lowercased())"
         }
         
         return nil
     }

     static func formatStartTime(_ startTime: String) -> String {
         // Check if the time format is "HH:mm:ss"
         let timeFormat = "^[0-9]{2}:[0-9]{2}:[0-9]{2}$"
         let timeRegex = try? NSRegularExpression(pattern: timeFormat)
         let range = NSRange(location: 0, length: startTime.utf16.count)
         
         if let _ = timeRegex?.firstMatch(in: startTime, options: [], range: range) {
             // If format is "HH:mm:ss", return the time directly
             return startTime
         } else {
             // Otherwise, convert to 24-hour format
             return convertTo24HourFormat(time: startTime) ?? "00:00:00"
         }
     }
     
     static func convertTo24HourFormat(time: String) -> String? {
         let dateFormatter = DateFormatter()

         // Input format (12-hour with AM/PM)
         dateFormatter.dateFormat = "h:mm a"
         
         // Convert the input string to a Date object
         if let date = dateFormatter.date(from: time) {
             // Output format (24-hour with seconds)
             dateFormatter.dateFormat = "HH:mm:ss"
             return dateFormatter.string(from: date)
         }
         
         // Return nil if the conversion fails
         return nil
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
     
    class func getTimeAgoStr(from dateString: String, fromFormat: DateFormat = .fullDate) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = fromFormat.rawValue  //Your date format
        //according to date format your date string
        guard let theDate = dateFormatter.date(from: dateString) else {
            return nil
        }
        let str = theDate.timeAgoDisplay()
        return str
    }
     
     class func dialNumber(number : String) {
         
         PhoneNumber(extractFrom: number)?.makeACall()
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



// MARK: PhoneNumber

struct PhoneNumber {
    private(set) var number: String
    init?(extractFrom string: String) {
        guard let phoneNumber = PhoneNumber.first(in: string) else { return nil }
        self = phoneNumber
    }

    private init (string: String) { self.number = string }

    func makeACall() {
        guard let url = URL(string: "tel://\(number.onlyDigits())"),
            UIApplication.shared.canOpenURL(url) else { return }
        if #available(iOS 10, *) {
            UIApplication.shared.open(url)
        } else {
            UIApplication.shared.openURL(url)
        }
    }

    static func extractAll(from string: String) -> [PhoneNumber] {
        DataDetector.find(all: .phoneNumber, in: string)
            .compactMap {  PhoneNumber(string: $0) }
    }

    static func first(in string: String) -> PhoneNumber? {
        guard let phoneNumberString = DataDetector.first(type: .phoneNumber, in: string) else { return nil }
        return PhoneNumber(string: phoneNumberString)
    }
}

extension PhoneNumber: CustomStringConvertible { var description: String { number } }

// MARK: String extension

extension String {
    
    // MARK: Get remove all characters exept numbers
    
    func onlyDigits() -> String {
        let filtredUnicodeScalars = unicodeScalars.filter { CharacterSet.decimalDigits.contains($0) }
        return String(String.UnicodeScalarView(filtredUnicodeScalars))
    }
    
    func base64ToImage() -> UIImage? {
        guard let imageData = Data(base64Encoded: self, options: .ignoreUnknownCharacters) else {
            print("Error: Could not decode base64 string")
            return nil
        }
        let image = UIImage(data: imageData)
        if image == nil {
            print("Error: Could not create image from data")
        }
        return image
    }
    
    
    var detectedPhoneNumbers: [PhoneNumber] { PhoneNumber.extractAll(from: self) }
    var detectedFirstPhoneNumber: PhoneNumber? { PhoneNumber.first(in: self) }
}


import MapKit

class OpenMapDirections {
    // If you are calling the coordinate from a Model, don't forgot to pass it in the function parenthesis.
    static func present(in viewController: UIViewController, sourceView: UIView, fromLat: Double, fromLong: Double, toLat: Double, toLong: Double) {
        let actionSheet = UIAlertController(title: "OpenLocation", message: "ChooseAnAppToOpenDirection", preferredStyle: .actionSheet)
//        actionSheet.addAction(UIAlertAction(title: "googleMaps", style: .default, handler: { _ in
//            // Pass the coordinate inside this URL
//            let url = URL(string: "comgooglemaps://?daddr=\(toLat),\(toLong))&directionsmode=driving&zoom=14&views=traffic&saddr=\(fromLat),\(fromLong)")!
//            UIApplication.shared.open(url, options: [:], completionHandler: nil)
//        }))
        actionSheet.addAction(UIAlertAction(title: "appleMaps", style: .default, handler: { _ in
            
//            let source = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: fromLat, longitude: fromLong)))
//            source.name = "Source"
//            let destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: toLat, longitude: toLong)))
//            destination.name = "Destination"
            
            let coordinate = CLLocationCoordinate2DMake(fromLat,fromLong)
            let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate, addressDictionary: nil))
            mapItem.name = "Destination"
            mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving])
            
//            MKMapItem.openMaps(
//              with: [source],
//              launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
//            )
            
        }))
        actionSheet.popoverPresentationController?.sourceRect = sourceView.bounds
        actionSheet.popoverPresentationController?.sourceView = sourceView
        actionSheet.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: nil))
        viewController.present(actionSheet, animated: true, completion: nil)
    }
    
    
    

}
