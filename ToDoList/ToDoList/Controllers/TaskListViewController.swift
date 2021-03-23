//
//  TaskListViewController.swift
//  ToDoList
//
//  Created by Aaron Lee on 2021/03/23.
//

import UIKit

class TaskListViewController: UIViewController {
    
    // MARK: - Properties
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
    }
    
    // MARK: - Actions
    
    // MARK: - Helpers
    
    private func configureViews() {
        view.backgroundColor = .red
    }

}
