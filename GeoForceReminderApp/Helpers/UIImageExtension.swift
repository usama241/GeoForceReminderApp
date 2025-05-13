//
//  UIImageExtension.swift
//  JSZindigi
//
//  Created by Umar Awais on 31/07/2023.
//

import Foundation
import UIKit

extension UIImage {
    convenience init(color: UIColor, size: CGSize) {
        UIGraphicsBeginImageContextWithOptions(size, false, 1)
        color.set()
        let ctx = UIGraphicsGetCurrentContext()!
        ctx.fill(CGRect(origin: .zero, size: size))
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        self.init(data: image.pngData()!)!
    }
    
    func imageWithInsets(insets: UIEdgeInsets) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(
            CGSize(width: self.size.width + insets.left + insets.right,
                   height: self.size.height + insets.top + insets.bottom), false, self.scale)
        let _ = UIGraphicsGetCurrentContext()
        let origin = CGPoint(x: insets.left, y: insets.top)
        self.draw(at: origin)
        let imageWithInsets = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return imageWithInsets
    }
    
//    func flippedForRTL() -> UIImage? {
//        if Language.current == .urdu {
//            return self.withHorizontallyFlippedOrientation()
//        }
//        return self
//    }
    
    enum JPEGQuality: CGFloat {
        case lowest  = 0
        case low     = 0.25
        case medium  = 0.5
        case high    = 0.75
        case highest = 1
    }
    
    /// Returns the data for the specified image in JPEG format.
    /// If the image object’s underlying image data has been purged, calling this function forces that data to be reloaded into memory.
    /// - returns: A data object containing the JPEG data, or nil if there was a problem generating the data. This function may return nil if the image has no data or if the underlying CGImageRef contains data in an unsupported bitmap format.
    func jpeg(_ jpegQuality: JPEGQuality) -> Data? {
        return jpegData(compressionQuality: jpegQuality.rawValue)
    }
    
    func resized(withPercentage percentage: CGFloat, isOpaque: Bool = true) -> UIImage? {
        let canvas = CGSize(width: size.width * percentage, height: size.height * percentage)
        let format = imageRendererFormat
        format.opaque = isOpaque
        return UIGraphicsImageRenderer(size: canvas, format: format).image {
            _ in draw(in: CGRect(origin: .zero, size: canvas))
        }
    }
    
    func compress(to kb: Int, allowedMargin: CGFloat = 0.2) -> Data {
        let bytes = kb * 1024
        var compression: CGFloat = 1.0
        let step: CGFloat = 0.05
        var holderImage = self
        var complete = false
        while(!complete) {
            if let data = holderImage.jpegData(compressionQuality: 1.0) {
                let ratio = data.count / bytes
                if data.count < Int(CGFloat(bytes) * (1 + allowedMargin)) {
                    complete = true
                    return data
                } else {
                    let multiplier:CGFloat = CGFloat((ratio / 5) + 1)
                    compression -= (step * multiplier)
                }
            }
            
            guard let newImage = holderImage.resized(withPercentage: compression) else { break }
            holderImage = newImage
        }
        return Data()
    }
    static func load(url: URL, placeholder: UIImage? = nil, cache: URLCache? = nil) async -> UIImage {
        let cache = cache ?? URLCache.shared
        let request = URLRequest(url: url)
        if let data = cache.cachedResponse(for: request)?.data, let image = UIImage(data: data) {
            return image
        } else {
            do {
                let (data, response) = try await URLSession.shared.data(from: url)
                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode < 300, let image = UIImage(data: data) {
                    let cachedData = CachedURLResponse(response: httpResponse, data: data)
                    cache.storeCachedResponse(cachedData, for: request)
                    return image
                }
            } catch {
                print("Error loading image: \(error)")
            }
            return placeholder ?? UIImage()
        }
    }
    
}
    
// MARK: Compression
extension UIImage {
    func compressed(maxByte: Int, _ completion: @escaping (UIImage?) -> ()) {
        DispatchQueue.global(qos: .userInitiated).async {
            guard let currentImageSize = self.jpegData(compressionQuality: 1.0)?.count else {
                return completion(nil)
            }
            var iterationImage: UIImage? = self
            var iterationImageSize = currentImageSize
            var iterationCompression: CGFloat = 1.0
            while iterationImageSize > maxByte && iterationCompression > 0.01 {
                let percantageDecrease = self.getPercantageToDecrease(forDataCount: iterationImageSize)
                let canvasSize = CGSize(width: self.size.width * iterationCompression,
                                        height: self.size.height * iterationCompression)
                UIGraphicsBeginImageContextWithOptions(canvasSize, false, self.scale)
                defer { UIGraphicsEndImageContext() }
                self.draw(in: CGRect(origin: .zero, size: canvasSize))
                iterationImage = UIGraphicsGetImageFromCurrentImageContext()
                guard let newImageSize = iterationImage?.jpegData(compressionQuality: 1.0)?.count else {
                    return completion(nil)
                }
                iterationImageSize = newImageSize
                iterationCompression -= percantageDecrease
            }
            completion(iterationImage)
        }
    }
    
