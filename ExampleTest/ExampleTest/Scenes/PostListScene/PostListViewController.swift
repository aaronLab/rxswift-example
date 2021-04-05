//
//  PostListViewController.swift
//  ExampleTest
//
//  Created by Aaron Lee on 2021-04-05.
//

import UIKit

class PostListViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }

    private func configureView() {

        title = "Post List"
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true

    }

}
