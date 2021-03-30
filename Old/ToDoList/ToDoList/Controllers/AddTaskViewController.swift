//
//  AddTaskViewController.swift
//  ToDoList
//
//  Created by Aaron Lee on 2021/03/23.
//

import UIKit
import RxSwift

class AddTaskViewController: UIViewController {
    
    // MARK: - Properties
    
    private let taskSubject = PublishSubject<Task>()
    var taskSubjectObservable: Observable<Task> {
        return taskSubject.asObservable()
    }
    
    private let segmentedControl: UISegmentedControl = {
        let items = ["High", "Medinum", "Low"]
        let sc = UISegmentedControl(items: items)
        sc.selectedSegmentIndex = 0
        return sc
    }()
    
    private lazy var saveBarButton: UIBarButtonItem = {
        let btn = UIBarButtonItem(barButtonSystemItem: .save,
                                  target: self,
                                  action: #selector(saveBarButtonPressed))
        return btn
    }()
    
    private let textField: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .roundedRect
        tf.placeholder = "Type here..."
        return tf
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
    }
    
    // MARK: - Actions
    
    @objc private func saveBarButtonPressed() {
        guard let priority = Priority(rawValue: segmentedControl.selectedSegmentIndex),
              let title = textField.text else {
            return
        }
        
        let task = Task(title: title, priority: priority)
        
        taskSubject.onNext(task)
        
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Helpers
    
    private func configureViews() {
        view.backgroundColor = .white
        title = "Add Task"
        navigationItem.rightBarButtonItem = saveBarButton
        
        // segmentedControl
        view.addSubview(segmentedControl)
        segmentedControl.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                                paddingTop: 16)
        segmentedControl.centerX(inView: view)
        
        // textField
        view.addSubview(textField)
        textField.anchor(left: view.leftAnchor,
                         right: view.rightAnchor,
                         paddingLeft: 16,
                         paddingRight: 16)
        textField.centerY(inView: view)
    }
    
}
