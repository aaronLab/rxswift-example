//
//  TaskListViewController.swift
//  Awesome To Do
//
//  Created by Aaron Lee on 9/18/20.
//

import UIKit

class ToDoListViewController: UIViewController {
    
    @IBOutlet weak var prioritySegmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Large Title
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
}

//MARK: - UITableViewDelegate

extension ToDoListViewController: UITableViewDelegate {
    
}

//MARK: - UITableViewDataSource

extension ToDoListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskTableViewCell", for: indexPath)
        return cell
    }
}
