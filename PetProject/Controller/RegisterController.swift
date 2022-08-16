//
//  RegisterController.swift
//  PetProject
//
//  Created by MRGS on 14.08.2022.
//

import UIKit
import FirebaseAuth
import FirebaseCore
import FirebaseDatabase
import GoogleSignIn
class RegisterController: UIViewController {
    private var databaseRef = Database.database().reference()
    // MARK: - Create UI with Code
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.frame = self.view.bounds
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentSize = contentSize
        return scrollView
    }()
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.frame.size = contentSize
        return contentView
    }()
    private var contentSize: CGSize {
        CGSize(width: view.frame.width, height: view.frame.height) // + 20
    }
    private let registerLabel: UILabel = {
        let label = UILabel()
        label.text = "Hello! Register to get started"
        label.font = UIFont(name: UIFont.urbanistSemiBold, size: 30)
        label.textColor = UIColor.Label.labelPrimary
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let userTextField: CustomTextField = {
        let textfield = CustomTextField()
        textfield.tag = 0
        textfield.autocapitalizationType = .allCharacters
        textfield.customPlaceholder(placeholder: "Enter username")
        return textfield
    }()
    private let emailTextField: CustomTextField = {
        let textfield = CustomTextField()
        textfield.tag = 1
        textfield.customPlaceholder(placeholder: "Enter email")
        return textfield
    }()
    private let passwordTextField: CustomTextField = {
        let textfield = CustomTextField()
        textfield.tag = 2
        textfield.customPlaceholder(placeholder: "Enter password")
        return textfield
    }()
    private let confirmPasswordTextField: CustomTextField = {
        let textfield = CustomTextField()
        textfield.tag = 3
        //        textfield.layer.borderColor = UIColor.yellow.cgColor
        textfield.customPlaceholder(placeholder: "Enter confirm username")
        return textfield
    }()
    private lazy var registerButton: CustomButton = {
        let registerButton = CustomButton()
        registerButton.settingButton(nameFont: UIFont.urbanistSemiBold, sizeFont: 17, borderWidth: 0, cornerRadius: 10, translatesAutoresizingMaskIntoConstraints: false)
        registerButton.setTitle("Register", for: .normal)
        registerButton.setTitleColor(UIColor.Button.label, for: .normal)
        registerButton.addTarget(self, action: #selector(registerButtonPressed), for: .touchUpInside)
        return registerButton
    }()
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution  = .fill
        stackView.alignment = .fill
        stackView.spacing = 15
        // autolayout constraint
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    private let orRegisterWith: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.Label.labelTertiary
        label.text = "Or Register with"
        label.backgroundColor = UIColor.Support.background
        label.textAlignment = .center
        if let customFont = UIFont(name: "Urbanist-SemiBold", size: 14) {
            let fontMetrics = UIFontMetrics(forTextStyle: .title1)
            label.font = fontMetrics.scaledFont(for: customFont)
        }
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let lineView: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor.Label.labelTertiary
        line.alpha = 0.4
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
        //                stackView.backgroundColor = .gray
        stackView.axis = .horizontal
        stackView.distribution  = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 10
        // autolayout constraint
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        userTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        confirmPasswordTextField.delegate = self
        view.backgroundColor = UIColor.Support.background
        scrollView.delegate = self
        clearBackgroundNavigationBar()
        hideKeyboardWhenTappedAround()
        navItemSetupButton()
        addSubviewElement()
        makeConstraints()
    }
//    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
//        super.traitCollectionDidChange(previousTraitCollection)
//
//        let userInterfaceStyle = traitCollection.userInterfaceStyle
//        switch userInterfaceStyle {
//                case .light:
//                    googleAuth.layer.borderColor = UIColor.colorSetborderColor?.cgColor
//                case .dark:
//                    googleAuth.layer.borderColor = UIColor.colorSetborderColor?.cgColor
//                case .unspecified:
//                    print("123")
//        @unknown default:
//            fatalError()
//        }
//
//        // Update your user interface based on the appearance
//    }}
}

