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
    var layout : UICollectionViewFlowLayout!
    override func viewDidLoad() {
        super.viewDidLoad()
        formater.timeStyle = .medium
        formater.dateStyle = .long
        formater.dateFormat = "HH:mm"
        print(dialog.first?.messageText)
        //dialog.append(Message(messageText: (dialog.first?.messageText)!, dateTime: (dialog.first?.dateTime)!))
        view.backgroundColor = .white
        layout = UICollectionViewFlowLayout()
        container = UIView()
        textMessage = UITextField()
        sendMessage = UIButton()
        setUpCollectionView()
        setUpKeyBoardObservers()
        hideKeyboard()
//        var user0 = User(id: 0)
//        var user1 = User(id: 1)
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
         NotificationCenter.default.removeObserver(self)
    }
    
    
    func setUpCollectionView (){
        
        collectionView = UICollectionView(frame: CGRect.init(x: 0, y: 0, width: view.frame.width, height: view.frame.height), collectionViewLayout: layout)
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
            var id = (arc4random_uniform(2))
            print(arc4random_uniform(2))
            let newMessage = Message(messageText: textMessage.text!, dateTime: formater.string(from: currentDateTime), user: User(id : id))
            print("message  = " , newMessage.messageText)
        dialog.append(newMessage)
        
        textMessage.text = ""
        collectionView.reloadData()
        
            //        dismissKeyboard()
            
        }
    }
}
