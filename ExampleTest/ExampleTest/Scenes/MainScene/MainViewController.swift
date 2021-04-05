//
//  MainViewController.swift
//  ExampleTest
//
//  Created by Aaron Lee on 2021-04-05.
//

import UIKit

class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
    }
    
    private func configureViews() {
        
        title = "MVVM Example"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .white
        
    }
    
}
