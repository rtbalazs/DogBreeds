//
//  DogsViewModel.swift
//  DogBreeds
//
//  Created by Razvan Balazs on 29/4/20.
//  Copyright © 2020 Brava. All rights reserved.
//

import Foundation

struct DogsViewModel {
    
    var dogs = [Dog]()
    
    func nameOf(dog: Dog) -> String? {
        dog.breeds.first?.name
    }
    
    func lifeSpan(of dog: Dog) -> String? {
        dog.breeds.first?.lifeSpan
    }
    
    mutating func sort(ascending: Bool){
        dogs = dogs.sorted(by: { (first, second) -> Bool in
            let first = first.breedLifeSpanRange
            let second = second.breedLifeSpanRange
            return ascending ?
                first.upperBound < second.upperBound :
                first.upperBound > second.upperBound
        })
    }

}
