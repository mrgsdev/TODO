//
//  TodoModel.swift
//  PetProject
//
//  Created by MRGS on 14.08.2022.
//

import UIKit

class TodoModel {
    var mainTask:String
    var detailTask:String?
    
    init(mainTask:String,detailTask:String?) {
        self.mainTask = mainTask
        self.detailTask = detailTask
    }
     
}
