//
//  DoubleActionAlertViewController.swift
//  JSZindigi
//
//  Created by Umar Awais on 08/08/2023.
//

import UIKit
import Lottie

enum AlertButtonStyle {
    case primary
    case secondary
    case dismissive
}

class DoubleActionAlertViewController: UIViewController {
    var alertTitle: String? = nil
    var message: String? = nil
    var attributedMessage: NSAttributedString? = nil
    var icon: AlertIcon?
    var titleAnimation: String?
    var closeAction: (() -> Void)?
    
    var cancelButtonTitle: String?
    var defaultButtonTitle: String?
    var cancelButtonStyle: AlertButtonStyle?
    var defaultButtonStyle: AlertButtonStyle?
    var cancelButtonAction: (() -> Void)?
    var defaultButtonAction: (() -> Void)?
    @IBOutlet weak var crossButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var animationView: LottieAnimationView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var defaultButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupUIData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        animationView.play()
    }
    
    @IBAction func closeAction(_ sender: UIButton) {
        closeAction?()
    }
    
    @IBAction func cancelButtonAction(_ sender: UIButton) {
        cancelButtonAction?()
    }
    
    @IBAction func defaultButtonAction(_ sender: UIButton) {
        defaultButtonAction?()
    }
}

// MARK: - Private Functions
fileprivate extension DoubleActionAlertViewController {
    func setupUIData() {
        titleLabel.text = alertTitle
        (message ?? "").isEmpty == false ? (messageLabel.text = message) : (messageLabel.attributedText = attributedMessage)
        
        titleLabel.isHidden = (alertTitle ?? "").isEmpty
        messageLabel.isHidden = (message ?? "").isEmpty && (attributedMessage?.length == .zero)
        
        cancelButton.setTitle(cancelButtonTitle, for: .normal)
        defaultButton.setTitle(defaultButtonTitle, for: .normal)
        setButtonStyle(on: cancelButton, style: cancelButtonStyle ?? .secondary)
        setButtonStyle(on: defaultButton, style: defaultButtonStyle ?? .primary)
         // User is going to show static title image
        switch icon {
            case .success:
                iconImageView.image = UIImage(named: "successIcon")
            case .failure:
                iconImageView.image = UIImage(named: "successIcon")
            case .custom(let image):
                iconImageView.image = image
            case .attention:
                iconImageView.image = UIImage(named: "attentionIcon")
            case .information:
                iconImageView.image = UIImage(named: "information")
        case .none:
            iconImageView.image = UIImage(named: "successIcon")
        }
            iconImageView.isHidden = false
    }
    
    func setButtonStyle(on button: UIButton, style: AlertButtonStyle) {
        button.layer.cornerRadius = 8
        switch style {
        case .primary:
            button.backgroundColor = .appPrimaryColor
            button.setTitleColor(.white, for: .normal)
            button.titleLabel?.font = UIFont.primaryButtonFont
        case .secondary:
            button.backgroundColor = .appSecondaryButtonColor
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.appSupportButtonBorderColor.cgColor
            button.setTitleColor(UIColor.appBackgroundReverseColor, for: .normal)
            button.titleLabel?.font = UIFont.secondaryButtonFont
        case .dismissive:
            button.backgroundColor = .appFailureColor
            button.setTitleColor(.white, for: .normal)
            button.titleLabel?.font = UIFont.secondaryButtonFont
        }
    }
}
