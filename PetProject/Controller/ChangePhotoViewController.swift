//
//  ChangePhotoViewController.swift
//  PetProject
//
//  Created by MRGS on 14.08.2022.
//


import UIKit

class ChangePhotoViewController: UIViewController {
    
    //MARK: Create UI with Code
    var imagePicker = UIImagePickerController()
    private let labelPrimary: UILabel = {
        let label = UILabel()
        label.text = "Create new photo"
        label.font = UIFont(name: UIFont.urbanistSemiBold, size: 30)
        label.textColor = UIColor.Label.labelPrimary
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let imageProfile: CustomImageView = {
        let image = CustomImageView(image:  UIImage(named: imageSet.userLogo.rawValue))
        image.contentMode = .center
        image.layer.borderWidth = 1
        image.layer.borderColor = UIColor.Support.border?.cgColor
        image.backgroundColor  = UIColor.TextField.background
        image.layer.cornerRadius = 25
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    private lazy var saveProfileImageButton: CustomButton = {
        let button = CustomButton()
        button.settingButton(nameFont: UIFont.urbanistSemiBold, sizeFont: 17, borderWidth: 0, cornerRadius: 10, translatesAutoresizingMaskIntoConstraints: false)
        button.setTitle("Save Profile Image", for: .normal)
        button.setTitleColor(UIColor.Button.label, for: .normal)
        button.addTarget(self, action: #selector(changePhotoButtonPressed), for: .touchUpInside)
        return button
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
    
    
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.Support.background
        navItemSetupButton()
        addSubviewElement()
        makeConstraints()
        
        // imageView @IBACtion
        
//        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
//          imageProfile.isUserInteractionEnabled = true
//          imageProfile.addGestureRecognizer(tapGestureRecognizer)
    }
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        Vibration.light.vibrate()
        guard let tappedImage = tapGestureRecognizer.view as? UIImageView else {
            return
        }
        
        tappedImage.image = UIImage(named: "backImage")
        tappedImage.contentMode = .scaleAspectFit
    }
    
}


extension ChangePhotoViewController{
    @objc private func popViewButtonPressed(){
        Vibration.light.vibrate()
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func changePhotoButtonPressed(){
        print(#function)
    }
    func navItemSetupButton() {
        navigationItem.setHidesBackButton(true, animated: true)
        navigationItem.leftBarButtonItem = .addButton(systemNameIcon: imageSet.backButton.rawValue,self, action: #selector(popViewButtonPressed))
    }
    private func addSubviewElement()  {
        view.addSubview(stackView)
        stackView.addArrangedSubview(labelPrimary)
        stackView.addArrangedSubview(imageProfile)
        stackView.addArrangedSubview(saveProfileImageButton)
        
    }
    private func makeConstraints()  {
        NSLayoutConstraint.activate([
            imageProfile.heightAnchor.constraint(equalToConstant: 150),
            saveProfileImageButton.heightAnchor.constraint(equalToConstant: 56),
            stackView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
        ])
    }
}
