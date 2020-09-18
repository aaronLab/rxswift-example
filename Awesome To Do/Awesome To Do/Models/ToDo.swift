//
//  ToDo.swift
//  Awesome To Do
//
//  Created by Aaron Lee on 9/18/20.
//

import Foundation

enum Priority: Int {
    case high
    case medium
    case low
}

struct ToDo {
    let title: String
    let priority: Priority
}
