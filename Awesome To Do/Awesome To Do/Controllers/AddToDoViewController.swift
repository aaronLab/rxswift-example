//
//  AddTaskViewController.swift
//  Awesome To Do
//
//  Created by Aaron Lee on 9/18/20.
//

import UIKit
import RxSwift

class AddToDoViewController: UIViewController {
    
    private let todoSubject = PublishSubject<ToDo>()
    
    var todoSubjectObservable: Observable<ToDo> {
        return self.todoSubject.asObservable()
    }
    
    @IBOutlet weak var prioritySegmentedControl: UISegmentedControl!
    @IBOutlet weak var toDoTitleTextField: UITextField!
    
    @IBAction func savePressed() {
        
        guard let priority = Priority(rawValue: self.prioritySegmentedControl.selectedSegmentIndex),
              let title = self.toDoTitleTextField.text else {
            return
        }
        
        let todo = ToDo(title: title, priority: priority)
        self.todoSubject.onNext(todo)
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
}
