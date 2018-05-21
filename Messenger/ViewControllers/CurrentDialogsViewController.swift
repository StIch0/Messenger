//
//  CurrentDialogsViewController.swift
//  Messenger
//
//  Created by Pavel Burdukovskii on 11/05/2018.
//  Copyright © 2018 Pavel Burdukovskii. All rights reserved.
//

import Foundation
import UIKit
@available(iOS 10.0, *)
class CurrentDialogsViewController: UIViewController {
    var collectionView : UICollectionView!
    var container : UIView!
    var textMessage: UITextField!
    var sendMessage : UIButton!
    var dialog : [Message] = Array()
    var inputViewBottomAnchor : NSLayoutConstraint?
    var collectionViewBottomAnchor : NSLayoutConstraint?
    let currentDateTime = Date()
    let formater = DateFormatter()
    var id : UInt32 = 100
    var layout : UICollectionViewFlowLayout!
    var user : User! {
        didSet {
            guard let mesDialog = user.message?.allObjects as? [Message] else { return }
            dialog = mesDialog
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
        view.backgroundColor = .white
        title = "Чат"
        container = UIView()
        textMessage = UITextField()
        sendMessage = UIButton()
        layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: CGRect.init(x: 0, y: 0, width: view.frame.width, height: view.frame.height), collectionViewLayout: layout)
        setUpNavBar()
        setUpCollectionView()
        collectionView.reloadData()
        setUpKeyBoardObservers()
 
        hideKeyboard()
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        arrId.removeAll()
        NotificationCenter.default.removeObserver(self)
    }
    
    func setUpNavBar (){
        let navBar  = navigationController?.navigationBar
        navBar?.barStyle = .default
        navBar?.layer.shadowColor = UIColor(rgb: 0x000000, alfa: 0.38).cgColor
        navBar?.layer.shadowOffset =  CGSize(width: 1, height: 5)
        navBar?.layer.shadowRadius = 7
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
        
        container.backgroundColor = .white
        container.layer.shadowRadius = 4
        container.layer.shadowOffset = CGSize(width: 1, height: 5)
        container.layer.shadowColor = UIColor(rgb: 0x000000, alfa: 0.5).cgColor
        textMessage.backgroundColor = UIColor(rgb: 0xE7E7E7, alfa: 1)
        textMessage.font = UIFont.systemFont(ofSize: 17)
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
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)  .isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor)    .isActive = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor(rgb: 0xF4F3F3, alfa: 1)
        collectionView.keyboardDismissMode = .onDrag
        collectionViewBottomAnchor  = collectionView.bottomAnchor.constraint(equalTo: container.topAnchor)
        collectionViewBottomAnchor?.isActive = true

    }
    
    @available(iOS 10.0, *)
    @objc func sendMessageBtn(){
        if textMessage.text != "" {
            let dateTime = formater.string(from: currentDateTime)
            let index = arc4random_uniform(2)
            print("arrId" , arrId)
            var idd : Int32 = 0
            if index == 0 {
                idd = Int32(arrId.first!)
            }
            else {
                idd = Int32(arrId.last!)
            }
            
            let uuser = User(context: manageContext)
            
            uuser.id = Int32(idd)
            let newMessage = Message(context: manageContext)
            newMessage.textMessage = textMessage.text!
            newMessage.dateTime = dateTime
            newMessage.user = uuser
          
        dialog.append(newMessage)
            do {
                try manageContext.save()
            }
            catch let error {
                print("Error = ",error.localizedDescription)
            }
        textMessage.text = ""
        collectionView.scrollToLast()
        collectionView.reloadData()
        }
    }
}
