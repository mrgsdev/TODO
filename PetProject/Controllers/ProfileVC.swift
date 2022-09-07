//
//  ProfileController.swift
//  PetProject
//
//  Created by MRGS on 14.08.2022.
//

import UIKit 
import FirebaseAuth
import GoogleSignIn
import AudioToolbox
class ProfileVC: UIViewController {
    let arrayCount = [
        "Change password",
        "Change name",
        "Change email",
        "Change photo",
        "About the developer",
        "Delete an account"
  
    ]
    //MARK: Create UI with Code
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.frame = self.view.bounds
        scrollView.contentSize = contentSize
        scrollView.backgroundColor = UIColor.Support.background 
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.frame.size = contentSize
        contentView.backgroundColor = UIColor.Support.background
        return contentView
    }()
    private var contentSize: CGSize {
        CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    
    
    private let imageProfile: CustomImageView = {
        let image = CustomImageView(image: UIImage(named: imageSet.userLogo.rawValue))
        image.contentMode = .center
        image.layer.borderWidth = 3
        image.layer.cornerRadius = 75
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let nameUserLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: UIFont.urbanistSemiBold, size: 26)
        label.textColor = UIColor.Label.labelPrimary
        label.textAlignment = .center
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let emailUserLabel: UILabel = {
        let label = UILabel()
//        label.text = "example@gmail.com"
        if let customFont = UIFont(name: "Urbanist-ExtraLight", size: 15) {
            label.font = customFont
        }
        label.textColor = .gray
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var logoutButton: UIButton = {
        let logoutButton = UIButton()
        logoutButton.backgroundColor = UIColor.Button.background
        
        if let font = UIFont(name: "Urbanist-SemiBold", size: 17) {
            logoutButton.titleLabel?.font = font
        }
        logoutButton.layer.cornerRadius = 10
        logoutButton.setTitle("Logout", for: .normal)
        logoutButton.setTitleColor(UIColor.Button.label, for: .normal)
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.addTarget(self, action: #selector(logout), for: .touchUpInside)
        return logoutButton
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution  = .fill
        stackView.alignment = .center
        stackView.spacing = 0
        stackView.layer.cornerRadius = 20
        stackView.clipsToBounds = true
        stackView.backgroundColor = UIColor.Alert.background
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    private let stackViewNameEmail: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution  = .fill
        stackView.alignment = .center
        stackView.spacing = 0
        // autolayout constraint
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    let tableView: UITableView = {
        let table = UITableView()
        table.register(ProfileViewCell.self, forCellReuseIdentifier: "profileCell")
        table.separatorStyle = .none
        table.backgroundColor = UIColor.Support.background
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    //MARK: Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let user = Auth.auth().currentUser
        if let user = user { 
            let username = user.displayName
            let email = user.email
            
            if let photoURL = user.photoURL {
                
                imageProfile.downloaded(from: photoURL)
                
            }
            nameUserLabel.text = username
            emailUserLabel.text =  email
        }
       
           
        
        }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(scrollView)
        view.backgroundColor = UIColor.Support.background
        clearBackgroundNavigationBar()
        navItemSetupButton()
        tableView.delegate = self
        tableView.dataSource = self
        addSubviewElement()
        makeConstraints()
        
    }
    
    
}


extension ProfileVC{
    @objc private func popViewButtonPressed(){
        navigationController?.popViewController(animated: true)
        Vibration.light.vibrate()
    }
    @objc private func logout(){
        print(#function)
        Vibration.light.vibrate()
        navigationController?.viewControllers = [WelcomeVC()]
        //navigationController?.popToRootViewController(animated: true)
        signOut()
    }
    private func signOut()  {
        do {
            try Auth.auth().signOut()
            GIDSignIn.sharedInstance.signOut()
            UserDefaults.standard.removeObject(forKey: "true")
            // Sign out from Google
        } catch {
            let alertController = UIAlertController(title: "Logout Error", message: error.localizedDescription, preferredStyle: .alert)
            let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(okayAction)
            present(alertController, animated: true, completion: nil)
            return
        }
    }
    private func addSubviewElement()  {
        contentView.addSubview(tableView)
        scrollView.addSubview(contentView)
        
        stackViewNameEmail.addArrangedSubview(nameUserLabel)
        stackViewNameEmail.addArrangedSubview(emailUserLabel)
        stackView.addArrangedSubview(imageProfile)
        stackView.addArrangedSubview(stackViewNameEmail)
        contentView.addSubview(stackView)
        //        stackViewNameEmail.addArrangedSubview(registerButton)
        contentView.addSubview(logoutButton)
    }
    private func makeConstraints()  {
        NSLayoutConstraint.activate([
            imageProfile.heightAnchor.constraint(equalToConstant: 150),
            imageProfile.widthAnchor.constraint(equalToConstant: 150),
            imageProfile.topAnchor.constraint(equalTo: stackView.topAnchor,constant: 40),// problem
            stackView.topAnchor.constraint(equalTo: view.topAnchor),// problem
            stackView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            stackView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            
            tableView.topAnchor.constraint(equalTo: stackView.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: logoutButton.topAnchor, constant: 0),
            logoutButton.heightAnchor.constraint(equalToConstant: 56),
            logoutButton.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 20),
            logoutButton.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -20),
            logoutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -10)
            
        ])
    }
    private func navItemSetupButton(){
        navigationItem.setHidesBackButton(true, animated: true)
        navigationItem.leftBarButtonItem = .addButton(systemNameIcon: imageSet.backButton.rawValue,self, action: #selector(popViewButtonPressed))
    }
}


extension ProfileVC:UITableViewDataSource,UITableViewDelegate{
    func presentVC(controllerVC: UIViewController)  {
        let loadVC = controllerVC
        navigationController?.pushViewController(loadVC, animated: true)
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayCount.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "profileCell", for: indexPath as IndexPath) as! ProfileViewCell
        cell.labelText.text = "\(arrayCount[indexPath.row])"
        if(indexPath.row >= arrayCount.count-1){
            cell.containerView.backgroundColor = UIColor.clear
            cell.labelText.textColor = UIColor.red
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 92
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Vibration.light.vibrate()
        tableView.deselectRow(at: indexPath, animated: false)
        
        switch indexPath.row{
        case 0:
            presentVC(controllerVC: ChangePasswordVC())
        case 1:
            presentVC(controllerVC: ChangeNameVC())
        case 2:
            presentVC(controllerVC: ChangeEmailVC())
        case 3:
            presentVC(controllerVC: ChangePhotoVC())
        case 4:
            presentVC(controllerVC: AboutDevVC())
        case 5:
            presentVC(controllerVC: DeleteAccountVC())
        default:
            print("error")
        }
    }
    func deleteAccount()  {
        let alertController = UIAlertController(title: String(localized: "Do you really want to delete your account?"), message: String(localized:"Enter 'Delete account'."), preferredStyle: .alert)
        alertController.addTextField { (textField : UITextField!)  in
            textField.placeholder = "Enter 'Delete account'"
        }
        alertController.addAction(UIAlertAction(title: "OK", style: .destructive) { _ in
            let textField = alertController.textFields![0] as UITextField
            guard let txtfld = textField.text,txtfld == "Delete account" else {
                let alertController = UIAlertController(title: String(localized: "Input error"), message: String(localized:"Check that the input is correct"), preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alertController, animated: true, completion: nil)
                return
            }
            let user = Auth.auth().currentUser
            user?.delete { error in
                if let error = error {
                    let alertController = UIAlertController(title: "Delete Error", message: error.localizedDescription, preferredStyle: .alert)
                    let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(okayAction)
                    self.present(alertController, animated: true, completion: nil)
                } else {
                    self.navigationController?.viewControllers = [DeleteAlertController()]
                    self.signOut()
                }
            }
        })
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
}
