//
//  CustomView.swift
//  PetProject
//
//  Created by MRGS on 14.08.2022.
//

import UIKit

class CustomView: UIView {
    
    override func layoutSubviews() {
         
        self.layer.borderColor = UIColor.Support.border?.cgColor
        self.clipsToBounds = true
 
    }

}
