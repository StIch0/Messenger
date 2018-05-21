//
//  ViewController.swift
//  Messenger
//
//  Created by Pavel Burdukovskii on 10/05/2018.
//  Copyright © 2018 Pavel Burdukovskii. All rights reserved.
//

import UIKit
import CoreData
@available(iOS 10.0, *)
class ViewController: UIViewController {
    var activityIndicator : UIActivityIndicatorView!
    var backView : UIView!
    var tableView : UITableView!
    var titleAlert : String = ""
    var dialogs : [Message] = Array()
    let currentDateTime = Date()
    let formater = DateFormatter()
    var spinner : UIImageView!
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
        setUpActivityIndicatorView()
    }
    func loadData (){
        var mes : [Message] = Array()
        if let users = fetchUser(){
        for obj in users {
            print(obj.id)
//            manageContext.delete(obj)
            let request : NSFetchRequest<Message> = Message.fetchRequest()
            request.sortDescriptors = [NSSortDescriptor(key: "dateTime", ascending: false)]
            //this block don't work correctly, i don't know why?????
            let predicate = NSPredicate(format: "user.id = %@","\(obj.id)")
            request.predicate = predicate
            request.fetchLimit = 1
            //end block
            do {
                mes = try manageContext.fetch(request)
                dialogs.append(contentsOf: mes)
            }
            catch let error {
                print("Error = ", error.localizedDescription)
            }
            }
            
        }
        
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
 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        animateSpinner()

    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
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
        navBar?.layer.shadowOffset = CGSize(width: 1, height: 5)
        navBar?.layer.shadowRadius = 7
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addDialogs))
        add.setBackgroundImage(#imageLiteral(resourceName: "iconAdd"), for: .normal, barMetrics: .default)
     
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

                let id = arc4random_uniform(100)+1
                print("id = ", id)
                //set value to userObject for save
                userObject.setValue(id, forKey: "id")
                let dateTime = self.formater.string(from: self.currentDateTime)
//                //set value to messageObject for save
                messageObject.setValue(message.text!, forKey: "textMessage")
                messageObject.setValue(dateTime, forKey: "dateTime")
                messageObject.setValue(userObject, forKey: "user")
                
                self.dialogs.append(messageObject)
                
                self.dialogs.sort(by: { $0.dateTime! > $1.dateTime! })
                self.tableView.reloadData()
            }
            else {
                action.isEnabled = false
            }
        }
        alert.addAction(actionAlert)
        present(alert, animated: true, completion: nil)
    }
    func animateSpinner(){
        UIView.animate(withDuration: 0.5, delay: 0.5 , options : [.curveEaseInOut,
                                                                .repeat,
                                                                .autoreverse ] ,
                       animations: {
                        self.spinner.transform = self.spinner.transform.rotated(by: .pi)

        }, completion: nil)
    }
    func setUpActivityIndicatorView(){
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        backView = UIView()
         activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        spinner = UIImageView(image: #imageLiteral(resourceName: "activityIndicator"))
        view.addSubview(backView)
//        backView.addSubview(activityIndicator)
        backView.addSubview(spinner)
         activityIndicator.hidesWhenStopped = true
        backView.translatesAutoresizingMaskIntoConstraints  = false
        backView.topAnchor.constraint(equalTo: view.topAnchor)          .isActive = true
        backView.bottomAnchor.constraint(equalTo: view.bottomAnchor)    .isActive = true
        backView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backView.leadingAnchor.constraint(equalTo: view.leadingAnchor)  .isActive = true
        backView.backgroundColor = UIColor(rgb: 0xFFFFFF, alfa: 0.4)
       
//        activityIndicator.centerXAnchor.constraint(equalTo: backView.centerXAnchor).isActive = true
//        activityIndicator.centerYAnchor.constraint(equalTo: backView.centerYAnchor).isActive = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.centerXAnchor.constraint(equalTo: backView.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: backView.centerYAnchor).isActive = true
        

//        activityIndicator.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: {
//            self.activityIndicator.stopAnimating()
            self.backView.removeFromSuperview()
        })

    }
}

