//
//  VC+Extension.swift
//  PetProject
//
//  Created by MRGS on 24.09.2022.
//

import UIKit
import FirebaseAuth
//MARK: - UIViewController extension
extension UIViewController{
    func clearBackgroundNavigationBar(){
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.layoutIfNeeded()
    }
    
    
    func emptyUser()  {
        if Auth.auth().currentUser == nil {
            let alertController = AlertController()
            alertController.customAlert(text: "Login Error", destText: "Empty user", isHiddenActionButton: true)
            alertController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            alertController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            self.present(alertController, animated: true)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                
                self.navigationController?.viewControllers = [WelcomeVC()]
            }
        }
    }
    
    func hideKeyboardWhenTappedAround() {
        let tapGesture = UITapGestureRecognizer(target: self,
                         action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }

    @objc func hideKeyboard() {
        view.endEditing(true)
    }
}
 
