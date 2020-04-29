//
//  DogStore.swift
//  DogBreeds
//
//  Created by Razvan Balazs on 29/4/20.
//  Copyright © 2020 Brava. All rights reserved.
//

import Foundation

class DogsStore {
    enum Constants {
        static let dogsApiUrl = "https://api.thedogapi.com/v1/images/search?limit=50"
    }
    
    let dogService = NetworkService()
    private (set) var dogs = [Dog]()
    
    func loadDogs(completion: @escaping ([Dog]) -> Void) {
        guard let url = URL(string: Constants.dogsApiUrl) else {
            completion([])
            return
        }
        dogService.fetchData(from: url) { result in
            switch result {
                case .success(let(_, data)):
                    do  {
                        let dogs = try JSONDecoder().decode([Dog].self, from: data)
                        self.dogs = dogs
                        completion(dogs)
                    } catch let error {
                        debugPrint(error)
                    }
                case .failure(let error):
                    debugPrint(error)
            }
        }
    }
}
