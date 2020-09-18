//
//  TaskListViewController.swift
//  Awesome To Do
//
//  Created by Aaron Lee on 9/18/20.
//

import UIKit
import RxSwift
import RxCocoa

class ToDoListViewController: UIViewController {
    
    @IBOutlet weak var prioritySegmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    private var todos = BehaviorRelay<[ToDo]>(value: [])
    private var filteredToDos = [ToDo]()
    
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
            .subscribe(onNext: { [unowned self] todo in
                
                let priority = Priority(rawValue: self.prioritySegmentedControl.selectedSegmentIndex - 1)
                
                var existingToDos = self.todos.value
                existingToDos.append(todo)
                
                self.todos.accept(existingToDos)
                
                self.filterToDos(by: priority)
                
            }).disposed(by: self.disposeBag)
        
    }
    
    @IBAction func priorityChanged(_ sender: UISegmentedControl) {
        
        let priority = Priority(rawValue: sender.selectedSegmentIndex - 1)
        
        self.filterToDos(by: priority)
        
    }
    
    private func filterToDos(by priority: Priority?) {
        
        if priority == nil {
            self.filteredToDos = self.todos.value
            self.updateUI()
        } else {
            self.todos.map { items in
                return items.filter { $0.priority == priority! }
            }.subscribe(onNext: { [weak self] items in
                self?.filteredToDos = items
                self?.updateUI()
            }).disposed(by: disposeBag)
        }
        
    }
    
    private func updateUI() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
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
        return self.filteredToDos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskTableViewCell", for: indexPath)
        
        cell.textLabel?.text = self.filteredToDos[indexPath.row].title
        
        return cell
    }
}
