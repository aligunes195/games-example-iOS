//
//  FavoutiresVC.swift
//  games
//
//  Created by ali güneş on 9.05.2021.
//  Copyright © 2021 ali güneş. All rights reserved.
//

import UIKit

final class FavouritesVC: UITableViewController {
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
        
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        vm.load()
    }
    
    private func addEmptyViewConstraints() {
        NSLayoutConstraint.activate([
            self.emptyView.topAnchor.constraint(equalTo: tableView.topAnchor, constant: 100),
            self.emptyView.centerXAnchor.constraint(equalTo: tableView.centerXAnchor)
        ])
    }
}

extension FavouritesVC {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = vm.numberOfFavourites()
        if count == 0 {
            self.tableView.addSubview(self.emptyView)
            addEmptyViewConstraints()
        } else {
            self.emptyView.removeFromSuperview()
        }
        return count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 144
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! FavouriteCell
        cell.item = vm.getFavouritePresentation(at: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        routerDelegate?.showDetail(with: vm.getGame(at: indexPath))
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: String.localized("DELETE_FAVOURITE")) { (action, indexPath) in
            self.vm.deleteFavourite(at: indexPath)
        }
        return [deleteAction]
    }
}

extension FavouritesVC: FavouritesVMOutputDelegate {
    func reloadData(rows: [Int]?) {
        guard let rows = rows else {
            tableView.reloadData()
            return
        }
        tableView.reloadRows(at: rows.map { IndexPath(row: $0, section: 0) }, with: .none)
    }
    
    func deleteData(rows: [Int]) {
        tableView.deleteRows(at: rows.map { IndexPath(row: $0, section: 0) }, with: .automatic)
    }
    
    func updateTitle() {
        let count = vm.numberOfFavourites()
        title = count > 0
            ? String.localized("FAVOURITES_TITLE_NUMBER", "\(vm.numberOfFavourites())")
            : String.localized("FAVOURITES_TITLE")
    }
}
