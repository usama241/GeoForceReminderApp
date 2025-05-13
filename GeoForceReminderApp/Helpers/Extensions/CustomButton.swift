//
//  CustomButton.swift
//  JSZindigi
//
//  Created by Umar Awais on 13/07/2023.
//


import UIKit


open class PrimaryButton: UIButton {
    
    private var _title: String?
    private var _image: UIImage?
    private var customView: UIStackView?
    
    open override var isEnabled: Bool {
        didSet {
            updateCustomBackgroundView()
            setNeedsDisplay()
        }
    }
    
    open override func setTitle(_ title: String?, for state: UIControl.State) {
        _title = title
        updateCustomBackgroundView()
    }
    
    open override func setImage(_ image: UIImage?, for state: UIControl.State) {
        _image = image
        imageView?.image = image
        updateCustomBackgroundView()
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        addCustomBackgroundView()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        addCustomBackgroundView()
        customView?.frame = CGRect(x: 30, y: 10, width: frame.width - 60, height: frame.height - 20)
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override open func layoutSubviews() {
        if _title == nil || _image == nil {
            customView?.frame = CGRect(x: 0, y: 10, width: frame.width, height: frame.height - 20)
        } else {
            customView?.frame = CGRect(x: 30, y: 10, width: frame.width - 50, height: frame.height - 20)
        }
        self.setLayer()
    }
}





//MARK: Custom Background View
extension PrimaryButton {
    
    private func addCustomBackgroundView() {
        customView = UIStackView()
        customView?.axis = .horizontal
        customView?.spacing = 30
        customView?.alignment = .center
        customView?.distribution = .equalSpacing
        customView?.isUserInteractionEnabled = false
        addSubview(customView!)
        self.titleLabel?.isHidden = true
        self.imageView?.isHidden = true
        updateCustomBackgroundView()
    }
    
    @MainActor
    private func updateCustomBackgroundView() {
        customView?.arrangedSubviews.forEach({ $0.removeFromSuperview() })
        if let title = _title ?? currentTitle {
            _title = title
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 14.0)
            label.text = title
            label.textColor = isEnabled ? .white : .black
            label.numberOfLines = 1
            label.sizeToFit()
            label.textAlignment = .center
            customView?.addArrangedSubview(label)
        }
        if let image = _image ?? currentImage ?? imageView?.image {
            _image = image
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
            let tintColor = isEnabled ? UIColor.white : UIColor.black
            imageView.tintColor = tintColor
            imageView.image = image
            imageView.contentMode = .scaleAspectFit
            customView?.addArrangedSubview(imageView)
        }
    }
    
    open override func setTitleColor(_ color: UIColor?, for state: UIControl.State) {
        
        for uiview in customView?.arrangedSubviews ?? [] {
            if uiview is UILabel {
                (uiview as! UILabel).textColor = color
                break
            }
        }
    }
    
    func setImageColor(_ color: UIColor?) {
        
        for uiview in customView?.arrangedSubviews ?? [] {
            if uiview is UIImageView {
                (uiview as! UIImageView).tintColor = color
                break
            }
        }
    }
}


//MARK: Layer Customizatiom
extension PrimaryButton {
    
    private func setLayer() {
//        clipsToBounds = true
        layer.cornerRadius = 8.0
        layer.borderWidth = 0.6
//        self.shadowColor = .appShadowColor.withAlphaComponent(0.8)
        
        if isEnabled {
            backgroundColor = UIColor.black
            setActiveLayer()
        } else {
            backgroundColor = UIColor.black
            setInactiveLayer()
        }
    }
    
    private func setActiveLayer() {
        layer.borderColor = UIColor.black.cgColor
    }
    
    private func setInactiveLayer() {
        layer.borderColor = UIColor.black.cgColor
    }
    
}
