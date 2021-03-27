//
//  MainViewController.swift
//  News
//
//  Created by Aaron Lee on 2021/03/27.
//

import UIKit

class MainViewController: UITableViewController {
    
    private let cellIdentifier = "NewsCell"
    
    // MARK: - Properties
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    // MARK: - Actions
    
    // MARK: - Helpers
    
    private func configureView() {
        view.backgroundColor = .white
        title = "News"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
}
