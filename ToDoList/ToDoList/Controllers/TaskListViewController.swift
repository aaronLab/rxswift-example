//
//  TaskListViewController.swift
//  ToDoList
//
//  Created by Aaron Lee on 2021/03/23.
//

import UIKit
import RxSwift
import RxCocoa

private let tableViewCellIdentifier = "ToDoListCell"

class TaskListViewController: UIViewController, UITableViewDelegate {
    
    // MARK: - Properties
    
    private let disposeBag = DisposeBag()
    
    private var tasks = BehaviorRelay<[Task]>(value: [])
    private var filteredTasks = [Task]()
    
    private lazy var segmentedControl: UISegmentedControl = {
        let items = ["All", "High", "Medium", "Low"]
        let sc = UISegmentedControl(items: items)
        sc.selectedSegmentIndex = 0
        sc.addTarget(self, action: #selector(segmentAction(_:)), for: .valueChanged)
        return sc
    }()
    
    private let tableView: UITableView = {
        let tv = UITableView()
        return tv
    }()
    
    private lazy var addBarButton: UIBarButtonItem = {
        let btn = UIBarButtonItem(barButtonSystemItem: .add,
                                  target: self,
                                  action: #selector(addBarButtonPressed))
        return btn
    }()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
    }
    
    // MARK: - Actions
    
    @objc private func addBarButtonPressed() {
        let vc = AddTaskViewController()
        vc.taskSubjectObservable
            .subscribe(onNext: { [weak self] task in
                
                guard let `self` = self else { return }
                
                let priority = Priority(rawValue: self.segmentedControl.selectedSegmentIndex - 1)
                
                var existingTasks = self.tasks.value
                existingTasks.append(task)
                
                self.tasks.accept(existingTasks)
                
                self.filterTasks(by: priority)
            })
            .disposed(by: disposeBag)
        
        let navC = UINavigationController(rootViewController: vc)
        navC.modalPresentationStyle = .fullScreen
        
        present(navC, animated: true, completion: nil)
    }
    
    @objc private func segmentAction(_ sender: UISegmentedControl) {
        let priority = Priority(rawValue: sender.selectedSegmentIndex - 1)
        filterTasks(by: priority)
    }
    
    // MARK: - Helpers
    
    private func configureViews() {
        // default view
        view.backgroundColor = .white
        title = "ToDo List"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = addBarButton
        
        // segmentedControl
        view.addSubview(segmentedControl)
        segmentedControl.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                                paddingTop: 8)
        segmentedControl.centerX(inView: view)
        
        // tableView
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: tableViewCellIdentifier)
        view.addSubview(tableView)
        tableView.anchor(top: segmentedControl.bottomAnchor,
                         left: view.leftAnchor,
                         bottom: view.safeAreaLayoutGuide.bottomAnchor,
                         right: view.rightAnchor,
                         paddingTop: 8)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func filterTasks(by priority: Priority?) {
        
        if priority == nil {
            filteredTasks = tasks.value
        } else {
            
            tasks.map { tasks in
                
                return tasks.filter { $0.priority == priority! }
            }.subscribe(onNext: { [weak self] tasks in
                guard let `self` = self else { return }
                
                self.filteredTasks = tasks
                
            }).disposed(by: disposeBag)
            
        }
        
        updateTableView()
        
    }
    
    private func updateTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

}

// MARK: - DataSource

extension TaskListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellIdentifier, for: indexPath)
        cell.textLabel?.text = filteredTasks[indexPath.row].title
        return cell
    }
    
}
