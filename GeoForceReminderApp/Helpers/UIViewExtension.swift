//
//  UIViewExtension.swift
//  JSZindigi
//
//  Created by Anis Ur Rehman on 14/07/2023.
//

import Foundation
import UIKit
import SwiftConfettiView

fileprivate let borderWidth: CGFloat = 1
fileprivate let cornerRadius: CGFloat = 8

extension UIView {
    func addGradient(startColor: UIColor, endColor: UIColor) {
        let gradientLayer:CAGradientLayer = CAGradientLayer()
        gradientLayer.frame.size = self.frame.size
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func addShadow(offset: CGSize, color: UIColor, radius: CGFloat, opacity: Float) {
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        layer.masksToBounds = false
        let rect = bounds.insetBy(dx: 1, dy: 1)
        layer.shadowPath = UIBezierPath(roundedRect: rect, cornerRadius: 8).cgPath
    }
    
    func addDashes(fill: CGFloat = 1, backgroundColor: UIColor = .appCellBorderColor, fillColor: UIColor = .appPrimaryColor, dashesPattern: [NSNumber] = [8,7]) {
        removeDashes()
        let backLayer = CAShapeLayer()
        backLayer.name = "DashedBackLine"
        backLayer.bounds = bounds
        backLayer.position = CGPoint(x: frame.width / 2, y: frame.height / 2)
        backLayer.fillColor = UIColor.clear.cgColor
        backLayer.strokeColor = backgroundColor.cgColor
        backLayer.lineWidth = bounds.height
        backLayer.lineJoin = .round
        backLayer.lineDashPattern = dashesPattern
        let backLayerPath = CGMutablePath()
        backLayerPath.move(to: CGPoint.zero)
        backLayerPath.addLine(to: CGPoint(x: frame.width, y: 0))
        backLayer.path = backLayerPath
        layer.addSublayer(backLayer)
        
        let frontLayer = CAShapeLayer()
        frontLayer.name = "DashedFrontLine"
        frontLayer.bounds = bounds
        let frontLayerFrame = CGRect(origin: bounds.origin, size: CGSize(width: bounds.width * fill, height: bounds.height))
        frontLayer.position = CGPoint(x: frame.width / 2, y: frame.height / 2)
        frontLayer.fillColor = UIColor.clear.cgColor
        frontLayer.strokeColor = fillColor.cgColor
        frontLayer.lineWidth = bounds.height
        frontLayer.lineJoin = .round
        frontLayer.lineDashPattern = dashesPattern
        let frontLayerPath = CGMutablePath()
        frontLayerPath.move(to: CGPoint.zero)
        frontLayerPath.addLine(to: CGPoint(x: frontLayerFrame.width, y: 0))
        frontLayer.path = frontLayerPath
        layer.addSublayer(frontLayer)
    }
    
    func removeDashes() {
        layer.sublayers?.filter({ $0.name == "DashedFrontLine" }).forEach({ $0.removeFromSuperlayer() })
        layer.sublayers?.filter({ $0.name == "DashedBackLine" }).forEach({ $0.removeFromSuperlayer() })
    }
}

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    @IBInspectable var shadowColor: UIColor? {
        get {
            return UIColor(cgColor: layer.shadowColor!)
        }
        set {
            layer.shadowColor = newValue?.cgColor
            layer.shadowRadius = 3
            layer.shadowOpacity = 1
            layer.shadowOffset = CGSize(width: 3, height: 3)
            clipsToBounds = false
            layer.masksToBounds = false
            superview?.layer.masksToBounds = false
        }
    }
    
    func setRoundedBorder(cornerRadius: Double = 6, color: UIColor, borderWidth: Double = 1) {
        self.layer.cornerRadius = cornerRadius
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = borderWidth
        //        self.layer.masksToBounds = true
    }
}
extension UIView {
    var snapshot: UIImage {
        return UIGraphicsImageRenderer(size: bounds.size).image { _ in
            drawHierarchy(in: bounds, afterScreenUpdates: true)
        }
    }
}


extension UIView {
    /// Return an `UIImage`with the visible contents inside the Cropping Rect
    /// - Parameter croppingRect: a rect to focus the screenshot
    /// - Returns: an `UIImage` with the visible contents inside the cropping rect
    func screenshotForCroppingRect(croppingRect: CGRect) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(croppingRect.size, false, UIScreen.main.scale)
        
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        
        context.translateBy(x: -croppingRect.origin.x, y: -croppingRect.origin.y)
        self.layoutIfNeeded()
        self.layer.render(in: context)
        
        let screenshotImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return screenshotImage
    }
    
    /// Returns a screenshot as `UIImage` from the whole view
    @objc public var screenshot: UIImage? {
        return self.screenshotForCroppingRect(croppingRect: self.bounds)
    }
}

// MARK: Confetti
extension UIView {
    private struct Confetti {
        static var view: SwiftConfettiView? {
            didSet {
                if let view {
                    view.type = .confetti
                    view.intensity = 0.5
                    view.colors = [
                        UIColor.red,
                        UIColor.green,
                        UIColor.yellow,
                        UIColor.blue
                    ].map({ $0.withAlphaComponent(0.7) })
                }
            }
        }
    }
    
