//
//  RedirectHelper.swift
//
//  Created by Usama  on 2022/5/2.
//

 import UIKit
 import SDWebImage
 import ImageIO
 import Photos
import SVGKit

 extension UIImageView{
    func downloadImage(url:String){
        //remove space if a url contains.
        let stringWithoutWhitespace = url.replacingOccurrences(of: " ", with: "%20", options: .regularExpression)
        self.sd_imageIndicator = SDWebImageActivityIndicator.gray
        self.sd_setImage(with: URL(string: stringWithoutWhitespace), placeholderImage: UIImage(named: ""))
    }
 }
 extension UIImageView{
    //MARK:- Animate check mark
    func flipImage(withImage:UIImage, closure: @escaping () -> Void){
        UIView.animate(withDuration: 0.1, delay: 0.1, options: .curveLinear, animations: {
            self.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            
            
        }) { (success) in
            UIView.animate(withDuration: 0.1, delay: 0, options: .curveLinear, animations: {
                self.image = withImage
                //to-do
                closure()
                self.transform = .identity
            }, completion: nil)
        }
        
    }
 }


extension UIImageView {
    @discardableResult
    func load(url: URL, placeholder: UIImage?, cache: URLCache? = nil) async -> Bool {
        let cache = cache ?? URLCache.shared
        let request = URLRequest(url: url)
        if let data = cache.cachedResponse(for: request)?.data, let image = UIImage(data: data) {
            self.image = image
            return true
        } else {
            self.image = placeholder
            do {
                let (data, response) = try await URLSession.shared.data(from: url)
                if let image = UIImage(data: data), (response as? HTTPURLResponse)?.statusCode ?? 500 < 300 {
                    let cachedData = CachedURLResponse(response: response, data: data)
                    cache.storeCachedResponse(cachedData, for: request)
                    await MainActor.run {[weak self] in
                        self?.image = image
                    }
                    return true
                } else {
                    return false
                }
            } catch {
                print("Error loading image: \(error)")
                return false
            }
        }
    }
    
    func load(url: URL, cache: URLCache? = nil) {
        let cache = cache ?? URLCache.shared
        let request = URLRequest(url: url, cachePolicy: .reloadRevalidatingCacheData)
        //TODO: Commented code temporarily
        if let data = cache.cachedResponse(for: request)?.data {
            DispatchQueue.main.async { [weak self] in
                if url.pathExtension.lowercased() == "svg" {
                    guard let image = SVGKImage(data: data) else { return }
                    self?.image = image.uiImage
                } else {
                    guard let image = UIImage(data: data) else { return }
                    self?.image = image
                }
            }
        } else {
            URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                if let data = data, let response = response, ((response as? HTTPURLResponse)?.statusCode ?? 500) < 300 {
                    let cachedData = CachedURLResponse(response: response, data: data)
                    cache.storeCachedResponse(cachedData, for: request)
                    DispatchQueue.main.async { [weak self] in
                        if url.pathExtension.lowercased() == "svg" {
                            guard let image = SVGKImage(data: data) else { return }
                            self?.image = image.uiImage
                        } else {
                            guard let image = UIImage(data: data) else { return }
                            self?.image = image
                        }
                    }
                }
            }).resume()
        }
    }
}


 
extension UIImage {
    
