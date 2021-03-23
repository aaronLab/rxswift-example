//
//  TaskListViewController.swift
//  ToDoList
//
//  Created by Aaron Lee on 2021/03/23.
//

import UIKit
import RxSwift

private let tableViewCellIdentifier = "ToDoListCell"

class TaskListViewController: UIViewController, UITableViewDelegate {
    
    // MARK: - Properties
    
    private let disposeBag = DisposeBag()
    
    private let segmentedControl: UISegmentedControl = {
        let items = ["All", "High", "Medium", "Low"]
        let sc = UISegmentedControl(items: items)
        sc.selectedSegmentIndex = 0
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
            .subscribe(onNext: { task in
                print(task)
            })
            .disposed(by: disposeBag)
        
        let navC = UINavigationController(rootViewController: vc)
        navC.modalPresentationStyle = .fullScreen
        
        present(navC, animated: true, completion: nil)
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

}

// MARK: - DataSource

extension TaskListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellIdentifier, for: indexPath)
        return cell
    }
    
}
