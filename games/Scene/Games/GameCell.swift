//
//  GameCell.swift
//  games
//
//  Created by ali güneş on 9.05.2021.
//  Copyright © 2021 ali güneş. All rights reserved.
//

import UIKit

final class GameCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var metacriticResultLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    
    var item: GamePresentation! {
        didSet {
            if let imageData = item.imageData?.data,
               let image = UIImage(data: imageData) {
                imageView.image = image
            } else {
                imageView.image = nil
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
    }
}
