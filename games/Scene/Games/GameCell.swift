//
//  GameCell.swift
//  games
//
//  Created by ali güneş on 9.05.2021.
//  Copyright © 2021 ali güneş. All rights reserved.
//

import UIKit

final class GameCell: UICollectionViewCell {
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var metacriticResultLabel: UILabel!
    @IBOutlet private weak var genresLabel: UILabel!
    
    var item: GamePresentation! {
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
        } else {
            self.imageView.image = nil
            self.activityIndicator.isHidden = false
            self.activityIndicator.startAnimating()
        }
        nameLabel.text = item.name
        if let metacriticValue = item.metacritic {
            metacriticResultLabel.text = String(metacriticValue)
        } else {
            metacriticResultLabel.text = ""
        }
        genresLabel.text = item.genres.joined(separator: ", ")
        
        self.backgroundColor = item.clickedBefore ? .gray : .white
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.activityIndicator.isHidden = true
        self.activityIndicator.stopAnimating()
    }
}
