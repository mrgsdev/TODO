//
//  NewTaskViewController.swift
//  PetProject
//
//  Created by MRGS on 14.08.2022.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import FirebaseCore
protocol NewTaskDelegate: AnyObject {
    func updateEdit(TodoModel: TodoModel)
}

class NewTaskViewController: UIViewController {
    private var databaseRef = Database.database().reference()
    
    weak var delegate:ToDoViewControllerDelegate?
    weak var delegate2: NewTaskDelegate?
    var todoModel:TodoModel?
    private let scrollView = UIScrollView()
    private let contentView = UIView()
     let textFieldTask: CustomTextField = {
        let textfield = CustomTextField()
        textfield.customPlaceholder(placeholder: "Enter new task")
        return textfield
    }()
    private let labelPrimary: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.sizeToFit()
        label.text = "Create new task"
        label.font = UIFont(name: UIFont.urbanistExtraLight, size: 20)
        label.textColor = UIColor.Label.labelSecondary
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let labelSecondary: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Create new task"
        label.sizeToFit()
        label.textColor = UIColor.Label.labelSecondary
        label.font = UIFont(name: UIFont.urbanistExtraLight, size: 20)
        label.textColor = UIColor.Label.labelSecondary
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let detailTextView: CustomTextView = {
        let view = CustomTextView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont(name: UIFont.urbanistMedium, size: 18)
        view.textColor = UIColor.TextField.label
        return view
    }()
    
    private let stackViewPrimary: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution  = .fill
        stackView.alignment = .fill
        stackView.spacing = 2
        return stackView
    }()
    private let stackViewFirst: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution  = .fill
        stackView.alignment = .fill
        stackView.spacing = 2
        return stackView
    }()
    private let stackViewSecond: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution  = .fill
        stackView.alignment = .fill
        stackView.spacing = 2
        return stackView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.Support.background
        clearBackgroundNavigationBar()
        navItemSetupButton()
        makeConstraints()
    }
    
    
}
extension NewTaskViewController{
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        //        if velocity.y > 0,
        //           arrayTodo.count != 0
        if velocity.y < 0{
            self.navigationController?.setNavigationBarHidden(false, animated: true)
            print("Hide")
            
        } else {
            self.navigationController?.setNavigationBarHidden(false, animated: true)
            print("Unhide")
        }
    }
    private func navItemSetupButton() {
        navigationItem.setHidesBackButton(true, animated: true)
        navigationItem.leftBarButtonItem = .addButton(systemNameIcon: imageSet.backButton.rawValue,self, action: #selector(popViewButtonPressed))
        navigationItem.rightBarButtonItem = .addButton(systemNameIcon: imageSet.checkmark.rawValue, self, action: #selector(saveButtonPressed))
    }
    @objc private func saveButtonPressed(sender: UIButton){
      
        Vibration.light.vibrate()
        guard let textField = textFieldTask.text,let textView = detailTextView.text,!textField.isEmpty else {
            Vibration.error.vibrate()
            let alertController = AlertController()
            alertController.customAlert(text: "Ooops!!😔", destText: "Please enter your task", isHiddenActionButton: true)
            alertController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            alertController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            self.present(alertController, animated: true)
            return
        }
        if title == "Change task"{
            if let todoModel = todoModel {
                todoModel.taskPrimary = textField
                todoModel.taskSecondary = textView
                delegate2?.updateEdit(TodoModel: todoModel)
            }
            print(textField)
            navigationController?.popViewController(animated: true)
        }else{
            TodoModel.arrayTodo.removeAll()
            let user = Auth.auth().currentUser
            self.databaseRef.child(user!.uid).child("tasklist").childByAutoId().setValue(["textPrimary":textField,
                                                                                          "textSecondary":textView])
            
//            delegate?.update(taskPrimary: textField,taskSecondary: textView)
            navigationController?.popViewController(animated: true)
        }
    }
    @objc private func popViewButtonPressed(){
        Vibration.light.vibrate()
        navigationController?.popViewController(animated: true)
    }
    private func makeConstraints(){
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        stackViewPrimary.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        labelPrimary.translatesAutoresizingMaskIntoConstraints = false
        textFieldTask.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackViewPrimary)
        
        stackViewFirst.addArrangedSubview(labelPrimary)
        stackViewFirst.addArrangedSubview(textFieldTask)
        
        stackViewSecond.addArrangedSubview(labelSecondary)
        stackViewSecond.addArrangedSubview(detailTextView)
        
        stackViewPrimary.addArrangedSubview(stackViewFirst)
        stackViewPrimary.addArrangedSubview(stackViewSecond)
        
        NSLayoutConstraint.activate([
            textFieldTask.heightAnchor.constraint(equalToConstant: 56),
            detailTextView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 2/3),
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            stackViewPrimary.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackViewPrimary.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            stackViewPrimary.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20),
            stackViewPrimary.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
        
        
    }
}
