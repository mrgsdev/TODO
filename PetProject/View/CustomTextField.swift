//
//  CustomTextField.swift
//  PetProject
//
//  Created by MRGS on 14.08.2022.
//

import UIKit

class CustomTextField: UITextField {
    
    
    
    let padding = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20);
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var padding = super.rightViewRect(forBounds: bounds)
        padding.origin.x -= 10
        return padding
        
    }
    override func layoutSubviews() {
        super.layoutSubviews() 
        self.borderStyle = .none
        self.textColor = UIColor.TextField.label
        self.layer.cornerRadius = 15.0
        self.backgroundColor = UIColor.TextField.background
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.Support.border?.cgColor
        self.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        self.clipsToBounds = true
        self.autocorrectionType = .no
        self.autocapitalizationType = .none
        self.font = UIFont(name: UIFont.urbanistMedium , size: 17)
    }
    
    override class func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func customPlaceholder(placeholder:String)  {
        self.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.TextField.placeholder as Any]
        )
    }
    
}
