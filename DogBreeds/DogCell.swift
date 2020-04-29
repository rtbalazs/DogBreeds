//
//  DogCell.swift
//  DogBreeds
//
//  Created by Razvan Balazs on 29/4/20.
//  Copyright © 2020 Brava. All rights reserved.
//

import UIKit

class DogCell: UITableViewCell {
    private var imageUrl: URL!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var detailsImageView: UIImageView!
    
    // Idealy we would pass the a dog viewmodel into the configure in order pass all data needed. We keep it simple in this test.
    func configure(name: String?, details: String?, imageUrl: URL?) {
        nameLabel.text = name ?? "Oops, Unamed dog"
        detailsLabel.text = details
        self.imageUrl = imageUrl
        
        if let url = imageUrl {
            ImageDownloader.downloadImage(url) { [weak self] (image) in
                guard let self = self else { return }
                if self.imageUrl == imageUrl {
                    self.detailsImageView?.image = image
                }
            }
        } else {
            detailsImageView.image = nil
        }
    }
    
    override func prepareForReuse() {
        imageUrl = nil
        detailsImageView.image = nil
    }
}
