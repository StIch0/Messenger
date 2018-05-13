//
//  ViewController.swift
//  Messenger
//
//  Created by Pavel Burdukovskii on 10/05/2018.
//  Copyright © 2018 Pavel Burdukovskii. All rights reserved.
//

import UIKit
import CoreData
class ViewController: UIViewController {
    var activityIndicator : UIActivityIndicatorView!
    var backView : UIView!
    var tableView : UITableView!
    var titleAlert : String = ""
    var dialogs : [Message] = Array()
    let currentDateTime = Date()
    let formater = DateFormatter()
//    var myself : User?
    let manageContext = DatabaseManager.shared.persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()
        formater.timeStyle = .medium
        formater.dateStyle = .long
        formater.dateFormat = "HH:mm"
        setUpNavBar()
        setUpTableView()
        loadData()
        view.backgroundColor = .white
        title = "Чаты"
//        myself = User(context: manageContext)
    }
    func loadData (){
        
        if let users = fetchUser(){
        for obj in users {
            print(obj.id)
            let request : NSFetchRequest<Message> = Message.fetchRequest()
            request.sortDescriptors = [NSSortDescriptor(key: "dateTime", ascending: false)]
            let predicate = NSPredicate(format: "user.id == %@", obj.id)
            request.predicate = predicate
            request.fetchLimit = 1
            
            do {
                let mes = try manageContext.fetch(request)
                dialogs = mes
            }
            catch let error {
                print("Error = ", error.localizedDescription)
            }
            }
            
        }
//        request.predicate = NSPredicate(format: "id = %@",0)
        
    }
    
    func fetchUser () ->[User]?{
        let request : NSFetchRequest<User> = User.fetchRequest()
        do {
            let user = try manageContext.fetch(request)
            return user
         }
        catch let error {
            print("Error = ", error.localizedDescription)
        }
        return nil
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        do {
            try manageContext.save()
        } catch let error {
            print("Error = ", error.localizedDescription)
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        setUpActivityIndicatorView()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUpTableView (){
        tableView = UITableView()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(DialogsViewCell.self, forCellReuseIdentifier: "dialogCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.alwaysBounceVertical = true
        tableView.showsVerticalScrollIndicator = true
        tableView.isPagingEnabled = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor)           .isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)     .isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor) .isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor)   .isActive = true
     }
    
    func setUpNavBar (){
        let navBar  = navigationController?.navigationBar
        navBar?.barStyle = .default
        navBar?.layer.shadowColor = UIColor(rgb: 0x000000, alfa: 0.38).cgColor
        navBar?.layer.shadowOffset = CGSize(width: 0.2, height: 0.2)
        navBar?.layer.shadowRadius = 7
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addDialogs))
        add.setBackgroundImage(#imageLiteral(resourceName: "iconAdd"), for: .normal, barMetrics: .default)
        navBar?.backItem?.title = "Назад"
        navigationItem.rightBarButtonItem = add
        
    }
    @objc func addDialogs(){
        if dialogs.count == 0 {
            titleAlert = "Диалогов не найдено"
        }
        else {
            titleAlert = "Создать новый диалог"
        }
         let alert : UIAlertController = UIAlertController(title: titleAlert, message: "", preferredStyle: .alert)
        alert.addTextField(configurationHandler: {
            mes in
            mes.placeholder = "Введите сообщение"
        })
         let actionAlert = UIAlertAction(title: "Добавить", style: .default){
           action in
             action.isEnabled = true
            let message = alert.textFields![0]
            if message.text! != ""  {
                //create user core date
                let userEntity = NSEntityDescription.entity(forEntityName: "User", in: self.manageContext)
                let userObject = NSManagedObject(entity: userEntity!, insertInto: self.manageContext) as! User
                
                //create message core date
                let messageEntity = NSEntityDescription.entity(forEntityName: "Message", in: self.manageContext)
                let messageObject = NSManagedObject(entity: messageEntity!, insertInto: self.manageContext) as! Message

                let id = 0

                //set value to userObject for save
                userObject.setValue(id, forKey: "id")
                let dateTime = self.formater.string(from: self.currentDateTime)
//                //set value to messageObject for save
                messageObject.setValue(message.text!, forKey: "textMessage")
                messageObject.setValue(dateTime, forKey: "dateTime")
                messageObject.setValue(userObject, forKey: "user")
                
                self.dialogs.append(messageObject)
                
                self.dialogs.sort(by: { $0.dateTime! > $1.dateTime! })
                do {
                    try self.manageContext.save()
                }
                catch let error {
                    print("Error = " ,error.localizedDescription)
                }
                
                self.tableView.reloadData()
            }
            else {
                action.isEnabled = false
            }
        }
        alert.addAction(actionAlert)
        present(alert, animated: true, completion: nil)
    }
    func setUpActivityIndicatorView(){
//        activityIndicator =  UIImageView(image: #imageLiteral(resourceName: "activityIndicator"))
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        backView = UIView()
         activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        backView.addSubview(activityIndicator)
        view.addSubview(backView)
        activityIndicator.hidesWhenStopped = true
 //        activityIndicator.addSubview(UIImageView(image: #imageLiteral(resourceName: "activityIndicator")))
         backView.translatesAutoresizingMaskIntoConstraints  = false
        backView.topAnchor.constraint(equalTo: view.topAnchor)          .isActive = true
        backView.bottomAnchor.constraint(equalTo: view.bottomAnchor)    .isActive = true
        backView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backView.leadingAnchor.constraint(equalTo: view.leadingAnchor)  .isActive = true
        backView.backgroundColor = UIColor(rgb: 0xFFFFFF, alfa: 0.4)
        activityIndicator.centerXAnchor.constraint(equalTo: backView.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: backView.centerYAnchor).isActive = true
//        activityIndicator.animationImages = [#imageLiteral(resourceName: "activityIndicator")]
//        activityIndicator.animationDuration = .pi
        activityIndicator.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: {
            self.activityIndicator.stopAnimating()
            self.backView.removeFromSuperview()
        })
    }
}