    func addConfetti(forSeconds seconds: TimeInterval = 6) {
        Confetti.view = SwiftConfettiView(frame: bounds)
        Confetti.view?.startConfetti()
        addSubview(Confetti.view!)
        if seconds > 0 {
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) { [weak self] in
                self?.removeConfetti()
            }
        }
    }
    
    func removeConfetti() {
        Confetti.view?.stopConfetti()
        Confetti.view?.removeFromSuperview()
        Confetti.view = nil
    }
}

extension UIView{
    
    @IBInspectable
    var isCircle: Bool{
        get {
            return self.isCircle
        }
        set {
            if newValue {
                self.clipsToBounds = true
                self.layer.cornerRadius = self.layer.bounds.width/2
            }else{
                self.layer.cornerRadius = 0
            }
        }
    }
    
    func addTopBorder(with color: UIColor?, andWidth borderWidth: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
        border.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: borderWidth)
        addSubview(border)
    }
    
    func addBottomBorder(with color: UIColor?, andWidth borderWidth: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        border.frame = CGRect(x: 0, y: frame.size.height - borderWidth, width: frame.size.width, height: borderWidth)
        addSubview(border)
    }
    
    func addLeftBorder(with color: UIColor?, andWidth borderWidth: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.frame = CGRect(x: 0, y: 0, width: borderWidth, height: frame.size.height)
        border.autoresizingMask = [.flexibleHeight, .flexibleRightMargin]
        addSubview(border)
    }
    
    func addRightBorder(with color: UIColor?, andWidth borderWidth: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.autoresizingMask = [.flexibleHeight, .flexibleLeftMargin]
        border.frame = CGRect(x: frame.size.width - borderWidth, y: 0, width: borderWidth, height: frame.size.height)
        addSubview(border)
    }
    
    
    func roundedCorners2(corners : UIRectCorner, radius : CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    func roundCorners(with CACornerMask: CACornerMask, radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.maskedCorners = [CACornerMask]
    }
    
    
    func borders(for edges:[UIRectEdge], width:CGFloat = 1, color: UIColor = .black) {
        
        if edges.contains(.all) {
            layer.borderWidth = width
            layer.borderColor = color.cgColor
        } else {
            let allSpecificBorders:[UIRectEdge] = [.top, .bottom, .left, .right]
            
            for edge in allSpecificBorders {
                if let v = viewWithTag(Int(edge.rawValue)) {
                    v.removeFromSuperview()
                }
                
                if edges.contains(edge) {
                    let v = UIView()
                    v.tag = Int(edge.rawValue)
                    v.backgroundColor = color
                    v.translatesAutoresizingMaskIntoConstraints = false
                    addSubview(v)
                    
                    var horizontalVisualFormat = "H:"
                    var verticalVisualFormat = "V:"
                    
                    switch edge {
                    case UIRectEdge.bottom:
                        horizontalVisualFormat += "|-(0)-[v]-(0)-|"
                        verticalVisualFormat += "[v(\(width))]-(0)-|"
                    case UIRectEdge.top:
                        horizontalVisualFormat += "|-(0)-[v]-(0)-|"
                        verticalVisualFormat += "|-(0)-[v(\(width))]"
                    case UIRectEdge.left:
                        horizontalVisualFormat += "|-(0)-[v(\(width))]"
                        verticalVisualFormat += "|-(0)-[v]-(0)-|"
                    case UIRectEdge.right:
                        horizontalVisualFormat += "[v(\(width))]-(0)-|"
                        verticalVisualFormat += "|-(0)-[v]-(0)-|"
                    default:
                        break
                    }
                    
                    self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: horizontalVisualFormat, options: .directionLeadingToTrailing, metrics: nil, views: ["v": v]))
                    self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: verticalVisualFormat, options: .directionLeadingToTrailing, metrics: nil, views: ["v": v]))
                }
            }
        }
    }
    
    
}


extension CALayer {
    
    func addBorder(edge: UIRectEdge, color: UIColor, thickness: CGFloat) {
        
        let border = CALayer();
        
        switch edge {
        case UIRectEdge.top:
            border.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: thickness);
            break
        case UIRectEdge.bottom:
            border.frame = CGRect(x: 0, y: self.frame.height - thickness, width: self.frame.width, height: thickness)
            break
        case UIRectEdge.left:
            border.frame = CGRect(x: 0, y: 0, width: thickness, height: self.frame.height)
            break
        case UIRectEdge.right:
            border.frame = CGRect(x: self.frame.width - thickness, y: 0, width: thickness, height: self.frame.height)
            break
        default:
            break
        }
        
        border.backgroundColor = color.cgColor;
        
        self.addSublayer(border)
    }
    
}

extension CAGradientLayer {
    
    enum Point {
        case topRight, topLeft
        case bottomRight, bottomLeft
        case custion(point: CGPoint)
        
