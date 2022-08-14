//
//  NewTaskViewController.swift
//  PetProject
//
//  Created by MRGS on 14.08.2022.
//

import UIKit

class NewTaskViewController: UIViewController {
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let textFieldTask: CustomTextField = {
        let textfield = CustomTextField()
        textfield.customPlaceholder(placeholder: "Enter username")
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
        view.text = """
               Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?"
               """
      
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
        //        view.backgroundColor = UIColor.Support.background
        title = "Create new task"
        view.backgroundColor = UIColor.Support.background
        clearBackgroundNavigationBar()
        navItemSetupButton()
        makeConstraints()
    }
    
    
}
extension NewTaskViewController{
    private func navItemSetupButton() {
        navigationItem.setHidesBackButton(true, animated: true)
        navigationItem.leftBarButtonItem = .addButton(systemNameIcon: imageSet.backButton.rawValue,self, action: #selector(popViewButtonPressed))
        navigationItem.rightBarButtonItem = .addButton(systemNameIcon: imageSet.checkmark.rawValue, self, action: #selector(popViewButtonPressed))
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
