//
//  GamesVC.swift
//  games
//
//  Created by ali güneş on 31.05.2020.
//  Copyright © 2020 ali güneş. All rights reserved.
//

import UIKit

final class GamesVC: UICollectionViewController {
    var vm: GamesVMProtocol! {
        didSet {
            vm.delegate = self
        }
    }
    
    weak var routerDelegate: GamesNavigationDelegate?
    
    private let cellReuseIdentifier = "GameCell"
    
    private lazy var searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.searchController = searchController
        navigationItem.largeTitleDisplayMode = .always
        
        title = String.localized("GAMES_TITLE")
        
        vm.load()
    }
}

extension GamesVC {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vm.items.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as! GameCell
        cell.item = vm.items[indexPath.row]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        routerDelegate?.showDetail(with: vm.items[indexPath.row].id)
    }
}

extension GamesVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width
        return CGSize(width: screenWidth > 600 ? (screenWidth / 2) - 5 : screenWidth, height: 144)
    }
}

extension GamesVC: GamesVMOutputDelegate {
    func reloadData() {
        collectionView.reloadData()
    }
}
