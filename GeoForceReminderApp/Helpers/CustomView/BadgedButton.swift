//
//  BadgedButton.swift
//  JSZindigi
//
//  Created by Anis Ur Rehman on 24/07/2023.
//

import UIKit

class BadgedButton: UIView {
    private var badgeLabel: UILabel!
    private var button: UIButton!
    
    var isBorder : Bool = true {
        didSet {
            addButtonBorder()
        }
    }
    
    var image: UIImage? {
        didSet {
            button.setImage(image, for: .normal)
        }
    }
    
    var badge: Int? {
        didSet {
            addBadgeToButon(badge: badge)
        }
    }

    public var badgeBackgroundColor = UIColor.appBadgeColor {
        didSet {
            badgeLabel.backgroundColor = badgeBackgroundColor
        }
    }
    
    public var badgeTextColor = UIColor.white {
        didSet {
            badgeLabel.textColor = badgeTextColor
        }
    }
    
    public var badgeFont = UIFont.badgeFont {
        didSet {
            badgeLabel.font = badgeFont
        }
    }
        
    override init(frame: CGRect) {
        button = UIButton(frame: frame)
        badgeLabel = UILabel(frame: CGRect(x: -8, y: frame.height - 8, width: 16, height: 16))
        
        super.init(frame: frame)
        
        self.addSubview(button)
        self.addSubview(badgeLabel)
        
        self.addBadgeToButon(badge: nil)
        addButtonBorder()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.addBadgeToButon(badge: nil)
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init() {
        self.init(frame: CGRect(x: 0, y: 0, width: 35, height: 35))
    }
    
    func addTarget(_ target: Any?, action: Selector) {
        button.addTarget(target, action: action, for: .touchUpInside)
    }
    
    func addBadgeToButon(badge: Int?) {
        let badgeText = badge != nil ? "\(badge!)" : ""
        badgeLabel.text =  badgeText
        badgeLabel.textColor = badgeTextColor
        badgeLabel.backgroundColor = badgeBackgroundColor
        badgeLabel.font = badgeFont
        badgeLabel.textAlignment = .center
        badgeLabel.layer.cornerRadius = 8
        badgeLabel.layer.masksToBounds = true
        badgeLabel.isHidden = badge != nil ? false : true
    }
    
    private func addButtonBorder() {
//        button.setRoundedBorder(color: isBorder == true ? .appCellBadgeBorderColor : .white)
    }
    
    override func layoutSubviews() {
        button.frame = self.bounds
        badgeLabel.frame = CGRect(x: frame.width - 8, y: -4, width: 16, height: 16)
    }
}
