//
//  AddTaskViewController.swift
//  Awesome To Do
//
//  Created by Aaron Lee on 9/18/20.
//

import UIKit

class AddToDoViewController: UIViewController {
    
    @IBOutlet weak var prioritySegmentedControl: UISegmentedControl!
    @IBOutlet weak var toDoTitleTextField: UITextField!
    
    @IBAction func savePressed() {
        
        guard let priority = Priority(rawValue: self.prioritySegmentedControl.selectedSegmentIndex),
              let title = self.toDoTitleTextField.text else {
            return
        }
        
        let todo = ToDo(title: title, priority: priority)
        
    }
    
}
