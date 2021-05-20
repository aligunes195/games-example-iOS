//
//  GameDetailVC.swift
//  games
//
//  Created by ali güneş on 20.05.2021.
//  Copyright © 2021 ali güneş. All rights reserved.
//

import UIKit

final class GameDetailVC: UIViewController {
    var vm: GameDetailVMProtocol!
    
    @IBOutlet private weak var gameImageView: UIImageView!
    @IBOutlet private weak var gameNameLabel: UILabel!
    @IBOutlet private weak var gradientView: UIView!
    @IBOutlet private weak var gameDescriptionLabel: UILabel!
    @IBOutlet private weak var gameImageViewHeightConstraint: NSLayoutConstraint!
    
    private let gradient = CAGradientLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let imageData = vm.imageDataWrapper?.data {
            gameImageView.image = UIImage(data: imageData)
        }
        
        gradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradient.locations = [0.0, 1.0]
        gradientView.layer.insertSublayer(gradient, at: 0)
        
        gameNameLabel.adjustsFontSizeToFitWidth = true
        gameNameLabel.minimumScaleFactor = 0.6
        gameNameLabel.text = "Grand Theft Auto V"
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if let image = gameImageView.image {
            let newConstant = image.size.height * (self.gameImageView.frame.size.width / image.size.width)
            if self.gameImageViewHeightConstraint.constant != newConstant {
                self.gameImageViewHeightConstraint.constant = newConstant
                self.view.layoutIfNeeded()
                self.gradient.frame = self.gradientView.frame
            }
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
    }
}
