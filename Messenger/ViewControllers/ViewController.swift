//
//  ViewController.swift
//  Messenger
//
//  Created by Pavel Burdukovskii on 10/05/2018.
//  Copyright © 2018 Pavel Burdukovskii. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var activityIndicator : UIActivityIndicatorView!
    var backView : UIView!
    var tableView : UITableView!
    
    var dialogs : [Message] = Array()
    let currentDateTime = Date()
    let formater = DateFormatter()
    override func viewDidLoad() {
        super.viewDidLoad()
        formater.timeStyle = .medium
        formater.dateStyle = .long
        formater.dateFormat = "HH:mm"
        dialogs.append(Message(messageText: "adaddad", dateTime: formater.string(from: currentDateTime)))
        setUpNavBar()
        setUpTableView()
        view.backgroundColor = .white
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
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
        navigationItem.rightBarButtonItem = add
    }
    @objc func addDialogs(){
        print("1")
        let alert : UIAlertController = UIAlertController(title: "Диалогов не найдено", message: "", preferredStyle: .alert)
        alert.addTextField(configurationHandler: {
            mes in
            mes.placeholder = "Введите сообщение"
        })
        print("2")
        let actionAlert = UIAlertAction(title: "Добавить", style: .default){
           action in
            print("qewqeqewq")
            action.isEnabled = true
            let message = alert.textFields![0]
            print(message.text)
            if message.text != ""  {
                self.dialogs.append(Message(messageText: (message.text)!, dateTime: self.formater.string(from: self.currentDateTime)))
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

