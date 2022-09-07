//
//  Tasks.swift
//  PetProject
//
//  Created by MRGS on 07.09.2022.
//

import Foundation
import FirebaseDatabase
class Tasks:Hashable{
    static func == (lhs: Tasks, rhs: Tasks) -> Bool {
        lhs.title == rhs.title
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
    }
    let title:String
    let description:String
    var ref:DatabaseReference?
//    var completed = false
    
    init(title:String,description:String) {
        self.title = title
        self.description = description
        self.ref = nil
    }
    init(snapshot: DataSnapshot) {
        let snapshotValue = snapshot.value as! [String:AnyObject]
        title = snapshotValue["textPrimary"] as! String
        description = snapshotValue["textSecondary"] as! String
//        completed = snapshotValue["completed"] as! Bool
        ref = snapshot.ref
    }
}

