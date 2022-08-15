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
        //        reAuth()
    }
    func reAuth(){
        var pass = "9"
        //
        
        //1. Create the alert controller.
        let alert = UIAlertController(title: "Some Title", message: "Enter a text", preferredStyle: .alert)
        
        //2. Add the text field. You can configure it however you need.
        alert.addTextField { (textField) in
            textField.text = "Some default text"
        }
        
        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
            print("Text field: \(textField!.text)")
            pass = textField!.text!
            let user = Auth.auth().currentUser
            var credential: AuthCredential = EmailAuthProvider.credential(withEmail: (user?.email)!, password: pass)
            user?.reauthenticate(with: credential) { result,error  in
                if let error = error {
                    print("DEL=\(pass)=")
                    print("DEL=\(user?.email)=")
                } else {
                    print("Suc\(pass)")
                }
            }
        }))
        
        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
        
        
    }
    //        let user = Auth.auth().currentUser
    //        var credential: AuthCredential = EmailAuthProvider.credential(withEmail: "***@gmail.com", password: "123123")
    //
    //        user?.reauthenticate(with: credential) { result, error in
    //             if let error = error {
    //                 let alertController = AlertController()
    //                 alertController.customAlert(text: "Error", destText: error.localizedDescription, isHiddenActionButton: true)
    //                 alertController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
    //                 alertController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
    //                 self.present(alertController, animated: true)
    //             } else {
    //                 print("2")
    //             }
    //        }
    //    }
}
extension ChangePasswordController{
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
        var credential: AuthCredential = EmailAuthProvider.credential(withEmail: (user?.email)!, password: oldPassword)
        user?.reauthenticate(with: credential) { result,error  in
            if let error = error {
                Vibration.error.vibrate()
                let alertController = AlertController()
                alertController.customAlert(text: "Error", destText: error.localizedDescription, isHiddenActionButton: true)
                alertController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
                alertController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
                self.present(alertController, animated: true)
                print("DEL=\(oldPassword)=") 
                print("DEL=\(user?.email)=")
            } else {
                print("Suc\(oldPassword)")
                print("DEL=\(user?.email)=")
                
                
                
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
extension ChangePasswordController:UITextFieldDelegate{
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
