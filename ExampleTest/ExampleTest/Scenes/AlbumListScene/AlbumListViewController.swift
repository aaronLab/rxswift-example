//
//  AlbumListViewController.swift
//  ExampleTest
//
//  Created by Aaron Lee on 2021-04-05.
//

import UIKit

class AlbumListViewController: UITableViewController {
    
    // MARK: - Private Properties
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
    }
    
    // MARK: - Helpers
    
    private func configureViews() {
        
        title = "Album List"
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        
    }
    
}
