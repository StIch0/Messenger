//
//  CurrentDialogsViewController.swift
//  Messenger
//
//  Created by Pavel Burdukovskii on 11/05/2018.
//  Copyright © 2018 Pavel Burdukovskii. All rights reserved.
//

import Foundation
import UIKit
class CurrentDialogsViewController: UIViewController {
    var collectionView : UICollectionView!
    var container : UIView!
    var textMessage: UITextField!
    var sendMessage : UIButton!
    var dialog : [Message] = Array()
    var inputViewBottomAnchor : NSLayoutConstraint?
    let currentDateTime = Date()
    let formater = DateFormatter()
    var id : UInt32 = 100
    var layout : UICollectionViewFlowLayout!
    var user : User! {
        didSet {
            guard let mesDialog = user.message?.allObjects as? [Message] else { return }
            dialog = mesDialog
            navigationItem.title = "\(id)"
        }
    }
    
    var arrId : [UInt32] = Array()
    let manageContext = DatabaseManager.shared.persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()
        arrId.append(id)
        arrId.append(0)
        formater.timeStyle = .medium
        formater.dateStyle = .long
        formater.dateFormat = "HH:mm"
//        print(dialog.first?.messageText)
        //dialog.append(Message(messageText: (dialog.first?.messageText)!, dateTime: (dialog.first?.dateTime)!))
        view.backgroundColor = .white
     
        container = UIView()
        textMessage = UITextField()
        sendMessage = UIButton()
        layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: CGRect.init(x: 0, y: 0, width: view.frame.width, height: view.frame.height), collectionViewLayout: layout)
//        user = User(context: manageContext)
        
        setUpCollectionView()
        collectionView.reloadData()

        setUpKeyBoardObservers()
 
        hideKeyboard()
//        var user0 = User(id: 0)
//        var user1 = User(id: 1)
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        if id == 0 {
            id = arrId.first!
        }
        arrId.removeAll()
        NotificationCenter.default.removeObserver(self)
    }
    
    
    func setUpCollectionView (){

        collectionView.register(CurrentDialogsViewCell.self, forCellWithReuseIdentifier: "cuurentMessageCell")

        
        view.addSubview(collectionView)
        view.addSubview(container)
        container.addSubview(textMessage)
        container.addSubview(sendMessage)
        
        
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        container.translatesAutoresizingMaskIntoConstraints = false
        textMessage.translatesAutoresizingMaskIntoConstraints = false
        sendMessage.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.showsVerticalScrollIndicator = true
        collectionView.alwaysBounceVertical = true
        
        container.backgroundColor = .white//Color
        collectionView.backgroundColor = .white
        textMessage.backgroundColor = UIColor(rgb: 0xE7E7E7, alfa: 1)
//        sendMessage.backgroundColor = UIColor(rgb: 0xE11C28, alfa: 1)
        sendMessage.backgroundColor = .white
        sendMessage.setBackgroundImage(#imageLiteral(resourceName: "iconSend"), for: .normal)
        sendMessage.addTarget(self, action: #selector(sendMessageBtn), for: .touchDown)
        
        
        container.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        container.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        container.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        container.topAnchor.constraint(equalTo: collectionView.bottomAnchor).isActive = true
        container.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        inputViewBottomAnchor = container.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        inputViewBottomAnchor?.isActive = true
        
        textMessage.leftAnchor.constraint(equalTo: container.leftAnchor, constant: 15).isActive = true
        textMessage.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -7).isActive = true
        textMessage.topAnchor.constraint(equalTo: container.topAnchor, constant: 7).isActive = true
        textMessage.rightAnchor.constraint(equalTo: sendMessage.leftAnchor, constant: -7).isActive = true
        textMessage.layer.cornerRadius = 5
        sendMessage.rightAnchor.constraint(equalTo: container.rightAnchor, constant: -15).isActive = true
        sendMessage.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -7).isActive = true
        sendMessage.topAnchor.constraint(equalTo: container.topAnchor, constant: 7).isActive = true
        sendMessage.leftAnchor.constraint(equalTo: textMessage.rightAnchor, constant : 7).isActive = true
        sendMessage.widthAnchor.constraint(equalToConstant: 40).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.topAnchor)      .isActive = true
        collectionView.bottomAnchor.constraint(equalTo: container.topAnchor)      .isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)  .isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor)    .isActive = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.keyboardDismissMode = .onDrag
    }
    
    @objc func sendMessageBtn(){
        if textMessage.text != "" {
            let dateTime = formater.string(from: currentDateTime)
            let index = arc4random_uniform(2)
            print("arrId" , arrId)
            if index == 0 {
                user.id = Int32.init(bitPattern: arrId.first!)
            }
            else {
                user.id = Int32.init(bitPattern: arrId.last!)
            }
            let newMessage = Message(context: manageContext)
            newMessage.textMessage = textMessage.text!
            newMessage.dateTime = dateTime
            newMessage.user = user
          
        dialog.append(newMessage)
        
        textMessage.text = ""
        collectionView.reloadData()
            do{
                try manageContext.save()
            }
            catch let error {
                print("Error = ", error)
            }
            //        dismissKeyboard()
            
        }
    }
}
