//
//  CustomButton.swift
//  PetProject
//
//  Created by MRGS on 14.08.2022.
//

import UIKit

class CustomButton: UIButton {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.borderColor = UIColor.Support.border?.cgColor
    }
    func settingButton(nameFont:String? = nil,sizeFont:CGFloat? = nil,
                       borderWidth:CGFloat,
                       cornerRadius:CGFloat,
                       translatesAutoresizingMaskIntoConstraints:Bool)  {
        self.titleLabel?.font = UIFont(name: nameFont ?? "", size: sizeFont ?? 0)
    self.backgroundColor = UIColor.Button.background
    self.layer.borderWidth = borderWidth
    self.layer.cornerRadius = cornerRadius
    self.translatesAutoresizingMaskIntoConstraints = false
    }
}
