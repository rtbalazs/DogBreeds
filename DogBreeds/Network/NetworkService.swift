//
//  NetworkService.swift
//  DogBreeds
//
//  Created by Razvan Balazs on 29/4/20.
//  Copyright © 2020 Brava. All rights reserved.
//

import Foundation
import UIKit // For image download.

typealias DataTaskCompletionHandler = (Result<(URLResponse, Data), NSError>) -> Void

public typealias ImageDownloadCompletionHandler = (Result<UIImage, NSError>) -> Void

struct NetworkError {
    
    static let unknown = NSError(domain: "dogBreeds",
                                 code: 0,
                                 userInfo: [NSLocalizedDescriptionKey: "Response did not contain any data"])
    static let imageCreation = NSError(domain: "dogBreeds",
                                       code: 1,
                                       userInfo: [NSLocalizedDescriptionKey: "Could not create image from reponse data"])
}
class NetworkService {
    
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
 
    private let urlSession: URLSession
    
    func fetchData(from url: URL, completion: @escaping DataTaskCompletionHandler) {
        let task = urlSession.dataTask(with: url) { (data, response, error) in
            if let error = error as NSError? {
                completion(.failure(error))
                return
            }
            guard
                let data = data,
                let response = response,
                let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode)
            else {
                completion(.failure(NetworkError.unknown))
                return
            }
            completion(.success((response, data)))
        }
        task.resume()
    }
    
    func loadImage(at url: URL, completion: @escaping ImageDownloadCompletionHandler) {
        let task = urlSession.dataTask(with: url) { (data, response, error) in
            // Simplified error handling, as a complete imlementetion will require to look at response as well.
            if error == nil {
                if let data = data, let image = UIImage(data: data) {
                    completion(.success(image))
                }
            } else {
                completion(.failure(NetworkError.imageCreation))
            }
        }
        task.resume()
    }
}
