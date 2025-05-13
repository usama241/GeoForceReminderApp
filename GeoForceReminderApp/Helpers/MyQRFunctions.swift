//
//  MyQRFunctions.swift
//  VCCustomerApp
//
//  Created by MacBook Pro on 07/05/2025.
//

import Foundation
import UIKit
import QRCode

class MyQRFunctions {
    
    static let shared = MyQRFunctions()
    
    private init() {}
    
    // MARK: - Increasing original QR Image size
    
    func increaseQRImageSize(_ qrImage: UIImage, by scale: CGFloat) -> UIImage? {
        let size = qrImage.size.applying(CGAffineTransform(scaleX: scale, y: scale))
        let renderer = UIGraphicsImageRenderer(size: size)
        let scaledImage = renderer.image { _ in
            qrImage.draw(in: CGRect(origin: .zero, size: size))
        }
        return scaledImage
    }
    
    
    // MARK: - Generating QR Image from String
    
    func generateQRCode(from string: String) -> UIImage? {
        let doc = QRCode.Document(utf8String: string, errorCorrection: .high )
        doc.errorCorrection = .medium
        doc.design.style.eye = QRCode.FillStyle.Solid(UIColor(rgbaHex: "#40CECE")!.cgColor)
        doc.design.style.pupil = QRCode.FillStyle.Solid(UIColor(rgbaHex: "#FF725E")!.cgColor)
        doc.design.shape.onPixels = QRCode.PixelShape.Circle()
        
        return doc.uiImage(CGSize(width: 800, height: 800))
    }
    
    func generateZQRCode(from string: String) -> UIImage? {
        // Validate the input string
        guard !string.isEmpty else {
            print("Error: Input string is empty.")
            return nil
        }
        // Create the QRCode.Document
        let doc = QRCode.Document(utf8String: string, errorCorrection: .high)
        doc.errorCorrection = .medium
        doc.design.style.eye = QRCode.FillStyle.Solid(UIColor(rgbaHex: "#40CECE")!.cgColor)
        doc.design.style.pupil = QRCode.FillStyle.Solid(UIColor(rgbaHex: "#FF725E")!.cgColor)
        doc.design.shape.onPixels = QRCode.PixelShape.Circle()
        
        // Generate the UIImage with a specified size
        let qrImage = doc.uiImage(CGSize(width: 800, height: 800))
        
        // Validate the resulting image
        if let qrImage = qrImage, qrImage.size.width > 0, qrImage.size.height > 0 {
            return qrImage
        } else {
            print("Error: QR code generation failed. Resulting image has invalid size.")
            return nil
        }
    }
    
}

extension UILabel {
    
    var mutableAttributedString: NSMutableAttributedString? {
           let attributedString: NSMutableAttributedString
           if let labelattributedText = self.attributedText {
               attributedString = NSMutableAttributedString(attributedString: labelattributedText)
           } else {
               guard let labelText = self.text else { return nil }
               let paragraphStyle = NSMutableParagraphStyle()
               paragraphStyle.alignment = self.textAlignment
               attributedString = NSMutableAttributedString(string: labelText)
               attributedString.addAttribute(NSAttributedString.Key.paragraphStyle,
                                             value: paragraphStyle,
                                             range: NSRange(location: 0, length: attributedString.length))
           }
           return attributedString
       }

    func addImage(_ image: UIImage, toEndWith height: CGFloat) {
           let fullAttributedString = mutableAttributedString
           let imageAttachment = NSTextAttachment()
           imageAttachment.image = image

           let yImage = (font.capHeight - height).rounded() / 2
           let ratio = image.size.width / image.size.height
           imageAttachment.bounds = CGRect(x: 0, y: yImage, width: ratio * height, height: height)

           let imageString = NSAttributedString(attachment: imageAttachment)
           fullAttributedString?.append(imageString)
           attributedText = fullAttributedString
       }
    
}

