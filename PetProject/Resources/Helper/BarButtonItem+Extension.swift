//
//  BarButtonItem+Extension.swift
//  PetProject
//
//  Created by MRGS on 24.09.2022.
//

import UIKit
//MARK: - UIBarButtonItem extension
extension UIBarButtonItem {
    
    static func addButton(systemNameIcon:String,_ target: Any?, action: Selector) -> UIBarButtonItem {
        let button = CustomButton()
        let largeFont = UIFont.systemFont(ofSize: 20)
        let configuration = UIImage.SymbolConfiguration(font: largeFont)
        button.setImage(UIImage(systemName: systemNameIcon,withConfiguration: configuration), for: .normal)
        button.tintColor = UIColor.TextField.label
        button.layer.borderWidth = 2
        button.backgroundColor = UIColor.TextField.background
        button.layer.cornerRadius = 12
        button.addTarget(target, action: action, for: .touchUpInside)
        
        let menuBarItem = UIBarButtonItem(customView: button)
        menuBarItem.customView?.translatesAutoresizingMaskIntoConstraints = false
        menuBarItem.customView?.heightAnchor.constraint(equalToConstant: 41).isActive = true
        menuBarItem.customView?.widthAnchor.constraint(equalToConstant: 41).isActive = true
        
        return menuBarItem
    }
}
 
