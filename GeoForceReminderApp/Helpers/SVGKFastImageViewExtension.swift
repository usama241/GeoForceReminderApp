//
//  SVGKFastImageViewExtension.swift
//  JSZindigi
//
//  Created by Anis Ur Rehman on 13/09/2023.
//

import Foundation
import SVGKit

extension SVGKFastImageView {
    func load(url: URL, cache: URLCache? = nil) {
        let cache = cache ?? URLCache.shared
        let request = URLRequest(url: url)
        if let data = cache.cachedResponse(for: request)?.data, let image = SVGKImage(data: data) {
            self.image = image
        } else {
            URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                if let data = data, let response = response, ((response as? HTTPURLResponse)?.statusCode ?? 500) < 300, let image = SVGKImage(data: data) {
                    let cachedData = CachedURLResponse(response: response, data: data)
                    cache.storeCachedResponse(cachedData, for: request)
                    DispatchQueue.main.async { [weak self] in
                        self?.image = image
                    }
                }
            }).resume()
        }
    }
}
