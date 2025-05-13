//
//  MainTextField.swift
//
//  Created by Usama on 2022/6/24.
//

import Foundation
import UIKit

class MainTextField: UITextField {
    
    internal lazy var countryImageView: UIImageView = {
        let countryImageView = UIImageView(frame: CGRect(x: 16, y: 20, width: 16, height: 16))
        countryImageView.clipsToBounds = true
        countryImageView.contentMode = .scaleAspectFill
        countryImageView.image = UIImage(named: "GB")
        countryImageView.isCircle = true
        return countryImageView
    }()
    private lazy var dropdownImageView: UIImageView = {
        let dropdownImageView = UIImageView(frame: CGRect(x: (Constants.Static.screenWidth - 32) - 25, y: 20, width: 16, height: 16))
        dropdownImageView.image = UIImage(named: "btnDropDownIcon")
        dropdownImageView.tintColor = UIColor.AppBgColor
        dropdownImageView.contentMode = .scaleAspectFit
        return dropdownImageView
    }()
    private lazy var creditCardImageView: UIImageView = {
        let creditCardImageView = UIImageView(frame: CGRect(x: 16, y: 20, width: 16, height: 16))
        creditCardImageView.clipsToBounds = true
        creditCardImageView.image = UIImage(named: "Debit Card")
        creditCardImageView.contentMode = .scaleAspectFill
        return creditCardImageView
    }()
    private lazy var copyButton: UIButton = {
        let copyButton = UIButton(frame: CGRect(x: Constants.Static.screenWidth - 32 - 40, y: 16, width: 24, height: 24))
        copyButton.clipsToBounds = true
        copyButton.setImage(UIImage(named: "share-gray"), for: .normal)
//        copyButton.addTarget(self, action: #selector(onCopyPressed), for: .touchUpInside)
        return copyButton
    }()
    
    private var errorView = UIView()
    private var errorLabel = UILabel()
    private var successView = UIView()
    private var successLabel = UILabel()
    
    internal var hideErrorOnStart: Bool = false
    internal var enabledField: Bool = true {
        didSet {
            self.isEnabled = enabledField
            
            self.active = enabledField
//            if enabledField {
//                self.active = false
//            }
        }
    }
    
    private var padding = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
    private var customColor: UIColor {
        get {
            return UIColor.white
        }
    }
    
    @IBInspectable
    internal var isDropDown: Bool = false {
        didSet {
            if isDropDown {
                self.addSubview(dropdownImageView)
            } else {
                dropdownImageView.removeFromSuperview()
            }
        }
    }
    
    @IBInspectable
    internal var isCountry: Bool = false {
        didSet {
            if isCountry {
                padding = UIEdgeInsets(top: 16, left: 40, bottom: 16, right: 16)
                self.text = "UAE"
                self.active = true
                self.addSubview(countryImageView)
            } else {
                if !isCreditCard {
                    padding = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
                }
                countryImageView.removeFromSuperview()
            }
        }
    }
    
    @IBInspectable
    internal var isCreditCard: Bool = false {
        didSet {
            if isCreditCard {
                padding = UIEdgeInsets(top: 16, left: 40, bottom: 16, right: 16)
                self.addSubview(creditCardImageView)
            } else {
                if !isCountry {
                    padding = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
                }
                creditCardImageView.removeFromSuperview()
            }
        }
    }
    
