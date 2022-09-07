//
//  AlertController.swift
//  PetProject
//
//  Created by MRGS on 14.08.2022.
//

import UIKit
import FirebaseCore
import FirebaseAuth
class AlertController: UIViewController {
    var textButton = ""
    private let labelPrimary: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: UIFont.urbanistBold, size: 30)
        label.textColor = UIColor.Alert.labelPrimary
        label.numberOfLines = 3
        label.minimumScaleFactor = 0.4
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let labelSecondary: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.Alert.labelSecondary
        label.font = UIFont(name: UIFont.urbanistBold, size: 16)
        label.numberOfLines = 0
        label.minimumScaleFactor = 0.3
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var contentView: CustomView = {
        let contentView = CustomView()
        contentView.backgroundColor = UIColor.Alert.background
        contentView.layer.cornerRadius = 24
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.layer.borderWidth = 2
        return contentView
    }()
    
    private lazy var closeButton: CustomButton = {
        let button = CustomButton()
        button.tintColor = UIColor.Label.labelPrimary
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 25, weight: .bold, scale: .large)
        let largeBoldDoc = UIImage(systemName: "xmark", withConfiguration: largeConfig)
        button.setImage(largeBoldDoc, for: .normal)
        button.addTarget(self, action: #selector(closePressed), for: .touchUpInside)
        return button
    }()
    lazy var actionButton: CustomButton = {
        let actionButton = CustomButton()
        actionButton.settingButton(nameFont: UIFont.urbanistSemiBold, sizeFont: 17, borderWidth: 0,
                                   cornerRadius: 10, translatesAutoresizingMaskIntoConstraints: false)
        actionButton.setTitleColor(UIColor.Button.label, for: .normal)
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        actionButton.addTarget(self, action: #selector(actionButtonPressed), for: .touchUpInside)
        return actionButton
    }()
   
    @objc private func closePressed(){
        Vibration.soft.vibrate()
        dismiss(animated: true)
    }
  
    
    override func viewDidAppear(_ animated: Bool) {
        actionButton.setTitle(textButton, for: .normal)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviewElement()
        makeConstraints()
     // animate()
    }
    @objc private func actionButtonPressed(){
     // animate()
        switch textButton{
        case "Send Email":
            Vibration.soft.vibrate()
            Auth.auth().currentUser?.sendEmailVerification(completion: nil)
            dismiss(animated: true)
        default:
            customAlert(text: "Unknown Error", destText: "", isHiddenActionButton: true)
        }
    }
    func customAlert(text:String,destText:String,isHiddenActionButton:Bool)  {
        labelPrimary.text = text
        labelSecondary.text = destText
        actionButton.isHidden = isHiddenActionButton
        
    }
    private func addSubviewElement()  {
        view.addSubview(contentView)
        view.addSubview(actionButton)
        contentView.addSubview(stackView)
        contentView.addSubview(closeButton)
        stackView.addArrangedSubview(labelPrimary)
        stackView.addArrangedSubview(labelSecondary)
//        animate()
    }
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        //        stackView.backgroundColor = .gray
        stackView.axis = .vertical
        stackView.distribution  = .fill
        stackView.alignment = .fill
        stackView.spacing = 3
        // autolayout constraint
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    func makeConstraints() {
        NSLayoutConstraint.activate([
            actionButton.heightAnchor.constraint(equalToConstant: 45),
            contentView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            contentView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            contentView.widthAnchor.constraint(equalToConstant: 300),
            contentView.heightAnchor.constraint(equalToConstant: 200),
             
            
            stackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            stackView.leftAnchor.constraint(equalTo: contentView.leftAnchor,constant: 10),
            stackView.rightAnchor.constraint(equalTo: contentView.rightAnchor,constant: -10),
            
            closeButton.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 5),
            closeButton.rightAnchor.constraint(equalTo: contentView.rightAnchor,constant: -10),
            closeButton.widthAnchor.constraint(equalToConstant: 32),
            closeButton.heightAnchor.constraint(equalToConstant: 32),
            
            actionButton.rightAnchor.constraint(equalTo: contentView.rightAnchor,constant: -50),
            actionButton.leftAnchor.constraint(equalTo: contentView.leftAnchor,constant: 50),
            actionButton.topAnchor.constraint(equalTo: contentView.bottomAnchor,constant: 10),
        ])
    }
    
    //    private func animate(){
    //        UIView.animate(withDuration: 0.2,
    //                       animations: {
    //            self.stackView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
    //            self.closeButton.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
    //            self.actionButton.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
    //        },
    //                       completion: { _ in
    //            UIView.animate(withDuration: 0.2) {
    //                //                    self.inputErrorLabel.transform = CGAffineTransform.identity
    //                //
    //                //                        self.messageLabel.transform = CGAffineTransform.identity
    //                //
    //                self.stackView.transform = CGAffineTransform.identity
    //                self.closeButton.transform = CGAffineTransform.identity
    //                self.actionButton.transform = CGAffineTransform.identity
    //            }
    //        })
    //    }
    
}
