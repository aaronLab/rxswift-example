//
//  Task.swift
//  ToDoList
//
//  Created by Aaron Lee on 2021/03/23.
//

import Foundation

enum Priority: Int {
    case high
    case medium
    case low
}

struct Task {
    let title: String
    let priority: Priority
}
