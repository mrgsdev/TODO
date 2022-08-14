//
//  CustomTextView.swift
//  PetProject
//
//  Created by MRGS on 14.08.2022.
//

import UIKit

class CustomTextView: UITextView {
    override func layoutSubviews() {
        self.layer.borderColor = UIColor.Support.border?.cgColor
        self.layer.borderWidth = 2
        self.clipsToBounds = true 
        self.backgroundColor = UIColor.TextField.background //Assest->ColorSet->
        self.layer.cornerRadius = 25
        self.textContainer.lineFragmentPadding = 8
        self.showsVerticalScrollIndicator = false
    }
    
}
