//
//  NetworkService.swift
//  DogBreeds
//
//  Created by Razvan Balazs on 29/4/20.
//  Copyright © 2020 Brava. All rights reserved.
//

import Foundation

typealias DataTaskCompletionHandler = (Result<(URLResponse, Data), NSError>) -> Void

struct NetworkError {
    
    static let unknown = NSError(domain: "dogBreeds",
                                 code: 0,
                                 userInfo: [NSLocalizedDescriptionKey: "Response did not contain any data"])
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
}
