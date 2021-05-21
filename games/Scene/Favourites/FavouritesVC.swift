//
//  FavoutiresVC.swift
//  games
//
//  Created by ali güneş on 9.05.2021.
//  Copyright © 2021 ali güneş. All rights reserved.
//

import UIKit

final class FavouritesVC: UICollectionViewController {
    var vm: FavouritesVMProtocol! {
        didSet {
            vm.delegate = self
        }
    }
    
    weak var routerDelegate: FavouritesNavigationDelegate?
    
    override var title: String? {
        didSet {
            // This is for preventing tabbaritem title from being overwritten by title
            navigationController?.tabBarItem.title = String.localized("FAVOURITES_TITLE")
        }
    }
    
    private let cellReuseIdentifier = "FavouriteCell"
    
    private lazy var emptyView: UILabel = {
        let label = UILabel()
        label.text = String.localized("NO_FAVOURITES_FOUND")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .always
        
        title = String.localized("FAVOURITES_TITLE_NUMBER", "3")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        vm.load()
    }
    
    private func addEmptyViewConstraints() {
        NSLayoutConstraint.activate([
            self.emptyView.topAnchor.constraint(equalTo: collectionView.topAnchor, constant: 100),
            self.emptyView.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor)
        ])
    }
}

extension FavouritesVC {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = vm.numberOfFavourites()
        if count == 0 {
            self.collectionView.addSubview(self.emptyView)
            addEmptyViewConstraints()
        } else {
            self.emptyView.removeFromSuperview()
        }
        return count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as! FavouriteCell
        cell.item = vm.getFavouritePresentation(at: indexPath)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        routerDelegate?.showDetail(with: vm.getGame(at: indexPath))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension FavouritesVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width
        return CGSize(width: screenWidth > 600 ? (screenWidth / 2) - 5 : screenWidth, height: 144)
    }
}

extension FavouritesVC: FavouritesVMOutputDelegate {
    func reloadData(rows: [Int]?) {
        guard let rows = rows else {
            collectionView.reloadData()
            return
        }
        collectionView.reloadItems(at: rows.map { IndexPath(row: $0, section: 0) })
    }
    
    func deleteData(rows: [Int]) {
        collectionView.deleteItems(at: rows.map { IndexPath(row: $0, section: 0) })
    }
}
