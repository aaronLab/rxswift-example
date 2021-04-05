//
//  ViewController.swift
//  NewsExample
//
//  Created by Aaron Lee on 2021-04-05.
//

import UIKit

class NewsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViews()
    }
    
    private func configureViews() {
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "News App"
    }


}

