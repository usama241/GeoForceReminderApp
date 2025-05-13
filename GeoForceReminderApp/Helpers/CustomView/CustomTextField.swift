//
//  CustomTextField.swift
//  JSZindigi
//
//  Created by Bilal Anwar on 12/07/2023.
//

import Foundation
import UIKit

open class CustomTextField: UITextField {
    private lazy var inputFormatter: InputFormatter = {
        return InputFormatter()
    }()
    
    private lazy var sideView: SideView = {
        return SideView()
    }()
    
    open override func awakeFromNib() {
        NotificationCenter.default.addObserver(self, selector: #selector(textDidBeginEditing), name: UITextField.textDidBeginEditingNotification, object: self)
        
        NotificationCenter.default.addObserver(self, selector: #selector(textDidEndEditing), name: UITextField.textDidEndEditingNotification, object: self)
        //Set left and righ padding
        self.leftViewMode = .always
        self.rightViewMode = .always
        self.leftView = leftView ?? createDefaultSideView()
        self.rightView = rightView ?? createDefaultSideView()
        self.font = UIFont.textFieldFont
        self.tintColor = .appPrimaryColor
        self.borderWidth = 1
        isActive ? setActive() : setInactive()
        if backgroundColor == nil || backgroundColor == .clear {
            self.backgroundColor = .appBackgroundColor
        }
        adjustPlaceholderColor()
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        self.borderStyle = .none
        layer.shadowColor = UIColor.appShadowColor.cgColor
        layer.shadowRadius = 3
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize(width: 3, height: 3)
        clipsToBounds = false
        layer.masksToBounds = false
        superview?.layer.masksToBounds = false
    }
    
    private func adjustPlaceholderColor() {
        guard let placeholder else { return }
        let attributedPlaceholder = NSMutableAttributedString(string: placeholder)
        attributedPlaceholder.addAttribute(.foregroundColor, value: UIColor.appTextFieldPlaceholderColor, range: NSRange(location: 0, length: placeholder.count))
        self.attributedPlaceholder = attributedPlaceholder
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}

extension CustomTextField {
    private struct TextFieldState {
        static var active: Bool = false
    }
    
    @IBInspectable var activeByDefault: Bool {
        set {
            isActive = newValue
        } get {
            isActive
        }
    }
    
    @objc enum TextFieldFocus: Int {
        case active
        case inactive
    }
    
    @IBInspectable var defaultStatus: TextFieldFocus {
        set {
            TextFieldState.active = newValue == .active ? true : false
        } get {
            TextFieldState.active ? .active : .inactive
        }
    }
    
    var isActive: Bool {
        set {
            TextFieldState.active = newValue
            newValue ? setActive() : setInactive()
        } get {
            TextFieldState.active
        }
    }
    
    @objc private func textDidBeginEditing(_ sender: Notification) {
        setActive()
    }
    
    @objc private func textDidEndEditing(_ sender: Notification) {
        setInactive()
    }
    
    func setActive() {
        layer.borderColor = UIColor.appBorderThemeColor.cgColor
    }
    
    func setInactive() {
        layer.borderColor = UIColor.appBorderThemeColor.cgColor
        //        layer.borderColor = UIColor.appGrayButtonBorderColor.cgColor
        
    }
}

// AccessoryView
extension CustomTextField {
    @objc private func defaultSideViewTapped() {
        becomeFirstResponder()
    }
    
    private struct SideViewConstants {
        static var defaultPadding: CGFloat = 15
        static var sideViewHeight: CGFloat = 20
        static var sideViewWidth: CGFloat = 20
    }
    
    private struct SideView {
        var leftViewAction: ((UIImageView) -> ())?
        var rightViewAction: ((UIImageView) -> ())?
        
        var leftImage: UIImage?
        var rightImage: UIImage?
    }
    
    var onLeftViewTap: ((UIImageView) -> ())? {
        set {
            sideView.leftViewAction = newValue
        } get {
            return sideView.leftViewAction
        }
    }
    
    var onRightViewTap: ((UIImageView) -> ())? {
        set {
            sideView.rightViewAction = newValue
        } get {
            return sideView.rightViewAction
        }
    }
    
//    @IBInspectable var leftViewImage: UIImage? {
//        set {
//            sideView.leftImage = newValue
//            let imageView = createSideView(withImage: newValue)
//            imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onLeftViewTap(_:))))
//            setLeftView(imageView, padding: SideViewConstants.defaultPadding)
//        } get {
//            return sideView.leftImage
//        }
//    }
    
//    @IBInspectable var rightViewImage: UIImage? {
//        set {
//            sideView.rightImage = newValue
//            let imageView = createSideView(withImage: newValue)
//            imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onRightViewTap(_:))))
//            setRightView(imageView, padding: SideViewConstants.defaultPadding)
//        } get {
//            return sideView.rightImage
//        }
//    }
    
    @objc private func onLeftViewTap(_ sender: UIImageView) {
        onLeftViewTap?(sender)
    }
    
    @objc private func onRightViewTap(_ sender: UIImageView) {
        onRightViewTap?(sender)
    }
    
    private func createSideView(withImage image: UIImage?) -> UIImageView {
        let imageView = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: SideViewConstants.sideViewWidth, height: SideViewConstants.sideViewHeight)))
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        return imageView
    }
    
    private func createDefaultSideView() -> UIView {
        let emptyView = UIView(frame: CGRect(x: 0, y: 0, width: SideViewConstants.defaultPadding, height: frame.height))
        emptyView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(defaultSideViewTapped)))
        return emptyView
    }
}

//MARK: Masking
extension CustomTextField {
    private struct InputFormatter {
        var format: String?
        
//        func format(_ textField: UITextField) {
//            guard let format else { return }
//            textField.text = textField.text?.formatted(with: format)
//        }
    }
//    
//    @IBInspectable var inputFormat: String? {
//        set {
//            inputFormatter.format = newValue
//            self.addTarget(self, action: #selector(onTextChange), for: .editingChanged)
//        } get {
//            return inputFormatter.format
//        }
//    }
    
//    @objc private func onTextChange() {
//        guard inputFormatter.format != nil else { return }
//        inputFormatter.format(self)
//    }
}
