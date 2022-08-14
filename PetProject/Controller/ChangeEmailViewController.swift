//
//  ChangeEmailViewController.swift
//  PetProject
//
//  Created by MRGS on 14.08.2022.
//


import UIKit
import FirebaseAuth
import FirebaseCore
class ChangeEmailViewController: UIViewController {
    //MARK: Create UI with Code
    private let labelPrimary: UILabel = {
        let label = UILabel()
        label.text = "Create new email"
            label.font = UIFont(name: UIFont.urbanistSemiBold, size: 30)
        label.textColor = UIColor.Label.labelPrimary
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let labelSecondary: UILabel = {
        let label = UILabel()
        label.text = "Your new email must be unique from those previously used."
        label.textColor = UIColor.Label.labelSecondary
        label.font =  UIFont(name: UIFont.urbanistExtraLight, size: 16)
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let emailTextField: CustomTextField = {
        let email = CustomTextField()
        email.customPlaceholder(placeholder: "Enter your email")
        return email
    }()
    
     
    private lazy var resetEmailButton: CustomButton = {
        let button = CustomButton()
        button.settingButton(nameFont: UIFont.urbanistSemiBold, sizeFont: 17, borderWidth: 0, cornerRadius: 10, translatesAutoresizingMaskIntoConstraints: false)
        button.setTitleColor(UIColor.Button.label, for: .normal)
        button.setTitle("Save New Email", for: .normal)
        button.addTarget(self, action: #selector(changeEmailButtonPressed), for: .touchUpInside)
        return button
    }()
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution  = .fill
        stackView.alignment = .fill
        stackView.spacing = 20
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

extension ChangeEmailViewController{
    @objc private func popViewButtonPressed(){
        navigationController?.popViewController(animated: true)
        Vibration.light.vibrate()
    }
    @objc private func changeEmailButtonPressed(){
        print(#function)
        // Validate the input
        Vibration.light.vibrate()
        guard let email = emailTextField.text, email != "" else {
            Vibration.error.vibrate()
            let alertController = AlertController()
            alertController.customAlert(text: "Error", destText: "Both fields must not be blank.", isHiddenActionButton: true)
            alertController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            alertController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            self.present(alertController, animated: true)

            return
        }

        Auth.auth().currentUser?.updateEmail(to: email) { error in
            guard let error = error else {
                Vibration.success.vibrate()
                let alertController = AlertController()
                alertController.customAlert(text: "Email Change🥳", destText: "All that's left is to confirm the mail", isHiddenActionButton: true)
                Auth.auth().currentUser?.sendEmailVerification(completion: nil)
                alertController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
                alertController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
                self.present(alertController, animated: true)
                
                  DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                      self.navigationController?.popViewController(animated: true)
                  }
                return
            }
//            if let error = error{ // no work
//                let alertController = AlertController()
//                alertController.customAlert(text: "Error", destText: error.localizedDescription, isHiddenActionButton: true)
//                alertController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
//                alertController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
//                self.present(alertController, animated: true)
//            }
            Vibration.error.vibrate()
            let alertController = AlertController()
            alertController.customAlert(text: "Error", destText: error.localizedDescription, isHiddenActionButton: true)
            alertController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            alertController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            self.present(alertController, animated: true)

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
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(resetEmailButton)
    }
    private func makeConstraints()  {
        NSLayoutConstraint.activate([
            emailTextField.heightAnchor.constraint(equalToConstant: 56),
            resetEmailButton.heightAnchor.constraint(equalToConstant: 56),
        
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
        ])
    }
}

