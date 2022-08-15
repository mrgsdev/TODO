//
//  DeleteAccountController.swift
//  PetProject
//
//  Created by MRGS on 14.08.2022.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import GoogleSignIn
class DeleteAccountController: UIViewController {
    //MARK: Create UI with Code
    private let labelPrimary: UILabel = {
        let label = UILabel()
        label.text = "Do you really want to delete your account?"
        label.font = UIFont(name: UIFont.urbanistSemiBold, size: 30)
        label.textColor = UIColor.Label.labelPrimary
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let labelSecondary: UILabel = {
        let label = UILabel()
        label.attributedText = NSMutableAttributedString()
        .normal(String(localized:"You will irretrievably lose all your data, including notes.To delete an account, enter:\n"))
        .boldUnderlined(String(localized:"Delete an account"))
        label.textColor = UIColor.Label.labelSecondary
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let deleteTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.customPlaceholder(placeholder: "Enter 'Delete an account'")
        return textField
    }()
    
    
    private lazy var deleteButton: CustomButton = {
        let button = CustomButton()
        button.settingButton(nameFont: UIFont.urbanistSemiBold, sizeFont: 17, borderWidth: 0, cornerRadius: 10, translatesAutoresizingMaskIntoConstraints: false)
        button.setTitle("Delete an account", for: .normal)
        button.setTitleColor(UIColor.Button.label, for: .normal)
        button.addTarget(self, action: #selector(deleteAccountPressed), for: .touchUpInside)
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

extension DeleteAccountController{
    @objc private func popViewButtonPressed(){
        Vibration.light.vibrate()
        navigationController?.popViewController(animated: true)
    }
    @objc private func deleteAccountPressed(){
        deleteAccount()
    }
    private func deleteAccount()  {
        Vibration.soft.vibrate()
        guard let txtfld = deleteTextField.text,txtfld == "Delete an account" else {
            Vibration.error.vibrate()
            let animation = CABasicAnimation(keyPath: "position")
            animation.duration = 0.07
            animation.repeatCount = 2
            animation.autoreverses = true
            animation.fromValue = NSValue(cgPoint: CGPoint(x: deleteTextField.center.x - 10, y: deleteTextField.center.y))
            animation.toValue = NSValue(cgPoint: CGPoint(x: deleteTextField.center.x + 10, y: deleteTextField.center.y))
            deleteTextField.text = "Delete an account👈"
            deleteTextField.layer.add(animation, forKey: "position")
            let loadvc = AlertController()
            loadvc.customAlert(text: "Input Error", destText: "Check that the input is correct✍🏻", isHiddenActionButton: true)
            loadvc.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            loadvc.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            present(loadvc, animated: true)
            return
        }
        let user = Auth.auth().currentUser
        user?.delete { error in
            if let error = error {
                let alertController = AlertController()
                alertController.customAlert(text: "Delete Error", destText: error.localizedDescription, isHiddenActionButton: true)
                alertController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
                alertController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
                self.present(alertController, animated: true)
            } else {
                self.signOut()
                self.navigationController?.viewControllers = [DeleteAlertController()]
                
            }
        }
        if user == nil{
            let alertController = AlertController()
            alertController.customAlert(text: "Error", destText: "you are not logged in to your account", isHiddenActionButton: true)
            alertController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            alertController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            self.present(alertController, animated: true)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.navigationController?.viewControllers = [WelcomeController()]
            }
        }
        
    }
    private func signOut()  {
        do {
            try Auth.auth().signOut()
            GIDSignIn.sharedInstance.signOut()
            UserDefaults.standard.removeObject(forKey: "true")
            // Sign out from Google
        } catch {
            
            let alertController = UIAlertController(title: "Logout Error", message: error.localizedDescription, preferredStyle: .alert)
            let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(okayAction)
            present(alertController, animated: true, completion: nil)
            return
        }
    }
    private func navItemSetupButton()  {
        navigationItem.setHidesBackButton(true, animated: true)
        navigationItem.leftBarButtonItem = .addButton(systemNameIcon: imageSet.backButton.rawValue,self, action: #selector(popViewButtonPressed))
    }
    private func addSubviewElement()  {
        view.addSubview(stackView)
        stackView.addArrangedSubview(labelPrimary)
        stackView.addArrangedSubview(labelSecondary)
        stackView.addArrangedSubview(deleteTextField)
        stackView.addArrangedSubview(deleteButton)
    }
    private func makeConstraints()  {
        NSLayoutConstraint.activate([
            deleteTextField.heightAnchor.constraint(equalToConstant: 56),
            deleteButton.heightAnchor.constraint(equalToConstant: 56),
            
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
        ])
    }
}
