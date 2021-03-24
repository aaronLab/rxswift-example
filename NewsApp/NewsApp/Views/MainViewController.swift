//
//  MainViewController.swift
//  NewsApp
//
//  Created by Aaron Lee on 2021/03/24.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - Properties
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
    }
    
    // MARK: - Helpers
    
    private func configureViews() {
        title = "Good News"
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
}
