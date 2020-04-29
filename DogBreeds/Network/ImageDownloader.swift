//
//  ImageDownloader.swift
//  DogBreeds
//
//  Created by Razvan Balazs on 29/4/20.
//  Copyright © 2020 Brava. All rights reserved.
//

import UIKit

class ImageDownloader {
    static let imageCache = NSCache<NSString, UIImage>()
    
    static func downloadImage(_ imageURL: URL, placeholderImage: UIImage? = nil, completion: @escaping (UIImage?) -> Void ) {
        let networkService = NetworkService()
        
        if let cached = ImageDownloader.imageCache.object(forKey: imageURL.absoluteString as NSString) {
            completion(cached)
            return
        }
        
        networkService.loadImage(at: imageURL) { (result: Result<UIImage, NSError>) in
            switch result {
                case .success(let image):
                    DispatchQueue.main.async {
                        ImageDownloader.imageCache.setObject(image, forKey: imageURL.absoluteString as NSString)
                        completion(image)
                    }
                default:
                    break
            }
        }
    }
    
}
