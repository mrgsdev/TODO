//
//  WelcomeController.swift
//  PetProject
//
//  Created by MRGS on 14.08.2022.
//

import UIKit

class WelcomeController: UIViewController {
    
    //MARK: Create UI with Code
    private let backgroundImage: UIImageView = {
        let backgroundImage = UIImageView(image: UIImage(named: imageSet.background.rawValue))
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        return backgroundImage
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution  = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var loginButton: CustomButton = {
        let button = CustomButton()
        button.settingButton(nameFont: UIFont.urbanistSemiBold,sizeFont: 17, borderWidth: 0,
                             cornerRadius: 10,translatesAutoresizingMaskIntoConstraints: false)
        button.setTitle("Login", for: .normal)
        button.backgroundColor = UIColor.Button.background
        button.setTitleColor(UIColor.Button.label, for: .normal)
        button.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var registerButton: CustomButton = {
        let button = CustomButton()
        button.settingButton(nameFont: UIFont.urbanistSemiBold, sizeFont: 17, borderWidth: 0,
                             cornerRadius: 10, translatesAutoresizingMaskIntoConstraints: false)
        button.setTitle("Register", for: .normal)
        button.backgroundColor = UIColor.Button.background
        button.setTitleColor(UIColor.Button.label, for: .normal)
        button.addTarget(self, action: #selector(registerButtonPressed), for: .touchUpInside)
        return button
    }()
    
    //MARK: Life Cycle
    override func viewDidLoad() { 
        super.viewDidLoad()
        view.addSubview(backgroundImage)
        view.addSubview(stackView)
        addSubviewElement()
        makeConstraints()
    }
    
}
extension WelcomeController{
    
    @objc private func loginButtonPressed(){
        Vibration.light.vibrate()
        let navVC = LoginController()
        navigationController?.pushViewController(navVC, animated: true)
    }
    
    @objc private func registerButtonPressed(){
        Vibration.light.vibrate()
        let navVC = RegisterController()
        navigationController?.pushViewController(navVC, animated: true)
    }
    
    private func addSubviewElement()  {
        stackView.addArrangedSubview(loginButton)
        stackView.addArrangedSubview(registerButton)
    }
    
    private func makeConstraints()  {
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.leftAnchor.constraint(equalTo: view.leftAnchor),
            backgroundImage.rightAnchor.constraint(equalTo: view.rightAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -20),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            stackView.heightAnchor.constraint(equalToConstant: 122)
        ])
    }
}
