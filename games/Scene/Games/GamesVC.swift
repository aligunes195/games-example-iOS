//
//  GamesVC.swift
//  games
//
//  Created by ali güneş on 31.05.2020.
//  Copyright © 2020 ali güneş. All rights reserved.
//

import UIKit

final class GamesVC: UIViewController {
    var vm: GamesVMProtocol!
    
    private lazy var searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.searchController = searchController
        navigationItem.largeTitleDisplayMode = .always
        
        title = String.localized("GAMES_TITLE")
    }
}