extension RegisterController{
    @objc private func googleAuthPressed(){
        Vibration.light.vibrate()
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        
        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(with: config, presenting: self) { [unowned self] user, error in
            
            if let error = error {
                
//                let alertController = UIAlertController(title: "Registration Error", message: error.localizedDescription, preferredStyle: .alert)
//                let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
//                alertController.addAction(okayAction)
//                self.present(alertController, animated: true, completion: nil)
                
                let alertController = AlertController()
                alertController.customAlert(text: "Registration Error", destText: error.localizedDescription, isHiddenActionButton: true)
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
//                    let alertController = UIAlertController(title: "Registration Error", message: error.localizedDescription, preferredStyle: .alert)
//                    let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
//                    alertController.addAction(okayAction)
//                    self.present(alertController, animated: true, completion: nil)
                    
                    let alertController = AlertController()
                    alertController.customAlert(text: "Registration Error", destText: error.localizedDescription, isHiddenActionButton: true)
                    alertController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
                    alertController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
                    self.present(alertController, animated: true)
                    return
                }
                
                // Present the main view
                let navVc = ToDoViewController()
                Vibration.success.vibrate()
                UserDefaults.standard.set(true, forKey: "true")
                self.navigationController?.pushViewController(navVc, animated: true)
            }
        }
    }
    @objc private func popViewButtonPressed(){
        Vibration.light.vibrate()
        navigationController?.popViewController(animated: true)
    }
