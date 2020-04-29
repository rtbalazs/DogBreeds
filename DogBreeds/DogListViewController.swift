//
//  ViewController.swift
//  DogBreeds
//
//  Created by Razvan Balazs on 29/4/20.
//  Copyright © 2020 Brava. All rights reserved.
//

import UIKit

class DogListViewController: UIViewController {

    let dogStore = DogsStore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dogStore.loadDogs { dogs in
            DispatchQueue.main.async {
                debugPrint(dogs)
            }
        }
    }

}