    private func getPercantageToDecrease(forDataCount dataCount: Int) -> CGFloat {
        switch dataCount {
        case 0..<3000000: return 0.05
        case 3000000..<10000000: return 0.1
        default: return 0.2
        }
    }
}


extension UIImage {

    /// Given a list of images, this methods adds their height and find the max width.
    /// ~~~
    /// let imagesArray: [UIImage] = […]
    /// let fullSize: CGSize = UIImage.verticalAppendedTotalImageSizeFromImagesArray(imagesArray: imagesArray)
    /// ~~~
    /// - Parameter imagesArray: The list of images to proccess
    /// - Returns: the added height of all the image by the biggest width in a CGSize struct
    class func verticalAppendedTotalImageSizeFromImagesArray(imagesArray: [UIImage]) -> CGSize {
        var totalSize = CGSize.zero
        for image in imagesArray {
            let imSize = image.size
            totalSize.height += imSize.height
            totalSize.width = max(totalSize.width, imSize.width)
        }
        return totalSize
    }

    /// Stitches verticaly all the images in the collection passed on. With the first on top an so on.
    /// ~~~
    /// let imagesArray: [UIImage] = […]
    /// let newImage: UIImage = UIImage.verticalImageFromArray(imagesArray: imagesArray)
    /// ~~~
    /// - Warning: If the function cannot instantiate a Graphics Context, the return value is nil
    /// - Parameter imagesArray: The list of images to proccess
    /// - Returns: a new image containing all the elementes from the collection passed
    class func verticalImageFromArray(imagesArray: [UIImage]) -> UIImage? {

        var unifiedImage: UIImage?
        let totalImageSize = self.verticalAppendedTotalImageSizeFromImagesArray(imagesArray: imagesArray)

        UIGraphicsBeginImageContextWithOptions(totalImageSize, false, 0)

        var imageOffsetFactor: CGFloat = 0

        for image in imagesArray {
            image.draw(at: CGPoint(x: 0, y: imageOffsetFactor))
            imageOffsetFactor += image.size.height
        }
        unifiedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return unifiedImage
    }
    
    /// Given a Color and a Size, this function creates a new Image
    /// ~~~
    /// UIImage.imageWithColor(color: .black, size: CGSize(width: 50,height: 50))
    /// ~~~
    /// - Warning: If the function cannot instantiate a Graphics Context, the return value is nil
    /// - Parameters:
    ///   - color: The color to fill the image
    ///   - size: The size for this image
    /// - Returns: An image filled with the given color
    class func imageWithColor(color: UIColor, size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }

        color.set()
        context.fill(CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
extension UIImage {
    func fixedOrientation() -> UIImage {
        
        if imageOrientation == .up {
            return self
        }
        
        var transform: CGAffineTransform = CGAffineTransform.identity
        
        switch imageOrientation {
        case .down, .downMirrored:
            transform = transform.translatedBy(x: size.width, y: size.height)
            transform = transform.rotated(by: CGFloat.pi)
        case .left, .leftMirrored:
            transform = transform.translatedBy(x: size.width, y: 0)
            transform = transform.rotated(by: CGFloat.pi / 2)
        case .right, .rightMirrored:
            transform = transform.translatedBy(x: 0, y: size.height)
            transform = transform.rotated(by: CGFloat.pi / -2)
        case .up, .upMirrored:
            break
        }
        
        switch imageOrientation {
        case .upMirrored, .downMirrored:
            transform = transform.translatedBy(x: size.width, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
        case .leftMirrored, .rightMirrored:
            transform = transform.translatedBy(x: size.height, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
        case .up, .down, .left, .right:
            break
        }
        
        if let cgImage = self.cgImage, let colorSpace = cgImage.colorSpace,
            let ctx: CGContext = CGContext(data: nil, width: Int(size.width), height: Int(size.height), bitsPerComponent: cgImage.bitsPerComponent, bytesPerRow: 0, space: colorSpace, bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue) {
            ctx.concatenate(transform)
            
            switch imageOrientation {
            case .left, .leftMirrored, .right, .rightMirrored:
                ctx.draw(cgImage, in: CGRect(x: 0, y: 0, width: size.height, height: size.width))
            default:
                ctx.draw(cgImage, in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
            }
            if let ctxImage: CGImage = ctx.makeImage() {
                return UIImage(cgImage: ctxImage)
            } else {
                return self
            }
        } else {
            return self
        }
    }
}
