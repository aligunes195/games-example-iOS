//
//  FavouriteCell.swift
//  games
//
//  Created by ali güneş on 21.05.2021.
//  Copyright © 2021 ali güneş. All rights reserved.
//

import UIKit

final class FavouriteCell: UICollectionViewCell {
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var metacriticResultLabel: UILabel!
    @IBOutlet private weak var genresLabel: UILabel!
    
    var item: FavouritePresentation! {
        didSet {
            setItem()
        }
    }
    
    private func setItem() {
        if let imageData = item.imageData?.data,
           let image = UIImage(data: imageData) {
            self.imageView.image = image
            self.activityIndicator.isHidden = true
            self.activityIndicator.stopAnimating()
        } else if item.hasImage {
            self.imageView.image = nil
            self.activityIndicator.isHidden = false
            self.activityIndicator.startAnimating()
        } else {
            self.imageView.image = UIImage(named: "placeholder")
            self.activityIndicator.isHidden = true
            self.activityIndicator.stopAnimating()
        }
        nameLabel.text = item.name
        if let metacriticValue = item.metacritic {
            metacriticResultLabel.text = String(metacriticValue)
        } else {
            metacriticResultLabel.text = ""
        }
        genresLabel.text = item.genres.joined(separator: ", ")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.activityIndicator.isHidden = true
        self.activityIndicator.stopAnimating()
    }
}