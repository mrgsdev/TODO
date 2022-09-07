//
//  ChangePasswordController.swift
//  PetProject
//
//  Created by MRGS on 14.08.2022.
//

import UIKit
import FirebaseCore
import FirebaseAuth
class ChangePasswordVC: UIViewController {
    
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
    private let oldPasswordTextField: CustomTextField = {
        let textfield = CustomTextField()
        textfield.tag = 0
        textfield.customPlaceholder(placeholder: "Old Password")
        return textfield
    }()
    private let newPasswordTextField: CustomTextField = {
        let textfield = CustomTextField()
        textfield.tag = 1
        textfield.customPlaceholder(placeholder: "New Password")
        return textfield
    }()
    private let confirmPasswordTextField: CustomTextField = {
        let textfield = CustomTextField()
        textfield.tag = 2
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
        oldPasswordTextField.delegate = self
        newPasswordTextField.delegate = self
        confirmPasswordTextField.delegate = self
        view.backgroundColor = UIColor.Support.background
        clearBackgroundNavigationBar()
        hideKeyboardWhenTappedAround()
        navItemSetupButton()
        addSubviewElement()
        makeConstraints()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    } 
}
extension ChangePasswordVC{
    @objc private func popViewButtonPressed(){
        Vibration.light.vibrate()
        navigationController?.popViewController(animated: true)
    }
    @objc private func changePasswordButtonPressed(){
        Vibration.light.vibrate()
        // Validate the input
        guard let oldPassword = oldPasswordTextField.text,let password = newPasswordTextField.text,let confirmPassword = confirmPasswordTextField.text, password != "",confirmPassword != "",oldPassword != "" else {
            Vibration.error.vibrate()
            let alertController = AlertController()
            alertController.customAlert(text: "Oooops😓", destText: "You forgot to write a *** password", isHiddenActionButton: true)
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
        let user = Auth.auth().currentUser
        let credential: AuthCredential = EmailAuthProvider.credential(withEmail: (user?.email)!, password: oldPassword) 
        user?.reauthenticate(with: credential) { result,error  in
            if let error = error {
                Vibration.error.vibrate()
                let alertController = AlertController()
                alertController.customAlert(text: "Error", destText: error.localizedDescription, isHiddenActionButton: true)
                alertController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
                alertController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
                self.present(alertController, animated: true)
                print("DEL=\(oldPassword)=") 
                print("DEL=\(String(describing: user?.email))=")
            } else {
                print("Suc\(oldPassword)")
                print("Suc=\(String(describing: user?.email))=")
                
                
                
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
                 
                    Vibration.error.vibrate()
                    let alertController = AlertController()
                    alertController.customAlert(text: "Error", destText: error.localizedDescription, isHiddenActionButton: true)
                    alertController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
                    alertController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
                    self.present(alertController, animated: true)
                }
                
                
                
            }
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
        stackView.addArrangedSubview(oldPasswordTextField)
        stackView.addArrangedSubview(newPasswordTextField)
        stackView.addArrangedSubview(confirmPasswordTextField)
        stackView.addArrangedSubview(resetPasswordButton)
    }
    private func makeConstraints()  {
        NSLayoutConstraint.activate([
            oldPasswordTextField.heightAnchor.constraint(equalToConstant: 56),
            newPasswordTextField.heightAnchor.constraint(equalToConstant: 56),
            confirmPasswordTextField.heightAnchor.constraint(equalToConstant: 56),
            resetPasswordButton.heightAnchor.constraint(equalToConstant: 56),
            
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
        ])
    }
}
extension ChangePasswordVC:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Try to find next responder
              if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
                 nextField.becomeFirstResponder()
              } else {
                 // Not found, so remove keyboard.
                 textField.resignFirstResponder()
              }
              // Do not add a line break
              return false
    }
}
