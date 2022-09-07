//
//  TodoModel.swift
//  PetProject
//
//  Created by MRGS on 14.08.2022.
//

import UIKit

class TodoModel:Hashable {
    static func == (lhs: TodoModel, rhs: TodoModel) -> Bool {
        lhs.taskPrimary == rhs.taskPrimary
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(taskPrimary)
    }
    var taskPrimary:String
    var taskSecondary:String?
    static var arrayTodo = [TodoModel]()
    init(taskPrimary:String,taskSecondary:String?) {
        self.taskPrimary = taskPrimary
        self.taskSecondary = taskSecondary
    }
     
}
