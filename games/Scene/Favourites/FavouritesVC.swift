//
//  FavoutiresVC.swift
//  games
//
//  Created by ali güneş on 9.05.2021.
//  Copyright © 2021 ali güneş. All rights reserved.
//

import UIKit

final class FavouritesVC: UITableViewController {
    var vm: FavouritesVMProtocol!
    
    private lazy var searchController = UISearchController(searchResultsController: nil)
    
    override var title: String? {
        didSet {
            // This is for preventing tabbaritem title from being overwritten by title
            navigationController?.tabBarItem.title = String.localized("FAVOURITES_TITLE")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.searchController = searchController
        navigationItem.largeTitleDisplayMode = .always
        
        title = String.localized("FAVOURITES_TITLE_NUMBER", "3")
    }
}
