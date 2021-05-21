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
    private lazy var emptyView: UILabel = {
        let label = UILabel()
        label.text = String.localized("NO_GAMES_FOUND")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var loadingNextPage = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.searchController = searchController
        navigationItem.largeTitleDisplayMode = .always
        
        searchController.searchBar.placeholder = String.localized("SEARCH_FOR_THE_GAMES")
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        
        title = String.localized("GAMES_TITLE")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        collectionView.reloadData()
    }
    
    private func addEmptyViewConstraints() {
        NSLayoutConstraint.activate([
            self.emptyView.topAnchor.constraint(equalTo: collectionView.topAnchor, constant: 100),
            self.emptyView.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor)
        ])
    }
}

extension GamesVC {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = vm.numberOfGames()
        if count == 0 {
            self.collectionView.addSubview(self.emptyView)
            addEmptyViewConstraints()
        } else {
            self.emptyView.removeFromSuperview()
        }
        return count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as! GameCell
        cell.item = vm.getGamePresentation(at: indexPath)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        vm.selectGame(at: indexPath)
        routerDelegate?.showDetail(with: vm.getGame(at: indexPath))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard !loadingNextPage else { return }
        
        let topPosition = scrollView.contentOffset.y
        let bottomPosition = topPosition + scrollView.frame.size.height
        let contentHeight = scrollView.contentSize.height
        
        if bottomPosition / contentHeight > 0.9 {
            loadingNextPage = true
            vm.loadMore() { [weak self] in
                guard let self = self else { return }
                self.loadingNextPage = false
            }
        }
    }
}

extension GamesVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width
        return CGSize(width: screenWidth > 600 ? (screenWidth / 2) - 5 : screenWidth, height: 144)
    }
}

extension GamesVC: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        vm.query = ""
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        vm.query = searchText
    }
}

extension GamesVC: GamesVMOutputDelegate {
    func reloadData(rows: [Int]?) {
        guard let rows = rows else {
            collectionView.reloadData()
            return
        }
        collectionView.reloadItems(at: rows.map { IndexPath(row: $0, section: 0) })
    }
    
    func insertData(rows: [Int]) {
        collectionView.insertItems(at: rows.map { IndexPath(row: $0, section: 0) })
    }
    
    func isVisible(id: Int) -> Bool {
        return (collectionView.visibleCells as! [GameCell]).map({ $0.item.id }).contains(id)
    }
}