        var point: CGPoint {
            switch self {
            case .topRight: return CGPoint(x: 1, y: 0)
            case .topLeft: return CGPoint(x: 0, y: 0)
            case .bottomRight: return CGPoint(x: 1, y: 1)
            case .bottomLeft: return CGPoint(x: 0, y: 1)
            case .custion(let point): return point
            }
        }
    }
    
    convenience init(frame: CGRect, colors: [UIColor], startPoint: CGPoint, endPoint: CGPoint) {
        self.init()
        self.frame = frame
        self.colors = colors.map { $0.cgColor }
        self.startPoint = startPoint
        self.endPoint = endPoint
    }
    
    convenience init(frame: CGRect, colors: [UIColor], startPoint: Point, endPoint: Point) {
        self.init(frame: frame, colors: colors, startPoint: startPoint.point, endPoint: endPoint.point)
    }
    
    func createGradientImage() -> UIImage? {
        defer { UIGraphicsEndImageContext() }
        UIGraphicsBeginImageContext(bounds.size)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        render(in: context)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}

//extension UIView{
//    func EmptyAddressView() -> EmptyAddressView {
//        return UINib(nibName: "EmptyAddressView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! EmptyAddressView
//    }
//    func EmptyCartView() -> EmptyCartView {
//        return UINib(nibName: "EmptyCartView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! EmptyCartView
//    }
////    func EmptyCategoryView() -> EmptyCategoryView {
////        return UINib(nibName: "EmptyCategoryView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! EmptyCategoryView
////    }
//
//    func EmptyReviewView() -> EmptyReviewView {
//        return UINib(nibName: "EmptyReviewView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! EmptyReviewView
//    }
//    func EmptyWishlistView() -> EmptyWishlistView {
//        return UINib(nibName: "EmptyWishlistView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! EmptyWishlistView
//    }
//
//    func ServerErrorView() -> ServerErrorView {
//        return UINib(nibName: "ServerErrorView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! ServerErrorView
//    }
//
//}

extension UIView {
    
    func addDashedBorder() {
        let path = UIBezierPath()
        // >> define the pattern & apply it
        let dashPattern: [CGFloat] = [4.0, 4.0]
        path.setLineDash(dashPattern, count: dashPattern.count, phase: 0)
        // <<
        path.lineWidth = 1
        
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: 100, y: 100))
        path.stroke()
    }
    
    func addDashBorder(color:UIColor, cornerRadius: CGFloat) {
        let color = color.cgColor
        
        let shapeLayer:CAShapeLayer = CAShapeLayer()
        
        let frameSize = self.frame.size
        let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height)
        
        shapeLayer.bounds = shapeRect
        shapeLayer.name = "DashBorder"
        shapeLayer.position = CGPoint(x: frameSize.width/2, y: frameSize.height/2)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color
        shapeLayer.lineWidth = 1.5
        shapeLayer.lineJoin = .round
        shapeLayer.lineDashPattern = [2,4]
        shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: cornerRadius).cgPath
        
        self.layer.masksToBounds = true
        
        self.layer.addSublayer(shapeLayer)
    }
}

extension UIView {
    func addDashedLine(color: UIColor = .lightGray) {
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = 4
        // passing an array with the values [2,3] sets a dash pattern that alternates between a 2-user-space-unit-long painted segment and a 3-user-space-unit-long unpainted segment
        shapeLayer.lineDashPattern = [5,3]
        
        let path = CGMutablePath()
        path.addLines(between: [CGPoint(x: 0, y: 0),
                                CGPoint(x: self.frame.width, y: 0)])
        shapeLayer.path = path
        layer.addSublayer(shapeLayer)
    }
}

extension UIView {
    func shake(){
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 3
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 5, y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 5, y: self.center.y))
        self.layer.add(animation, forKey: "position")
    }
    
    @IBInspectable var shadow: Bool {
        get {
            return layer.shadowOpacity > 0.0
        }
        set {
            if newValue == true {
                self.addShadow()
            }
        }
    }
    
    func addShadow(shadowColor: CGColor = UIColor.black.cgColor,
                   shadowOffset: CGSize = CGSize(width: 1.0, height: 2.0),
                   shadowOpacity: Float = 0.4,
                   shadowRadius: CGFloat = 3.0) {
        layer.shadowColor = shadowColor
        layer.shadowOffset = shadowOffset
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
    }
    //    enum cornerSide {
    //        case left,right,top,bottom
    //    }
    func roundCorners(_ corners: CACornerMask, radius: CGFloat, borderColor: UIColor, borderWidth: CGFloat) {
        
        self.layer.maskedCorners = corners
        self.layer.cornerRadius = radius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
    }
    
    @IBInspectable var shadowOpacity: Float{
        set {
            layer.shadowOpacity = newValue
        }
        get{
            return layer.shadowOpacity
        }
    }
    
    @IBInspectable var shadowOffset: CGSize{
        set {
            layer.shadowOffset = newValue
        }
        get{
            return layer.shadowOffset
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat{
        set {
            layer.shadowRadius = newValue
        }
        get{
            return layer.shadowRadius
        }
    }
}
