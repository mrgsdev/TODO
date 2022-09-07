//
//  DeleteAlertController.swift
//  PetProject
//
//  Created by MRGS on 14.08.2022.
//

import UIKit

class DeleteAlertController: UIViewController {
    let imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: imageSet.sadface.rawValue))
        imageView.contentMode = .center
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        //shadow
//        imageView.layer.shadowColor = UIColor.lightGray.cgColor
//        imageView.layer.cornerRadius = imageView.frame.size.width / 2
//        imageView.layer.shadowOpacity = 0.5
//        imageView.layer.shadowOffset = CGSize(width: 1, height: -150)
//        imageView.layer.shadowRadius = 7
//        imageView.layer.shadowPath = UIBezierPath(roundedRect: imageView.frame, cornerRadius: imageView.bounds.size.height / 2).cgPath
        
        return imageView
    }()
    private let labelPrimary: UILabel = {
        let label = UILabel()
        label.alpha = 0
        label.text = "Your account has been deleted!"
        label.textColor = UIColor.Label.labelPrimary
        label.font = UIFont(name: UIFont.urbanistSemiBold, size: 30)
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let labelSecondary: UILabel = {
        let label = UILabel()
        label.alpha = 0
        label.text = "We will be glad to see you again"
        label.textColor = UIColor.Label.labelSecondary
        label.font = UIFont(name: UIFont.urbanistExtraLight, size: 16)
        label.textAlignment = .center
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let stackView: UIStackView = {
        let stackView = UIStackView()
//        stackView.backgroundColor = .gray
        stackView.axis = .vertical
        stackView.distribution  = .fill
        stackView.alignment = .fill
        stackView.spacing = 14
        // autolayout constraint
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    private lazy var goToWelcomeVC: CustomButton = {
        let button = CustomButton()
        button.settingButton(nameFont: UIFont.urbanistSemiBold, sizeFont: 17, borderWidth: 0, cornerRadius: 10, translatesAutoresizingMaskIntoConstraints: false)
        button.setTitle("Register now", for: .normal)
        button.setTitleColor(UIColor.Button.label, for: .normal)
        button.addTarget(self, action: #selector(goToWVC), for: .touchUpInside)
        return button
    }()
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 1.5) {
            self.labelPrimary.alpha = 1.0
            self.labelSecondary.alpha = 1.0
        }
        UIView.animate(withDuration: 1.5) {
            self.imageView.transform = CGAffineTransform(rotationAngle: .pi)
        }

        UIView.animate(withDuration: 2,delay: 0.45,options: UIView.AnimationOptions.curveEaseIn) {
            self.imageView.transform = CGAffineTransform(rotationAngle: 2 * .pi)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(imageView)
        view.backgroundColor = UIColor.Support.background
       
        
        addSubviewElement()
        makeConstraints()
        Vibration.error.vibrate()
    }

}

extension DeleteAlertController {
    @objc private func goToWVC(){
        self.navigationController?.viewControllers = [WelcomeVC()]
    }
    private func addSubviewElement()  {
        view.addSubview(stackView)
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(labelPrimary)
        stackView.addArrangedSubview(labelSecondary)
        
        stackView.addArrangedSubview(goToWelcomeVC)
    }
    private func makeConstraints()  {
        NSLayoutConstraint.activate([
            goToWelcomeVC.heightAnchor.constraint(equalToConstant: 56),
            imageView.heightAnchor.constraint(equalToConstant: 150),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
        ])
    }
}
