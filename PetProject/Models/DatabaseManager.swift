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
  
}
