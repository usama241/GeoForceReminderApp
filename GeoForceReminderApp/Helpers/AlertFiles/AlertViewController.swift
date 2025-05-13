//
//  AlertViewController.swift
//  JSZindigi
//
//  Created by Anis Ur Rehman on 20/07/2023.
//

import UIKit
import Lottie

enum AlertIcon {
    case success
    case failure
    case attention
    case information
    case custom(UIImage)
}

class AlertViewController: UIViewController {
    var alertTitle: String? = nil
    var buttonTitle: String?
    var message: String? = nil
    var attributedMessage: NSAttributedString? = nil
    var icon: AlertIcon?
    var titleAnimation: String?
    var closeAction: (() -> Void)?
    var doneAction: (() -> Void)?
    @IBOutlet weak var crossButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var attributedMsgLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var animationView: LottieAnimationView!
    @IBOutlet weak var doneButton: PrimaryButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUIData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupUIData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        animationView.play()
    }
  
    
    @IBAction func doneAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func closeAction(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}

// MARK: - Private Functions
extension AlertViewController {
    fileprivate func setupUIData() {
        titleLabel.text = alertTitle
        messageLabel.text = message
        
        titleLabel.isHidden = (alertTitle ?? "").isEmpty
        messageLabel.isHidden = (message ?? "").isEmpty
        
        attributedMsgLabel.isHidden = !(attributedMessage != nil)
        messageLabel.isHidden = (attributedMessage != nil)
        attributedMsgLabel.attributedText = attributedMessage
        
        animationView.isHidden = true
        iconImageView.isHidden = true
        
        doneButton.setTitle(buttonTitle, for: .normal)
        if let titleAnimation { // User is going to animated title image
            let animation = LottieAnimation.named(titleAnimation)
            animationView.animation = animation
            animationView.animationSpeed = 10
            animationView.isHidden = false
        } else if let icon { // User is going to show static title image
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
            }
            iconImageView.isHidden = false
        }
    }
}
