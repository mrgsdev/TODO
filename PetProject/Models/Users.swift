//
//  Users.swift
//  PetProject
//
//  Created by MRGS on 07.09.2022.
//

import Foundation

struct Users {
    let username:String
    let email:String
    
    var safeEmail:String{
        var safeEmail = email.replacingOccurrences(of: ".", with: "|")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "*")
        return safeEmail
    }
    
    var profilePictureFileName: String{
        return "\(safeEmail)_profile_pic.png"
    }
}
