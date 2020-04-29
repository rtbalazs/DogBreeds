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
    let temperament: String?
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
