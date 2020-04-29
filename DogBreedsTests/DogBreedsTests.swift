//
//  DogBreedsTests.swift
//  DogBreedsTests
//
//  Created by Razvan Balazs on 29/4/20.
//  Copyright © 2020 Brava. All rights reserved.
//

import XCTest
@testable import DogBreeds

class DogBreedsTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testDogsViewModel() throws {
        let jsonData = dogJSON.data(using: .utf8)!
        let dog = try! JSONDecoder().decode(Dog.self, from: jsonData)

        let viewModel = DogsViewModel(dogs: [dog, dog])
        XCTAssertEqual(viewModel.nameOf(dog: viewModel.dogs.first!), "American Bulldog")
        XCTAssertEqual(viewModel.lifeSpan(of: viewModel.dogs.first!), "8 – 15 years")
    }
    
    // Test dcoding.
    func testDogDecoding() throws {
        let jsonData = dogJSON.data(using: .utf8)!
        let dog = try! JSONDecoder().decode(Dog.self, from: jsonData)
        let dog2 = try! JSONDecoder().decode(Dog.self, from: jsonData)
        XCTAssertEqual(dog, dog2)
        XCTAssertEqual(dog.id, "Atmf2iDb0")
        XCTAssertEqual(dog.imageUrl, "https://cdn2.thedogapi.com/images/Atmf2iDb0.jpg")
        XCTAssertEqual(dog.width, 720)
        XCTAssertEqual(dog.height, 518)
        XCTAssertEqual(dog.breedLifeSpan, "8 – 15 years")
        XCTAssertEqual(dog.breedLifeSpanRange, 8..<16)
        XCTAssertEqual(dog.breedLifeSpanRange.upperBound, 16)
        XCTAssertEqual(dog.breeds.count, 1)
        XCTAssertEqual(dog.breeds.first?.id, 10)
        XCTAssertEqual(dog.breeds.first?.name, "American Bulldog")
        XCTAssertEqual(dog.breeds.first?.breedGroup, "Working")
        XCTAssertEqual(dog.breeds.first?.temperament, "Friendly, Assertive, Energetic, Loyal, Gentle, Confident, Dominant")

    }
    // Test range extration from the given string.
    func testRangeFromString() throws {
        let range1 = "8 - 15 years"
        let range2 = "12 - 15 years"
        let range3 = "10"
        let range4 = ""
        let range5 = "8-10"
        
        XCTAssertEqual(Breed.rangeFrom(range1), 8..<16)
        XCTAssertEqual(Breed.rangeFrom(range2), 12..<16)
        XCTAssertEqual(Breed.rangeFrom(range3), 10..<11)
        XCTAssertEqual(Breed.rangeFrom(range3).upperBound, 11)
        XCTAssertEqual(Breed.rangeFrom(range4), 0..<0)
        XCTAssertEqual(Breed.rangeFrom(range5), 8..<11)
    }
    
    // Test data.
    private var dogJSON: String = """
    {
        "breeds": [
        {
        "weight": {
        "imperial": "60 - 120",
        "metric": "27 - 54"
        },
        "height": {
        "imperial": "22 - 27",
        "metric": "56 - 69"
        },
        "id": 10,
        "name": "American Bulldog",
        "breed_group": "Working",
        "life_span": "8 – 15 years",
        "temperament": "Friendly, Assertive, Energetic, Loyal, Gentle, Confident, Dominant"
        }
        ],
        "id": "Atmf2iDb0",
        "url": "https://cdn2.thedogapi.com/images/Atmf2iDb0.jpg",
        "width": 720,
        "height": 518
    }
    """
}
