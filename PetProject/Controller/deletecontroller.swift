//
//  deletecontroller.swift
//  PetProject
//
//  Created by MRGS on 14.08.2022.
//


import UIKit

class deletecontroller: UIViewController {
    weak var delegate:ToDoViewControllerDelegate?
    let txtfld = MainTaskCell()
    private let taskLabel: UILabel = {
        let label = UILabel()
        label.text = "Create new todo"
        if let customFont = UIFont(name: "Urbanist-SemiBold", size: 30) {
            let fontMetrics = UIFontMetrics(forTextStyle: .title1)
            label.font = fontMetrics.scaledFont(for: customFont)
        }
        label.backgroundColor = .blue
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(MainTaskCell.self, forCellReuseIdentifier: "MainTaskCell")
        table.register(DetailTaskCell.self, forCellReuseIdentifier: "DetailTaskCell")
        table.separatorStyle = .none
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        view.backgroundColor = .white
        clearBackgroundNavigationBar()
        navItemSetupButton()
        view.addSubview(taskLabel)
        view.addSubview(tableView)
        makeConstraints()
    }
    
    @objc private func saveButtonPressed(sender: UIButton){
     
        Vibration.light.vibrate()
        guard let textField = MainTaskCell.mainTextField.text,!textField.isEmpty else {
            // create the alert
            Vibration.error.vibrate()
            let alertController = AlertController()
            alertController.customAlert(text: "Ooops!!😔", destText: "Please enter your task", isHiddenActionButton: true)
            alertController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            alertController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            self.present(alertController, animated: true)
            return
        }
        delegate?.update(text: MainTaskCell.mainTextField.text!)//проблема!Как то нужно получить доступ без MainTaskCell
        MainTaskCell.mainTextField.text = nil
        navigationController?.popViewController(animated: true)
    }
    @objc private func popViewButtonPressed(){
        Vibration.light.vibrate()
        navigationController?.popViewController(animated: true)
    }
}
extension deletecontroller{
    
    private func navItemSetupButton()  {
        let navItem = navigationItem
        navItem.setHidesBackButton(true, animated: true)
        navItem.rightBarButtonItem = .addButton(systemNameIcon: imageSet.checkmark.rawValue, self, action: #selector(saveButtonPressed))
        navItem.leftBarButtonItem = .addButton(systemNameIcon: imageSet.backButton.rawValue, self, action: #selector(popViewButtonPressed))
    }
    
    private func makeConstraints()  {
        NSLayoutConstraint.activate([
            taskLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            taskLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            taskLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            
            tableView.topAnchor.constraint(equalTo: taskLabel.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
extension deletecontroller:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row{
        case 0:
            return 109
        case 1:
            return 400
        default:
            return 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MainTaskCell", for: indexPath) as! MainTaskCell
            //            cell.mainTextField.text = ""
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailTaskCell", for: indexPath) as! DetailTaskCell
            cell.detailTextView.text = "Рассказ — меньшая по объёму форма художественной прозы, нежели повесть или роман[1]. Не следует путать новеллу — короткий рассказ[2], отличающийся стилем изложения[3][4][5], с её английским омонимом novella, являющимся эквивалентом современного понятия повесть[6][7].Рассказ восходит к фольклорным жанрам устного пересказа в виде сказаний или поучительного иносказания и притчи[8][9]. По сравнению с более развёрнутыми повествовательными формами в рассказах не много действующих лиц и одна сюжетная линия (реже несколько) при характерном наличии какой-то одной проблемы."
            return cell
        default:
            fatalError("Failed to instantiate the table view cell fordetail view controller")
        }
    }
}

