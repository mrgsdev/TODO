//
//  ChangeNameViewController.swift
//  PetProject
//
//  Created by MRGS on 14.08.2022.
//


import UIKit
import FirebaseAuth
import FirebaseCore
class ChangeNameVC: UIViewController {
    
    
    
    //MARK: Create UI with Code
    private let labelPrimary: UILabel = {
        let label = UILabel()
        label.text = "Create new name"
            label.font = UIFont(name: UIFont.urbanistSemiBold, size: 30)
        label.adjustsFontForContentSizeCategory = true
        label.textColor = UIColor.Label.labelPrimary
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let labelSecondary: UILabel = {
        let label = UILabel()
        label.text = "Your new name must be unique from those previously used."
        label.textColor = UIColor.Label.labelSecondary
            label.font = UIFont(name: UIFont.urbanistExtraLight, size: 16)
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let nameTextField: CustomTextField = {
        let email = CustomTextField()
        email.customPlaceholder(placeholder: "Enter your name")
        return email
    }()
    
     
    private lazy var saveNameButton: CustomButton = {
        let button = CustomButton()
        button.settingButton(nameFont: UIFont.urbanistSemiBold, sizeFont: 17, borderWidth: 0, cornerRadius: 10, translatesAutoresizingMaskIntoConstraints: false)
        button.setTitle("Save New Name", for: .normal)
        button.setTitleColor(UIColor.Button.label, for: .normal)
        button.addTarget(self, action: #selector(changeNameButtonPressed), for: .touchUpInside)
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
        nameTextField.delegate = self
        hideKeyboardWhenTappedAround()
        clearBackgroundNavigationBar()
        navItemSetupButton()
        addSubviewElement()
        makeConstraints()
    }
   
    
}

extension ChangeNameVC{
    @objc private func popViewButtonPressed(){
        Vibration.light.vibrate()
        navigationController?.popViewController(animated: true)
    }
    @objc private func changeNameButtonPressed(){
        Vibration.light.vibrate()
           // Validate the input
           guard let name = nameTextField.text, name != "" else {
               Vibration.error.vibrate()
               let alertController = AlertController()
               alertController.customAlert(text: "Error", destText: "Both fields must not be blank.", isHiddenActionButton: true)
               alertController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
               alertController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
               self.present(alertController, animated: true)
               
               return
           }
           let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
           changeRequest?.displayName = nameTextField.text
           changeRequest?.commitChanges { error in
               guard let error = error else {
                   let alertController = AlertController()
                   Vibration.success.vibrate()
                   alertController.customAlert(text: "Name Change!🥳", destText: "Your new name:\(self.nameTextField.text!).", isHiddenActionButton: true)
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
    private func navItemSetupButton()  {
        navigationItem.setHidesBackButton(true, animated: true)
        navigationItem.leftBarButtonItem = .addButton(systemNameIcon: imageSet.backButton.rawValue,
                                                      self, action: #selector(popViewButtonPressed))
    }
    private func addSubviewElement()  {
        view.addSubview(stackView)
        stackView.addArrangedSubview(labelPrimary)
        stackView.addArrangedSubview(labelSecondary)
        stackView.addArrangedSubview(nameTextField)
        stackView.addArrangedSubview(saveNameButton)
    }
    private func makeConstraints()  {
        NSLayoutConstraint.activate([
            nameTextField.heightAnchor.constraint(equalToConstant: 56),
            saveNameButton.heightAnchor.constraint(equalToConstant: 56),
            
            stackView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
        ])
    }
}
extension ChangeNameVC:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
