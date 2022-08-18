//
//  ToDoViewController.swift
//  PetProject
//
//  Created by MRGS on 14.08.2022.
//

import UIKit
import FirebaseCore
import FirebaseAuth
protocol ToDoViewControllerDelegate:AnyObject {
    func update(taskPrimary:String,taskSecondary:String?)
}
class ToDoViewController: UIViewController{
   
    
    private var arrayTodo = [TodoModel]()
    private let heightCell:CGFloat = 80
    var handle: AuthStateDidChangeListenerHandle?
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(ToDoCell.self, forCellReuseIdentifier: "todoCell")
        table.separatorStyle = .none
        table.showsVerticalScrollIndicator = false
        
        table.backgroundColor = UIColor.Support.background
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    func update(taskPrimary:String,taskSecondary:String?)  {
        arrayTodo.append(TodoModel(taskPrimary: taskPrimary, taskSecondary: taskSecondary))
        print("TODOVC update func: taskPrimary = \(taskPrimary)")
        print("TODOVC update func: taskSecondary = \(taskSecondary)")
        tableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        clearBackgroundNavigationBar()
        navItemSetupButton()
        makeConstraints()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
     
        emptyUser()
        handle = Auth.auth().addStateDidChangeListener { auth, user in
            // [START_EXCLUDE]
            self.setTitleDisplay(user)
            self.tableView.reloadData()
            // [END_EXCLUDE]
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Auth.auth().removeStateDidChangeListener(handle!)
    }
    func setTitleDisplay(_ user: User?) {
        
        if let name = user?.displayName {
            navigationItem.title = "Welcome \(name)"
        } else {
            navigationItem.title = ""
        }
    }
    //    override func viewWillAppear(_ animated: Bool) {
    //        super.viewWillAppear(animated)
    //        let user = Auth.auth().currentUser
    //        let uid = user?.uid
    //          let email = user?.email
    //          var multiFactorString = "MultiFactor: "
    //          for info in user!.multiFactor.enrolledFactors {
    //            multiFactorString += info.displayName ?? "[DispayName]"
    //            multiFactorString += " "
    //          }
    //        print(email)
    //        }
}


extension ToDoViewController:ToDoViewControllerDelegate{
    @objc private func addNewNoteButtonPressed(){
        Vibration.light.vibrate()
        let loadVC = NewTaskViewController()
        loadVC.delegate = self
        navigationController?.pushViewController(loadVC, animated: true)
    }
    @objc private func openProfile(){
        Vibration.light.vibrate()
        let loadVC = ProfileController()
        navigationController?.pushViewController(loadVC, animated: true)
    }
    private func navItemSetupButton()  {
        let navItem = navigationItem
        navItem.setHidesBackButton(true, animated: true)
        navItem.rightBarButtonItem = .addButton(systemNameIcon: imageSet.plus.rawValue, self, action: #selector(addNewNoteButtonPressed))
        navItem.leftBarButtonItem = .addButton(systemNameIcon: imageSet.personFill.rawValue, self, action: #selector(openProfile))
    }
    private func makeConstraints()  {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    
}

extension ToDoViewController:UITableViewDataSource,UITableViewDelegate,NewTaskDelegate{
    func updateEdit(TodoModel: TodoModel) {
        if let index = arrayTodo.firstIndex(of: TodoModel) {
            print(index)
            let indexPath = IndexPath(row: index, section: 0)
            arrayTodo[indexPath.row] = TodoModel
            tableView.reloadData()
        }
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayTodo.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightCell
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath) as! ToDoCell
        cell.labelText.text = arrayTodo[indexPath.row].taskPrimary
        return cell
    }
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        //        if velocity.y > 0,
        //           arrayTodo.count != 0
        if velocity.y > 0{
            self.navigationController?.setNavigationBarHidden(true, animated: true)
            print("Hide")
            
        } else {
            self.navigationController?.setNavigationBarHidden(false, animated: true)
            print("Unhide")
        }
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print(#function)
        if arrayTodo.count >= 12 {
            self.navigationController?.setNavigationBarHidden(false, animated: true)
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        Vibration.soft.vibrate()
        let newTaskVC = NewTaskViewController()
        newTaskVC.todoModel = arrayTodo[indexPath.row]
        newTaskVC.delegate2 = self
        newTaskVC.title = "Change task"
        newTaskVC.textFieldTask.text = arrayTodo[indexPath.row].taskPrimary
        newTaskVC.detailTextView.text = arrayTodo[indexPath.row].taskSecondary
        print(arrayTodo[indexPath.row].taskPrimary)
        navigationController?.pushViewController(newTaskVC, animated: true)
        
    }
}
