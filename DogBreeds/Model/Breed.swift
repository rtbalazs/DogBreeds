//
//  Breed.swift
//  DogBreeds
//
//  Created by Razvan Balazs on 29/4/20.
//  Copyright © 2020 Brava. All rights reserved.
//

import Foundation

struct Breed {
    let id: Int
    let name: String
    let weight, height: Measure
    let bredFor: String?
    let breedGroup: String?
    let lifeSpan: String
    let temperament: String? // Can be converted to a Set.
    let origin: String?
    let countryCode: String?
}

extension Breed: Codable {
    enum CodingKeys: String, CodingKey {
        case weight, height, id, name
        case bredFor = "bred_for"
        case breedGroup = "breed_group"
        case lifeSpan = "life_span"
        case temperament, origin
        case countryCode = "country_code"
    }
}

struct Measure: Codable {
     let imperial, metric: String
}

extension Breed: Equatable {
    static func == (lhs: Breed, rhs: Breed) -> Bool {
        lhs.id == rhs.id
    }
}

let suffix = " years"

extension Breed {
    // This can be stored as part of the struct, not to compute it all the time.
    var lifeSpanRange: Range<Int> {
        return Self.rangeFrom(lifeSpan)
    }
    
    static func rangeFrom(_ rangeString: String) -> Range<Int> {        
        let values = rangeString
            .components(separatedBy: CharacterSet.decimalDigits.inverted)
            .compactMap{ Int($0) }
        guard let first = values.min() else { return 0..<0 }
        return Range(first...(values.max() ?? first))
    }

}
