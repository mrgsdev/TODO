//
//  LoginController.swift
//  PetProject
//
//  Created by MRGS on 14.08.2022.
//

import UIKit
import FirebaseAuth
import FirebaseCore
import GoogleSignIn
class LoginController: UIViewController {
    
    private var clickOnEye = true
    private let isSecureImage = UIImageView()
    
    //MARK: Create UI with Code
    private let mainLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome back! Glad to see you, Again!"
        label.textColor = UIColor.Label.labelPrimary
        label.font =  UIFont(name:  UIFont.urbanistSemiBold, size: 30)
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let emailTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.tag = 0
        textField.customPlaceholder(placeholder: "Enter your email")
        return textField
    }()
    
    private let passwordTextField: CustomTextField = {
        let textField = CustomTextField()
        
        textField.tag = 1//Increment accordingly
        textField.customPlaceholder(placeholder: "Enter your password")
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private lazy var forgotPassword:CustomButton = {
        let button = CustomButton()
        button.settingButton(nameFont: UIFont.urbanistExtraLight,
                             sizeFont: 14, borderWidth: 0,
                             cornerRadius: 0,
                             translatesAutoresizingMaskIntoConstraints: false
        )
        button.backgroundColor = .clear
        button.setTitleColor(UIColor.TextField.label, for: .normal)
        button.contentHorizontalAlignment = .right
        button.setTitle("Forgot Password?", for: .normal)
        button.addTarget(self, action: #selector(forgotPasswordPress),
                         for: .touchUpInside)
        return button
    }()
    
    private lazy var loginButton: CustomButton = {
        let button = CustomButton()
        button.settingButton(nameFont: UIFont.urbanistSemiBold, sizeFont: 17, borderWidth: 0, cornerRadius: 10, translatesAutoresizingMaskIntoConstraints: false)
        button.setTitle("Login", for: .normal)
        button.setTitleColor(UIColor.Button.label, for: .normal)
        button.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution  = .fill
        stackView.alignment = .fill
        stackView.spacing = 15
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let orLoginWith: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.Label.labelTertiary
        label.text = "Or Login with"
        label.backgroundColor = UIColor.Support.background
        label.textAlignment = .center
        label.font = UIFont(name: UIFont.urbanistSemiBold, size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let lineView: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor.Label.labelTertiary
        line.alpha = 0.5
        line.translatesAutoresizingMaskIntoConstraints = false
        return line
    }()
    private let googleAuth: CustomButton = {
        let googleAuth = CustomButton()
        googleAuth.settingButton(borderWidth: 2, cornerRadius: 10, translatesAutoresizingMaskIntoConstraints: false)
        googleAuth.backgroundColor = .clear
        googleAuth.setImage(UIImage(named: imageSet.googleIcon.rawValue), for: .normal)
        googleAuth.addTarget(self, action: #selector(googleAuthPressed), for: .touchUpInside)
        
        return googleAuth
    }()
    private let appleAuth: CustomButton = {
        let appleAuth = CustomButton()
        appleAuth.settingButton(borderWidth: 2, cornerRadius: 10, translatesAutoresizingMaskIntoConstraints: false)
        let largeFont = UIFont.systemFont(ofSize: 30)
        let configuration = UIImage.SymbolConfiguration(font: largeFont)
        appleAuth.setImage(UIImage(systemName: "applelogo",withConfiguration: configuration), for: .normal)
        appleAuth.tintColor = UIColor.Label.labelPrimary
        appleAuth.backgroundColor = .clear
        appleAuth.translatesAutoresizingMaskIntoConstraints = false
        return appleAuth
    }()
    private let stackViewGoogleApple: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution  = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        hideKeyboardWhenTappedAround()
        view.backgroundColor = UIColor.Support.background
        clearBackgroundNavigationBar()
        navItemSetupButton()
        eyeButton()
        addSubviewElement()
        makeConstraints()
    }
}

//MARK: - extension LoginController

extension LoginController{
    @objc private func loginButtonPressed(){
        Vibration.light.vibrate()
        // Validate the input
        guard let emailAddress = emailTextField.text, emailAddress != "",
              let password = passwordTextField.text, password != "" else {
            Vibration.error.vibrate()
            //                        let alertController = UIAlertController(title: "Login Error", message: "Both fields must not be blank.", preferredStyle: .alert)
            //                        let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            //                        alertController.addAction(okayAction)
            //                        present(alertController, animated: true, completion: nil)
            let alertController = AlertController()
            alertController.customAlert(text: "Login Error", destText: "Both fields must not be blank.", isHiddenActionButton: true)
            alertController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            alertController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            self.present(alertController, animated: true)
            
            return
        }
        
        // Perform login by calling Firebase APIs
        Auth.auth().signIn(withEmail: emailAddress, password: password, completion: { (result, error) in
            
            if let error = error {
                Vibration.error.vibrate()
                //                        let alertController = UIAlertController(title: "Login Error", message: error.localizedDescription, preferredStyle: .alert)
                //                        let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                //                        alertController.addAction(okayAction)
                //                        self.present(alertController, animated: true, completion: nil)
                //
                let alertController = AlertController()
                alertController.customAlert(text: "Login Error", destText: error.localizedDescription, isHiddenActionButton: true)
                alertController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
                alertController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
                self.present(alertController, animated: true)
                return
            }
            
            // Email verification
            guard let result = result, result.user.isEmailVerified else {
                Vibration.error.vibrate()
                //                        let alertController = UIAlertController(title: "Login Error", message: "You haven't confirmed your email address yet. We sent you a confirmation email when you sign up. Please click the verification link in that email. If you need us to send the confirmation email again, please tap Resend Email.", preferredStyle: .alert)
                //
                //                        let okayAction = UIAlertAction(title: "Resend email", style: .default, handler: { (action) in
                //
                //                            Auth.auth().currentUser?.sendEmailVerification(completion: nil)
                //                        })
                //                        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                //                        alertController.addAction(okayAction)
                //                        alertController.addAction(cancelAction)
                //
                //                        self.present(alertController, animated: true, completion: nil)
                
                let alertController = AlertController()
                alertController.textButton = "Send Email"
                alertController.actionButton.setTitle(alertController.textButton, for: .normal)
                alertController.customAlert(text: "Login Error", destText:"You haven't confirmed your email address yet. We sent you a confirmation email when you sign up. Please click the verification link in that email. If you need us to send the confirmation email again, please tap Resend Email.", isHiddenActionButton: false)
                alertController.modalPresentationStyle = .overCurrentContext
                alertController.modalTransitionStyle = .crossDissolve
                self.present(alertController, animated: true)
                return
            }
            
            
            // Dismiss keyboard
            self.view.endEditing(true)
            Vibration.success.vibrate()
            // Present the main view
            let navVc = ToDoViewController()
            UserDefaults.standard.set(true, forKey: "true")
            self.navigationController?.pushViewController(navVc, animated: true)
            //        UserDefaults.standard.set(true, forKey: "true")
            
        })
        
    }
    @objc private func popViewButtonPressed(){
        Vibration.light.vibrate()
        navigationController?.popViewController(animated: true)
    }
    @objc private func imageTap(tap:UITapGestureRecognizer){
        Vibration.soft.vibrate()
        let tapImage = tap.view as! UIImageView
        if clickOnEye{
            clickOnEye = !clickOnEye
            tapImage.image = UIImage(systemName: "eye.slash")
            passwordTextField.isSecureTextEntry = clickOnEye
        }else{
            clickOnEye = !clickOnEye
            tapImage.image = UIImage(systemName: "eye")
            passwordTextField.isSecureTextEntry = clickOnEye
        }
    }
    @objc private func forgotPasswordPress(){
        let navVc = ForgotController()
        Vibration.light.vibrate()
        navigationController?.pushViewController(navVc, animated: true)
    }
    @objc private func googleAuthPressed(){
        Vibration.light.vibrate()
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        
        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(with: config, presenting: self) { [unowned self] user, error in
            
            if let error = error {
                let alertController = AlertController()
                alertController.customAlert(text: "Login Error", destText: error.localizedDescription, isHiddenActionButton: true)
                alertController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
                alertController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
                self.present(alertController, animated: true)
                return
            }
            
            guard let authentication = user?.authentication, let idToken = authentication.idToken else {
                return
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: authentication.accessToken)
            // Authenticate with Firebase using the credential object
            Auth.auth().signIn(with: credential) { (authResult, error) in
                if let error = error {
                    print("Error occurs when authenticate with Firebase: \(error.localizedDescription)")
                }
                
                // Present the main view
                let navVc = ToDoViewController()
                UserDefaults.standard.set(true, forKey: "true")
                Vibration.success.vibrate()
                self.navigationController?.pushViewController(navVc, animated: true)
            }
        }
    }
    private func navItemSetupButton() {
        navigationItem.setHidesBackButton(true, animated: true)
        navigationItem.leftBarButtonItem = .addButton(systemNameIcon: imageSet.backButton.rawValue,self, action: #selector(popViewButtonPressed))
    }
    private func eyeButton() {
        isSecureImage.image = UIImage(systemName: "eye")
        isSecureImage.tintColor = UIColor.Label.labelSecondary
        passwordTextField.rightView = isSecureImage
        passwordTextField.rightViewMode = .always
        let tapGec = UITapGestureRecognizer(target: self, action: #selector(imageTap(tap:)))
        isSecureImage.isUserInteractionEnabled = true
        isSecureImage.addGestureRecognizer(tapGec)
    }
    private func addSubviewElement()  {
        view.addSubview(lineView)
        view.addSubview(orLoginWith)
        view.addSubview(googleAuth)
        view.addSubview(stackView)
        view.addSubview(stackViewGoogleApple)
        
        stackView.addArrangedSubview(mainLabel)
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(forgotPassword)
        stackView.addArrangedSubview(loginButton)
        
        stackViewGoogleApple.addArrangedSubview(googleAuth)
        stackViewGoogleApple.addArrangedSubview(appleAuth)
        
        
    }
    private func makeConstraints()  {
        NSLayoutConstraint.activate([
            emailTextField.heightAnchor.constraint(equalToConstant: 56),
            passwordTextField.heightAnchor.constraint(equalToConstant: 56),
            forgotPassword.heightAnchor.constraint(equalToConstant: 10),
            loginButton.heightAnchor.constraint(equalToConstant: 56),
            
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            
            orLoginWith.bottomAnchor.constraint(equalTo: stackView.bottomAnchor,constant: 20),
            orLoginWith.widthAnchor.constraint(equalToConstant: 110),
            lineView.bottomAnchor.constraint(equalTo: orLoginWith.centerYAnchor),
            lineView.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 20),
            lineView.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -20),
            orLoginWith.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 1),
            
            stackViewGoogleApple.topAnchor.constraint(equalTo: orLoginWith.bottomAnchor,constant: 10),
            stackViewGoogleApple.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 20),
            stackViewGoogleApple.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -20),
            stackViewGoogleApple.heightAnchor.constraint(equalToConstant: 56),
        ])
    }
}
extension LoginController:UITextFieldDelegate{
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