    func rotate(radians: CGFloat) -> UIImage {
        let rotatedSize = CGRect(origin: .zero, size: size)
            .applying(CGAffineTransform(rotationAngle: CGFloat(radians)))
            .integral.size
        UIGraphicsBeginImageContext(rotatedSize)
        if let context = UIGraphicsGetCurrentContext() {
            let origin = CGPoint(x: rotatedSize.width / 2.0,
                                 y: rotatedSize.height / 2.0)
            context.translateBy(x: origin.x, y: origin.y)
            context.rotate(by: radians)
            draw(in: CGRect(x: -origin.x, y: -origin.y,
                            width: size.width, height: size.height))
            let rotatedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            return rotatedImage ?? self
        }
        
        return self
    }
    
}
 
 
 // FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
 // Consider refactoring the code to use the non-optional operators.
 fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l < r
    case (nil, _?):
        return true
    default:
        return false
    }
 }
 
 
 
 extension UIImage {
    
    
    public class func gifImageWithData(_ data: Data) -> UIImage? {
        guard let source = CGImageSourceCreateWithData(data as CFData, nil) else {
            print("image doesn't exist")
            return nil
        }
        
        return UIImage.animatedImageWithSource(source)
    }
    
    public class func gifImageWithURL(_ gifUrl:String) -> UIImage? {
        guard let bundleURL:URL = URL(string: gifUrl)
            else {
                print("image named \"\(gifUrl)\" doesn't exist")
                return nil
        }
        guard let imageData = try? Data(contentsOf: bundleURL) else {
            print("image named \"\(gifUrl)\" into NSData")
            return nil
        }
        
        return gifImageWithData(imageData)
    }
    
    public class func gifImageWithName(_ name: String) -> UIImage? {
        guard let bundleURL = Bundle.main
            .url(forResource: name, withExtension: "gif") else {
                print("SwiftGif: This image named \"\(name)\" does not exist")
                return nil
        }
        guard let imageData = try? Data(contentsOf: bundleURL) else {
            print("SwiftGif: Cannot turn image named \"\(name)\" into NSData")
            return nil
        }
        
        return gifImageWithData(imageData)
    }
    
    class func delayForImageAtIndex(_ index: Int, source: CGImageSource!) -> Double {
        var delay = 0.1
        
        let cfProperties = CGImageSourceCopyPropertiesAtIndex(source, index, nil)
        let gifProperties: CFDictionary = unsafeBitCast(
            CFDictionaryGetValue(cfProperties,
                                 Unmanaged.passUnretained(kCGImagePropertyGIFDictionary).toOpaque()),
            to: CFDictionary.self)
        
        var delayObject: AnyObject = unsafeBitCast(
            CFDictionaryGetValue(gifProperties,
                                 Unmanaged.passUnretained(kCGImagePropertyGIFUnclampedDelayTime).toOpaque()),
            to: AnyObject.self)
        if delayObject.doubleValue == 0 {
            delayObject = unsafeBitCast(CFDictionaryGetValue(gifProperties,
                                                             Unmanaged.passUnretained(kCGImagePropertyGIFDelayTime).toOpaque()), to: AnyObject.self)
        }
        
        delay = delayObject as! Double
        
        if delay < 0.1 {
            delay = 0.1
        }
        
        return delay
    }
    
    class func gcdForPair(_ a: Int?, _ b: Int?) -> Int {
        var a = a
        var b = b
        if b == nil || a == nil {
            if b != nil {
                return b!
            } else if a != nil {
                return a!
            } else {
                return 0
            }
        }
        
        if a < b {
            let c = a
            a = b
            b = c
        }
        
        var rest: Int
        while true {
            rest = a! % b!
            
            if rest == 0 {
                return b!
            } else {
                a = b
                b = rest
            }
        }
    }
    
    class func gcdForArray(_ array: Array<Int>) -> Int {
        if array.isEmpty {
            return 1
        }
        
        var gcd = array[0]
        
        for val in array {
            gcd = UIImage.gcdForPair(val, gcd)
        }
        
        return gcd
    }
    
    class func animatedImageWithSource(_ source: CGImageSource) -> UIImage? {
        let count = CGImageSourceGetCount(source)
        var images = [CGImage]()
        var delays = [Int]()
        
        for i in 0..<count {
            if let image = CGImageSourceCreateImageAtIndex(source, i, nil) {
                images.append(image)
            }
            
            let delaySeconds = UIImage.delayForImageAtIndex(Int(i),
                                                            source: source)
            delays.append(Int(delaySeconds * 1000.0)) // Seconds to ms
        }
        
        let duration: Int = {
            var sum = 0
            
            for val: Int in delays {
                sum += val
            }
            
            return sum
        }()
        
        let gcd = gcdForArray(delays)
        var frames = [UIImage]()
        
        var frame: UIImage
        var frameCount: Int
        for i in 0..<count {
            frame = UIImage(cgImage: images[Int(i)])
            frameCount = Int(delays[Int(i)] / gcd)
            
            for _ in 0..<frameCount {
                frames.append(frame)
            }
        }
        
        let animation = UIImage.animatedImage(with: frames,
                                              duration: Double(duration) / 8000.0)
        
        return animation
    }
 }
 
 extension UIImage{
     //Draws the top indicator by making image with filling color
     class func drawTabBarIndicator(color: UIColor, size: CGSize, onTop: Bool) -> UIImage {
         let indicatorHeight = size.height / 15
         let yPosition = onTop ? 0 : (size.height - indicatorHeight)
         
         UIGraphicsBeginImageContextWithOptions(size, false, 0)
         color.setFill()
         UIRectFill(CGRect(x: 0, y: yPosition, width: size.width, height: indicatorHeight))
         let image = UIGraphicsGetImageFromCurrentImageContext()
         UIGraphicsEndImageContext()
         
         return image!
     }
 }

 extension PHAsset {
 func getAssetThumbnail() -> UIImage {
     let manager = PHImageManager.default()
     let option = PHImageRequestOptions()
     var thumbnail = UIImage()
     option.isSynchronous = true
     manager.requestImage(for: self,
                          targetSize: CGSize(width: self.pixelWidth, height: self.pixelHeight),
                          contentMode: .aspectFit,
                          options: option,
                          resultHandler: {(result, info) -> Void in
                             thumbnail = result!
                          })
     return thumbnail
     }
 }

// MARK: Compression
extension UIImage {
    
    static func loadImage(url: URL, cache: URLCache? = nil) async -> UIImage? {
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
            return nil
        }
    }
    
    private func getPercantageToDecrease(forDataCount dataCount: Int) -> CGFloat {
        switch dataCount {
        case 0..<3000000: return 0.05
        case 3000000..<10000000: return 0.1
        default: return 0.2
        }
    }
    
    func toString() -> String? {
        guard let data = jpegData(compressionQuality: 1) else { return nil }
        return data.base64EncodedString()
    }
}
