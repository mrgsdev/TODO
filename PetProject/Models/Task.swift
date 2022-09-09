//
//  Tasks.swift
//  PetProject
//
//  Created by MRGS on 07.09.2022.
//

import Foundation
import FirebaseDatabase
class Task:Hashable{
    static func == (lhs: Task, rhs: Task) -> Bool {
        lhs.title == rhs.title
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
    }
    var title:String
    var description:String
    var ref:DatabaseReference?
//    var completed = false
    
    init(title:String,description:String) {
        self.title = title
        self.description = description
        self.ref = nil
    }
    init(snapshot: DataSnapshot) {
        let snapshotValue = snapshot.value as! [String:AnyObject]
        title = snapshotValue["title"] as! String
        description = snapshotValue["description"] as! String
//        completed = snapshotValue["completed"] as! Bool
        ref = snapshot.ref
    }
}

