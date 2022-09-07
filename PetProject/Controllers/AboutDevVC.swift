//
//  InfoController.swift
//  PetProject
//
//  Created by MRGS on 20.08.2022.
//

import UIKit
import SafariServices
class AboutDevVC: UIViewController {
     
    private let labelPrimary: UILabel = {
        let label = UILabel()
        label.text = "Here you can learn about the developer"
        label.textColor = UIColor.Label.labelSecondary
        label.font =  UIFont(name:  UIFont.urbanistExtraLight, size: 15)
        label.adjustsFontForContentSizeCategory = true
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var emailButton:CustomButton = {
        let button = CustomButton()
        button.settingButton(nameFont: UIFont.urbanistMedium,sizeFont: 20, borderWidth: 2,
                             cornerRadius: 15,translatesAutoresizingMaskIntoConstraints: false)
        button.backgroundColor = UIColor.TextField.background
        button.setTitleColor(UIColor.TextField.label, for: .normal)
        button.contentHorizontalAlignment = .center
        button.setTitle("Telegramm", for: .normal)
        button.addTarget(self, action: #selector(emailPress),
                         for: .touchUpInside)
        return button
    }()
    private lazy var githubButton:CustomButton = {
        let button = CustomButton()
        button.settingButton(nameFont: UIFont.urbanistMedium,sizeFont: 20, borderWidth: 2,
                             cornerRadius: 15,translatesAutoresizingMaskIntoConstraints: false)
        button.backgroundColor = UIColor.TextField.background
        button.setTitleColor(UIColor.TextField.label, for: .normal)
        button.contentHorizontalAlignment = .center
        button.setTitle("GitHub", for: .normal)
        button.addTarget(self, action: #selector(githubPress),
                         for: .touchUpInside)
        return button
    }()
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution  = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 15
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    private func navItemSetupButton(){
        navigationItem.setHidesBackButton(true, animated: true)
        navigationItem.leftBarButtonItem = .addButton(systemNameIcon: imageSet.backButton.rawValue,self,
                                                      action: #selector(popViewButtonPressed))
    }
    
    @objc private func popViewButtonPressed(){
        navigationController?.popViewController(animated: true)
        Vibration.light.vibrate()
    }
    @objc private func emailPress(){
        Vibration.light.vibrate()
        if let url = URL(string: LinkItem.telegramm.rawValue) {
            let safariController = SFSafariViewController(url: url)
            present(safariController, animated: true, completion: nil)
        }
    }
    @objc private func githubPress(){
        Vibration.light.vibrate()
        if let url = URL(string: LinkItem.github.rawValue) {
            let safariController = SFSafariViewController(url: url)
            present(safariController, animated: true, completion: nil)
        }
    }
     
    override func viewDidLoad() {
        super.viewDidLoad()
        navItemSetupButton()
        title = "INFO"
        view.backgroundColor = UIColor.Support.background
        makeConstraints()
    }
    
    func makeConstraints() {
        view.addSubview(labelPrimary)
        view.addSubview(stackView)
        
        stackView.addArrangedSubview(emailButton)
        stackView.addArrangedSubview(githubButton)
        
        NSLayoutConstraint.activate([
            emailButton.heightAnchor.constraint(equalToConstant: 40),
            labelPrimary.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            labelPrimary.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            labelPrimary.leftAnchor.constraint(equalTo: view.leftAnchor),
            labelPrimary.rightAnchor.constraint(equalTo: view.rightAnchor),
            stackView.topAnchor.constraint(equalTo: labelPrimary.bottomAnchor),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 20),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -20),
        ])
    } 
}
