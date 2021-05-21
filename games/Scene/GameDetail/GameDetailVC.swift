//
//  GameDetailVC.swift
//  games
//
//  Created by ali güneş on 20.05.2021.
//  Copyright © 2021 ali güneş. All rights reserved.
//

import UIKit

final class GameDetailVC: UIViewController {
    var vm: GameDetailVMProtocol! {
        didSet {
            vm.delegate = self
        }
    }
    
    private var item: GameDetailPresentation! {
        didSet {
            setItem()
        }
    }
    
    @IBOutlet private weak var gameImageView: UIImageView!
    @IBOutlet private weak var gameNameLabel: UILabel!
    @IBOutlet private weak var gradientView: UIView!
    @IBOutlet private weak var gameDescriptionLabel: UILabel!
    @IBOutlet private weak var gameDescriptionView: UIView!
    @IBOutlet private weak var redditView: UIView!
    @IBOutlet private weak var websiteView: UIView!
    @IBOutlet private weak var gameImageViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet private weak var redditViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet private weak var websiteViewHeightConstraint: NSLayoutConstraint!
    
    private let gradient = CAGradientLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        
        vm.load()
        
        gradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradient.locations = [0.0, 1.0]
        gradientView.layer.insertSublayer(gradient, at: 0)
        
        gameNameLabel.adjustsFontSizeToFitWidth = true
        gameNameLabel.minimumScaleFactor = 0.6
        
        redditView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(redditLinkClicked)))
        websiteView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(websiteLinkClicked)))
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
    
    private func setItem() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: String.localized(item.isFavourite ? "FAVOURITED" : "FAVOURITE"),
                                                                 style: .plain,
                                                                 target: self,
                                                                 action: #selector(favouriteButtonClicked))
        gameNameLabel.text = item.name
        if item.redditUrl != nil {
            redditViewHeightConstraint.constant = 60
            redditView.isHidden = false
        } else {
            redditViewHeightConstraint.constant = 0
            redditView.isHidden = true
        }
        if item.websiteUrl != nil {
            websiteViewHeightConstraint.constant = 60
            websiteView.isHidden = false
        } else {
            websiteViewHeightConstraint.constant = 0
            websiteView.isHidden = true
        }
        gameDescriptionView.isHidden = item.description == nil
        if let description = item.description {
            gameDescriptionLabel.text = description
        }
        self.view.setNeedsLayout()
        if let imageData = item.imageData?.data,
           let image = UIImage(data: imageData) {
            gameImageView.image = image
            let newConstant = image.size.height * (self.gameImageView.frame.size.width / image.size.width)
            if self.gameImageViewHeightConstraint.constant != newConstant {
                self.gameImageViewHeightConstraint.constant = newConstant
                self.view.layoutIfNeeded()
                self.gradient.frame = self.gradientView.frame
            }
        }
    }
    
    @objc private func redditLinkClicked() {
        guard let url = URL(string: item.redditUrl!) else { return }
        UIApplication.shared.open(url)
    }
    
    @objc private func websiteLinkClicked() {
        guard let url = URL(string: item.websiteUrl!) else { return }
        UIApplication.shared.open(url)
    }
    
    @objc private func favouriteButtonClicked() {
        vm.toggleFavourite()
    }
}

extension GameDetailVC: GameDetailVMOutputDelegate {
    func updateGamePresentation(_ gamePresentation: GameDetailPresentation) {
        self.item = gamePresentation
    }
}
