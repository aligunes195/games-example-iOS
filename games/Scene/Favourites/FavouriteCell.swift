//
//  FavouriteCell.swift
//  games
//
//  Created by ali güneş on 21.05.2021.
//  Copyright © 2021 ali güneş. All rights reserved.
//

import UIKit

final class FavouriteCell: UITableViewCell {
    
    @IBOutlet private weak var gameImageView: UIImageView!
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
            self.gameImageView.image = image
        } else {
            self.gameImageView.image = UIImage(named: "placeholder")
        }
        nameLabel.text = item.name
        if let metacriticValue = item.metacritic {
            metacriticResultLabel.text = String(metacriticValue)
        } else {
            metacriticResultLabel.text = ""
        }
        genresLabel.text = item.genres.joined(separator: ", ")
    }
}
