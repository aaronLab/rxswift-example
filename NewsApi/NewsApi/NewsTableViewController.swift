//
//  MainViewController.swift
//  NewsApi
//
//  Created by Aaron Lee on 2021/03/21.
//

import UIKit

class NewsTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    // MARK: - Actions
    
    // MARK: - Helpers
    
    func setupViews() {
        view.backgroundColor = .white
        title = "News App"
        navigationController?.navigationBar.prefersLargeTitles = true
    }

}

