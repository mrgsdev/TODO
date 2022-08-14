//
//  ForgotController.swift
//  PetProject
//
//  Created by MRGS on 14.08.2022.
//

import UIKit
import FirebaseCore
import FirebaseAuth
class ForgotController: UIViewController {
    // MARK: - Create UI with Code
    private let mainLabel: UILabel = {
        let label = UILabel()
        label.text = "Forgot Password?"
        if let customFont = UIFont(name: UIFont.urbanistSemiBold, size: 30) {
            let fontMetrics = UIFontMetrics(forTextStyle: .title1)
            label.font = fontMetrics.scaledFont(for: customFont)
        }
        label.textColor = UIColor.Label.labelPrimary
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Don't worry! It occurs. Please enter the email address linked with your account."
        label.textColor = UIColor(rgb: 0x8391A1)
        label.font = UIFont(name: UIFont.urbanistExtraLight, size: 16)
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
    private lazy var sendCodeButton: CustomButton = {
        let sendCodeButton = CustomButton()
        //        sendCodeButton.backgroundColor = .white
        sendCodeButton.settingButton(nameFont: UIFont.urbanistSemiBold, sizeFont: 17, borderWidth: 0, cornerRadius: 10, translatesAutoresizingMaskIntoConstraints: false)
        sendCodeButton.backgroundColor = UIColor.Button.background
        sendCodeButton.setTitleColor(UIColor.Label.labelTertiary, for: .normal)
        sendCodeButton.setTitle("Send Code", for: .normal)
        sendCodeButton.addTarget(self, action: #selector(forgotPasswordPress), for: .touchUpInside)
        return sendCodeButton
    }()
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        //        stackView.backgroundColor = .gray
        stackView.axis = .vertical
        stackView.distribution  = .fill
        stackView.alignment = .fill
        stackView.spacing = 20
        // autolayout constraint
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.Support.background
        clearBackgroundNavigationBar()
        navItemSetupButton()
        addSubviewElement()
        makeConstraints()
    }
}

// MARK: - extension ForgotController
extension ForgotController{
    @objc private func forgotPasswordPress(){
        // Validate the input
        guard let email = emailTextField.text, email != "" else {
             
            let alertController = AlertController()
            Vibration.error.vibrate()
            alertController.customAlert(text: "Login Error", destText: "Both fields must not be blank.", isHiddenActionButton: true)
            alertController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            alertController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            self.present(alertController, animated: true)
            
            return
        }
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            guard let error = error else {
                let alertController = AlertController()
                Vibration.success.vibrate()
                alertController.customAlert(text: "Check Your Email", destText: "", isHiddenActionButton: true)
                alertController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
                alertController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
                self.present(alertController, animated: true)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1 ) {
                    
                    self.navigationController?.popViewController(animated: true)
                }
                return
            }
//            if let error = error{ // no work
//                let alertController = AlertController()
//                Vibration.error.vibrate()
//                alertController.customAlert(text: "Error", destText: error.localizedDescription, isHiddenActionButton: true)
//                alertController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
//                alertController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
//                self.present(alertController, animated: true)
//            }
            let alertController = AlertController()
            Vibration.error.vibrate()
            alertController.customAlert(text: "Error", destText: error.localizedDescription, isHiddenActionButton: true)
            alertController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            alertController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            self.present(alertController, animated: true)
           
            
        }
    }
    @objc private func popViewButtonPressed(){
        Vibration.light.vibrate()
        navigationController?.popViewController(animated: true)
    }
    
   
    
    private func addSubviewElement()  {
        view.addSubview(stackView)
        stackView.addArrangedSubview(mainLabel)
        stackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(sendCodeButton)
        
        
        
    }
    
    private func makeConstraints()  {
        NSLayoutConstraint.activate([
            
            emailTextField.heightAnchor.constraint(equalToConstant: 56),
            sendCodeButton.heightAnchor.constraint(equalToConstant: 56),
            
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            
            
            
            
            
        ])
    }
    
    private func navItemSetupButton(){
        navigationItem.setHidesBackButton(true, animated: true)
        navigationItem.leftBarButtonItem = .addButton(systemNameIcon: imageSet.backButton.rawValue, self, action: #selector(popViewButtonPressed))
    }
}
