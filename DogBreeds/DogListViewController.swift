//
//  ViewController.swift
//  DogBreeds
//
//  Created by Razvan Balazs on 29/4/20.
//  Copyright © 2020 Brava. All rights reserved.
//

import UIKit

class DogListViewController: UITableViewController {
    @IBOutlet weak var sortButton: UIBarButtonItem!
    
    let dogStore = DogsStore()
    var dogsViewModel = DogsViewModel()
    
    @IBAction func sortButtonAction(_ sender: Any) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        dogStore.loadDogs{ [weak self] dogs in
            DispatchQueue.main.async {
                self?.dogsViewModel.dogs = dogs
                self?.tableView.reloadData()
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dogsViewModel.dogs.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DogCell", for: indexPath) as! DogCell
        // This code will usually sit in a configure method in the custom cell.
        let dog = dogsViewModel.dogs[indexPath.row]
        cell.configure(name:  dogsViewModel.nameOf(dog: dog),
                       details: dogsViewModel.lifeSpan(of: dog),
                       imageUrl: URL(string: dog.imageUrl) )        
        return cell
    }
}

