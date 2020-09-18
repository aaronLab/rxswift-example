//
//  TaskListViewController.swift
//  Awesome To Do
//
//  Created by Aaron Lee on 9/18/20.
//

import UIKit
import RxSwift

class ToDoListViewController: UIViewController {
    
    @IBOutlet weak var prioritySegmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Large Title
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let navC = segue.destination as? UINavigationController,
              let nextVC = navC.viewControllers.first as? AddToDoViewController else {
            fatalError("Can't find the view controller")
        }
        
        nextVC.todoSubjectObservable
            .subscribe(onNext: { todo in
                
                print(todo)
                
            }).disposed(by: self.disposeBag)
        
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
