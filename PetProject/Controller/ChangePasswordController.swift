//
//  ChangePasswordController.swift
//  PetProject
//
//  Created by MRGS on 14.08.2022.
//

import UIKit
import FirebaseCore
import FirebaseAuth
class ChangePasswordController: UIViewController {
    
    //MARK: Create UI with Code
    private let labelPrimary: UILabel = {
        let label = UILabel()
        label.text = "Create new password"
            label.font = UIFont(name: UIFont.urbanistSemiBold, size: 30)
        label.textColor = UIColor.Label.labelPrimary
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let labelSecondary: UILabel = {
        let label = UILabel()
        label.text = "Your new password must be unique from those previously used."
        label.textColor = UIColor.Label.labelSecondary
        label.font = UIFont(name: UIFont.urbanistSemiBold, size: 16)
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let newPasswordTextField: CustomTextField = {
        let textfield = CustomTextField()
        textfield.customPlaceholder(placeholder: "New Password")
        return textfield
    }()
    private let confirmPasswordTextField: CustomTextField = {
        let textfield = CustomTextField()
        textfield.customPlaceholder(placeholder: "Confirm Password")
        return textfield
    }()
    
    
    private lazy var resetPasswordButton: CustomButton = {
        let button = CustomButton()
        
        button.settingButton(nameFont: UIFont.urbanistSemiBold, sizeFont: 17, borderWidth: 0, cornerRadius: 10, translatesAutoresizingMaskIntoConstraints: false)
        button.setTitle("Reset Password", for: .normal)
        button.setTitleColor(UIColor.Button.label, for: .normal)
        button.addTarget(self, action: #selector(changePasswordButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution  = .fill
        stackView.alignment = .fill
        stackView.spacing = 20
        // autolayout constraint
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.Support.background
        clearBackgroundNavigationBar()
        navItemSetupButton()
        addSubviewElement()
        makeConstraints()
    }
    
}
extension ChangePasswordController{
    @objc private func popViewButtonPressed(){
        Vibration.light.vibrate()
        navigationController?.popViewController(animated: true)
    }
    @objc private func changePasswordButtonPressed(){
        Vibration.light.vibrate()
            // Validate the input
            guard let password = newPasswordTextField.text, password != "" else {
                Vibration.error.vibrate()
                let alertController = AlertController()
                alertController.customAlert(text: "Oooops😓", destText: "You forgot to write a new password", isHiddenActionButton: true)
                alertController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
                alertController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
                self.present(alertController, animated: true)
                
                return
            }
            guard let confirmPassword = confirmPasswordTextField.text,confirmPassword != "" else {
                Vibration.error.vibrate()
                let alertController = AlertController()
                alertController.customAlert(text: "Oooops😓", destText: "You forgot to write a confirm password", isHiddenActionButton: true)
                alertController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
                alertController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
                self.present(alertController, animated: true)
                
                return
            }
            guard let password = newPasswordTextField.text,let confirmPassword = confirmPasswordTextField.text,password == confirmPassword else {
                Vibration.error.vibrate()
                let alertController = AlertController()
                alertController.customAlert(text: "Passwords do not match", destText: "Make sure the input is correct", isHiddenActionButton: true)
                alertController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
                alertController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
                self.present(alertController, animated: true)
                
                return
                
            }
            Auth.auth().currentUser?.updatePassword(to: password) { error in
                
                guard let error = error else {
                    let alertController = AlertController()
                    Vibration.success.vibrate()
                    alertController.customAlert(text: "Password Change🥳", destText: "", isHiddenActionButton: true)
                    alertController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
                    alertController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
                    self.present(alertController, animated: true)
                    
                      DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                          self.navigationController?.popViewController(animated: true)
                      }
                    return
                    
                }
//                if let error = error{
//                    Vibration.error.vibrate()
//                    let alertController = AlertController()
//                    alertController.customAlert(text: "Error", destText: error.localizedDescription, isHiddenActionButton: true)
//                    alertController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
//                    alertController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
//                    self.present(alertController, animated: true)
//                }
                Vibration.error.vibrate()
                let alertController = AlertController()
                alertController.customAlert(text: "Error", destText: error.localizedDescription, isHiddenActionButton: true)
                alertController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
                alertController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
                self.present(alertController, animated: true)
            }
            
               
    //
           
        }
    private func navItemSetupButton()  {
        navigationItem.setHidesBackButton(true, animated: true)
        navigationItem.leftBarButtonItem = .addButton(systemNameIcon: imageSet.backButton.rawValue,self, action: #selector(popViewButtonPressed))
    }
    private func addSubviewElement()  {
        view.addSubview(stackView)
        stackView.addArrangedSubview(labelPrimary)
        stackView.addArrangedSubview(labelSecondary)
        stackView.addArrangedSubview(newPasswordTextField)
        stackView.addArrangedSubview(confirmPasswordTextField)
        stackView.addArrangedSubview(resetPasswordButton)
    }
    private func makeConstraints()  {
        NSLayoutConstraint.activate([
            newPasswordTextField.heightAnchor.constraint(equalToConstant: 56),
            confirmPasswordTextField.heightAnchor.constraint(equalToConstant: 56),
            resetPasswordButton.heightAnchor.constraint(equalToConstant: 56),
            
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
        ])
    }
}
