//
//  ViewController.swift
//  DogBreeds
//
//  Created by Razvan Balazs on 29/4/20.
//  Copyright © 2020 Brava. All rights reserved.
//

import UIKit

class DogListViewController: UITableViewController {
    @IBOutlet weak var sortButton: UIBarButtonItem! {
        didSet {
            sortButton.title = sortType.buttonName
        }
    }
    
    // Data should be passed from view model. To simplify, we are keping the reference to the store here, and initiate the network request to populate the data in viewmodel.
    let dogStore = DogsStore()
    var dogsViewModel = DogsViewModel()
    
    private enum SortType {
        case ascending, descending
        
        var buttonName: String {
            switch self {
                case .ascending:
                return "Sort Descending" // Names are reversed.
                case .descending:
                return "Sort Ascending"
            }
        }
    }
    
    private var sortType = SortType.descending
    
    @IBAction func sortButtonAction(_ sender: Any) {
        if case .ascending = sortType { sortType = .descending } else { sortType = .ascending }
        sortButton.title = sortType.buttonName
        dogsViewModel.sort(ascending: sortType == .ascending)
        tableView.reloadData()
    }
    
    //MARK: View handling
    override func viewDidLoad() {
        super.viewDidLoad()
        dogStore.loadDogs{ [weak self] dogs in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.dogsViewModel.dogs = dogs
                self.tableView.reloadData()
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dogsViewModel.dogs.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DogCell", for: indexPath) as! DogCell
        let dog = dogsViewModel.dogs[indexPath.row]
        cell.configure(name:  dogsViewModel.nameOf(dog: dog),
                       details: dogsViewModel.lifeSpan(of: dog),
                       imageUrl: URL(string: dog.imageUrl) )        
        return cell
    }
}