    @IBInspectable
    internal var isLink: Bool = false {
        didSet {
            if isLink {
                padding = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 48)
                self.addSubview(copyButton)
            } else {
                copyButton.removeFromSuperview()
            }
        }
    }
    
    
    @IBInspectable
    var textFieldBorderColor: UIColor = UIColor.TextFieldBorderColor {
        didSet {
            self.borderColor = textFieldBorderColor
        }
    }
    
    @IBInspectable
    var active: Bool = false {
        didSet {
            textFieldBorderColor = active ? .tint4: .TextFieldBorderColor
        }
    }
    
    @IBInspectable
    public var errorMessage: String = "" {
        didSet {
            errorLabel.text = errorMessage
        }
    }
    
    @IBInspectable
    public var errorMessageVisible: Bool = false {
        didSet {
            if errorMessageVisible {
                self.addSubview(errorView)
            } else {
                errorView.removeFromSuperview()
            }
        }
    }
    
    @IBInspectable
    public var successMessage: String = "" {
        didSet {
            successLabel.text = successMessage
        }
    }
    
    @IBInspectable
    public var successMessageVisible: Bool = false {
        didSet {
            if successMessageVisible {
                self.addSubview(successView)
            } else {
                successView.removeFromSuperview()
            }
        }
    }
    
    internal var dropdownOpen: Bool = false {
        didSet {
            if isDropDown {
                dropdownImageView.image = dropdownOpen ? dropdownImageView.image?.rotate(radians: .pi):UIImage(named: "btnDropDownIcon")
            }
        }
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.clipsToBounds = true
        self.font = UIFont.mySystemFont(ofSize: 16)
        self.textColor = .primaryColor
        self.backgroundColor = customColor
        self.layer.cornerRadius = 8
        self.borderWidth = 1
        self.borderColor = textFieldBorderColor
        
        // event detecting
        self.addTarget(self, action: #selector(textFieldStartEditing), for: UIControl.Event.editingDidBegin)
        self.addTarget(self, action: #selector(textFieldEndEditing), for: UIControl.Event.editingDidEnd)
        self.addTarget(self, action: #selector(textFieldEditing), for: UIControl.Event.editingChanged)
        self.addTarget(self, action: #selector(textFieldReturnPressed(_:)), for: .primaryActionTriggered)
        
        // error view
        self.clipsToBounds = false
        errorView = UILabel(frame: CGRect(x: 0, y: 44, width: self.frame.width, height: 24))
        errorView.backgroundColor = .clear
        let errorImageView = UIImageView(frame: CGRect(x: 0, y: 9, width: 13.3, height: 13.3))
        errorImageView.image = UIImage(named: "info")?.withRenderingMode(.alwaysTemplate)
        errorImageView.tintColor = .errorColor
        errorView.addSubview(errorImageView)
        errorLabel = UILabel(frame: CGRect(x: 16, y: 8, width: self.frame.width - 25, height: 16))
        errorLabel.font = UIFont.mySystemFont(ofSize: 12)
        errorLabel.textColor = .errorColor
        errorLabel.backgroundColor = .clear
        errorLabel.text = errorMessage
        errorView.addSubview(errorLabel)
        
        // success view
        successView = UILabel(frame: CGRect(x: 0, y: 56, width: self.frame.width, height: 24))
        successView.backgroundColor = .clear
        let successImageView = UIImageView(frame: CGRect(x: 0, y: 9, width: 13.3, height: 13.3))
        successImageView.image = UIImage(named: "Tick-green")
        successView.addSubview(successImageView)
        successLabel = UILabel(frame: CGRect(x: 22.6, y: 8, width: self.frame.width - 25, height: 16))
        successLabel.font = UIFont.mySystemFont(ofSize: 12)
        successLabel.textColor = .secondaryColor
        successLabel.backgroundColor = .clear
        successLabel.text = successMessage
        successView.addSubview(successLabel)
    }
        
    
    @objc func textFieldStartEditing() {
        self.active = true
        self.dropdownOpen = true
        if hideErrorOnStart {
            self.errorMessageVisible = false
        }
    }
    
    @objc func textFieldEndEditing() {
        dropdownOpen = false
//        if (self.text ?? "").isEmpty {
            active = false
//        }
    }
    
    @objc func textFieldEditing() {
        active = !(self.text ?? "").isEmpty
        if hideErrorOnStart {
            self.errorMessageVisible = false
        }
        
    }
//    
//    @objc func onCopyPressed() {
//        /// copy
////        UIPasteboard.general.string = self.text ?? ""
//        /// share
//        if let name = self.text {
//            let objectsToShare = [name]
//            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
//            let parent = self.parentContainerViewController()
//            parent?.present(activityVC, animated: true, completion: nil)
//        }
//    }
    
    @objc func textFieldReturnPressed(_ textField: UITextField) {
        self.resignFirstResponder()
    }
}

class TextField: UITextField {

    let padding = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
