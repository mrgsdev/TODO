//
//  DatabaseManager.swift
//  PetProject
//
//  Created by MRGS on 16.09.2022.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth
final class DatabaseManager{
    static let shared = DatabaseManager()
    private let database = Database.database().reference()
    
    public func insertUser(with user: Users){
        let userAuth = Auth.auth().currentUser
        database.child("users").child(userAuth!.uid).setValue([
            "username":user.username,
            "email":user.email
        ])
    }
  
    public func test(arrayTODO:[Task]){
        let user = Auth.auth().currentUser
        print("USER: \(user!.uid)")
        database.child("users").child(user!.uid).child("tasks").observe(.value) { snapshot in
            var junkArray = arrayTODO 
           
            print(junkArray.count)
            for item in snapshot.children{
                let task = Task(snapshot: item as! DataSnapshot)
                junkArray.append(task) 
            }
            print(junkArray.count) 
        }
    }
    
    public func remove(parentA: String) {
        
        database.child("users").child(parentA).removeValue { error, _ in
            print(error)
        }
 
    }
  
}