@objc private func registerButtonPressed(){
    Vibration.light.vibrate()
    // Validate the input
    guard let name = userTextField.text, name != "",
          let emailAddress = emailTextField.text, emailAddress != "",
          let password = passwordTextField.text, password != "",
          let confirmPassword = confirmPasswordTextField.text,confirmPassword != ""  else {
        Vibration.error.vibrate()
//            let alertController = UIAlertController(title: "Registration Error", message: "Please make sure you provide your name, email address and password to complete the registration.", preferredStyle: .alert)
//            let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
//            alertController.addAction(okayAction)
//            present(alertController, animated: true, completion: nil)
        
        let alertController = AlertController()
        alertController.customAlert(text: "Registration Error", destText: "Please make sure you provide your name, email address and password to complete the registration.", isHiddenActionButton: true)
        alertController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        alertController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.present(alertController, animated: true)
        return
    }
    guard let password = passwordTextField.text,let confirmPassword = confirmPasswordTextField.text,password == confirmPassword else {
        Vibration.error.vibrate()
//            let alertController = UIAlertController(title: "Passwords do not match", message: "Make sure the input is correct", preferredStyle: .alert)
//            let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
//            alertController.addAction(okayAction)
//            present(alertController, animated: true, completion: nil)
        
        let alertController = AlertController()
        alertController.customAlert(text: "Passwords do not match", destText: "Make sure the input is correct", isHiddenActionButton: true)
        alertController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        alertController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.present(alertController, animated: true)
        
        return
        
    }
    
    // Register the user account on Firebase
    Auth.auth().createUser(withEmail: emailAddress, password: password, completion: { [weak self] (user, error) in
        
        if let error = error {
            Vibration.error.vibrate()
//                let alertController = UIAlertController(title: "Registration Error", message: error.localizedDescription, preferredStyle: .alert)
//                let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
//                alertController.addAction(okayAction)
//                self.present(alertController, animated: true, completion: nil)
            
            let alertController = AlertController()
            alertController.customAlert(text: "Passwords do not match", destText: error.localizedDescription, isHiddenActionButton: true)
            alertController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            alertController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            self?.present(alertController, animated: true)
            return
        }
        
        self?.databaseRef.child((user?.user.uid)!).child("username").setValue(name)
        self?.databaseRef.child((user?.user.uid)!).child("useremail").setValue(emailAddress)
        
        // Save the name of the user
        if let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest() {
            changeRequest.displayName = name
            changeRequest.commitChanges(completion: { (error) in
                if let error = error {
                    print("Failed to change the display name: \(error.localizedDescription)")
                }
            })
        }
        
        // Dismiss keyboard
        self?.view.endEditing(true)
        
        // Send verification email
        Auth.auth().currentUser?.sendEmailVerification()
        
//            let alertController = UIAlertController(title: "Email Verification", message: "We've just sent a confirmation email to your email address. Please check your inbox and click the verification link in that email to complete the sign up.", preferredStyle: .alert)
//            let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: { (action) in
//                // Dismiss the current view controller
//                self.dismiss(animated: true, completion: nil)
//            })
//            alertController.addAction(okayAction)
//            self.present(alertController, animated: true, completion: nil)
        
        Vibration.success.vibrate()
        let alertController = AlertController()
        alertController.customAlert(text: "Email Verification", destText: "We've just sent a confirmation email to your email address. Please check your inbox and click the verification link in that email to complete the sign up.", isHiddenActionButton: true)
        alertController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        alertController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self?.present(alertController, animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1 ) {
            
            self?.navigationController?.popViewController(animated: true)
        }
        
    })
}
    private func navItemSetupButton() {
        navigationItem.setHidesBackButton(true, animated: true)
        navigationItem.leftBarButtonItem = .addButton(systemNameIcon: imageSet.backButton.rawValue,self, action: #selector(popViewButtonPressed))
    }
    private func addSubviewElement()  {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(lineView)
        contentView.addSubview(orRegisterWith)
        contentView.addSubview(googleAuth)
        contentView.addSubview(stackView)
        contentView.addSubview(stackViewGoogleApple)
        
        stackView.addArrangedSubview(registerLabel)
        stackView.addArrangedSubview(userTextField)
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(confirmPasswordTextField)
        stackView.addArrangedSubview(registerButton)
        
        stackViewGoogleApple.addArrangedSubview(googleAuth)
        stackViewGoogleApple.addArrangedSubview(appleAuth)
        
        
    }
    private func makeConstraints()  {
        NSLayoutConstraint.activate([
            
            userTextField.heightAnchor.constraint(equalToConstant: 56),
            emailTextField.heightAnchor.constraint(equalToConstant: 56),
            passwordTextField.heightAnchor.constraint(equalToConstant: 56),
            confirmPasswordTextField.heightAnchor.constraint(equalToConstant: 56),
            registerButton.heightAnchor.constraint(equalToConstant: 56),
            //
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            stackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20),
            //
            orRegisterWith.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            orRegisterWith.bottomAnchor.constraint(equalTo: stackView.bottomAnchor,constant: 20),
            orRegisterWith.widthAnchor.constraint(equalToConstant: 110),
            //
            lineView.bottomAnchor.constraint(equalTo: orRegisterWith.centerYAnchor),
            lineView.leftAnchor.constraint(equalTo: contentView.leftAnchor,constant: 20),
            lineView.rightAnchor.constraint(equalTo: contentView.rightAnchor,constant: -20),
            lineView.heightAnchor.constraint(equalToConstant: 1),
            //
            //
            //
            
            //
            
            stackViewGoogleApple.topAnchor.constraint(equalTo: orRegisterWith.bottomAnchor,constant: 10),
            stackViewGoogleApple.leftAnchor.constraint(equalTo: contentView.leftAnchor,constant: 20),
            stackViewGoogleApple.rightAnchor.constraint(equalTo: contentView.rightAnchor,constant: -20),
            stackViewGoogleApple.heightAnchor.constraint(equalToConstant: 56),
            
        ])
    }
}

extension RegisterController:UIScrollViewDelegate{
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if(velocity.y>0) {
            self.navigationController?.setNavigationBarHidden(true, animated: true)
            print("Hide")
            
        } else {
            self.navigationController?.setNavigationBarHidden(false, animated: true)
            print("Unhide")
        }
    }
}
extension RegisterController:UITextFieldDelegate{
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
