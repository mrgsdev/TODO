//
//  ChangePhotoViewController.swift
//  PetProject
//
//  Created by MRGS on 14.08.2022.
//


import UIKit
import FirebaseAuth
import FirebaseStorage
class ChangePhotoVC: UIViewController {
    
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
        hideKeyboardWhenTappedAround()
        
        // imageView @IBACtion
        
        //        let tapGestureRecognizer = UITapGestureRecognizer(target: self,
        //                                                          action: #selector(didTapChangeProfilePic))
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapChangeProfilePic))
        imageProfile.isUserInteractionEnabled = true
        imageProfile.addGestureRecognizer(tapGestureRecognizer)
    }
    @objc private func didTapChangeProfilePic() {
        print(#function)
        presentPhotoActionSheet()
    }
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        Vibration.light.vibrate()
        guard let tappedImage = tapGestureRecognizer.view as? UIImageView else {
            return
        }
        
        tappedImage.image = UIImage(named: imageSet.background.rawValue)
        tappedImage.contentMode = .scaleAspectFit
    }
    
    
}


extension ChangePhotoVC{
    @objc private func popViewButtonPressed(){
        Vibration.light.vibrate()
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func changePhotoButtonPressed(){
        print(#function)
        // upload photo
        guard let image = self.imageProfile.image,
              let data = image.pngData() else {
            return
        }
        let user = Auth.auth().currentUser
        let fileName = Users(username: (user?.displayName)!, email: (user?.email)!)
        StorageManager.shared.uploadProfilePicture(with: data, fileName: fileName.profilePictureFileName) { result in
            switch result {
            case .success(let downloadURL):
                UserDefaults.standard.set(downloadURL, forKey: "profile_picture_url")
                print(downloadURL)
            case .failure(let error):
                print("Storage maanger error: \(error)")
            }
        }
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
extension ChangePhotoVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func presentPhotoActionSheet() {
        let actionSheet = UIAlertController(title: "Profile Picture",
                                            message: "How would you like to select a picture?",
                                            preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Cancel",
                                            style: .cancel))
        actionSheet.addAction(UIAlertAction(title: "Take Photo",
                                            style: .default,
                                            handler: { [weak self] _ in
            self?.presentCamera()
            
        }))
        actionSheet.addAction(UIAlertAction(title: "Chose Photo",
                                            style: .default,
                                            handler: { [weak self] _ in
            self?.presentPhotoPicker()
            
        }))
        
        present(actionSheet, animated: true)
    }
    
    func presentCamera() {
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    func presentPhotoPicker() {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            return
        }
        
        self.imageProfile.image = selectedImage
        
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}

