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
    
    init(mainTask:String,detailTask:String?) {
        self.taskPrimary = mainTask
        self.taskSecondary = detailTask
    }
     
}
