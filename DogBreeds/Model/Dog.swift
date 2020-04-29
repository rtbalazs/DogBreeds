//
//  Dog.swift
//  DogBreeds
//
//  Created by Razvan Balazs on 29/4/20.
//  Copyright © 2020 Brava. All rights reserved.
//

import Foundation

struct Dog {
    let breeds: [Breed]
    let id: String
    let imageUrl: String
    let width, height: Int
}

extension Dog: Codable {
    enum CodingKeys: String, CodingKey {
        case id, breeds, width, height
        case imageUrl = "url"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        breeds = try container.decodeIfPresent([Breed].self, forKey: .breeds) ?? []
        imageUrl = try container.decode(String.self, forKey: .imageUrl)
        width = try container.decode(Int.self, forKey: .width)
        height = try container.decode(Int.self, forKey: .height)
    }
}

extension Dog: Equatable {
    static func == (lhs: Dog, rhs: Dog) -> Bool {
        lhs.id == rhs.id
    }
}

// TODO: Revisit, as we take only the first breed into consideration
extension Dog {
    var breedLifeSpan: String? {
        return breeds.first?.lifeSpan
    }
    
    var breedLifeSpanRange: Range<Int> {
        return breeds.first?.lifeSpanRange ?? 0..<0
    }
}
