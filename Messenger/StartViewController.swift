//
//  StartViewController.swift
//  Messenger
//
//  Created by Pavel Burdukovskii on 10/05/2018.
//  Copyright © 2018 Pavel Burdukovskii. All rights reserved.
//

import Foundation
import UIKit
class StartViewController : UIViewController {
    var image : UIImageView!
    var inputButton : UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(rgb: 0xFFFFFF, alfa: 1)
        setUpImageView()
        setUpAnchorViewButton()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        seUpButtonView()
    }
    func setUpImageView (){
        image = UIImageView(image: #imageLiteral(resourceName: "StartScreen"))
        view.addSubview(image)
        image.backgroundColor = .white
        image.translatesAutoresizingMaskIntoConstraints = false
        image.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        image.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        image.layer.shadowOffset = CGSize(width: 0.2, height: 0.2)
        image.layer.shadowColor = UIColor(rgb: 0x000000, alfa: 0.5).cgColor
        image.layer.shadowRadius = 4
    }
    func setUpAnchorViewButton(){
        inputButton = UIButton(type: .custom)
        view.addSubview(inputButton)
        inputButton.translatesAutoresizingMaskIntoConstraints = false
        inputButton.bottomAnchor.constraint(equalTo: view.bottomAnchor)         .isActive = true
        if #available(iOS 11.0, *) {
            inputButton.trailingAnchor.constraint(equalTo: image.trailingAnchor).isActive = true
        } else {
            // Fallback on earlier versions
        }
        if #available(iOS 11.0, *) {
            inputButton.leadingAnchor.constraint(equalTo: image.leadingAnchor)  .isActive = true
        } else {
            // Fallback on earlier versions
        }
        inputButton.heightAnchor.constraint(equalTo: image.heightAnchor)        .isActive = true
     }
    func seUpButtonView(){
        inputButton.clipsToBounds = true
        inputButton.setTitle("Войти", for: .normal)
        inputButton.backgroundColor = UIColor(rgb: 0xCF1F28, alfa : 1)
        inputButton.layer.shadowColor = UIColor(rgb: 0xE4222D, alfa: 0.5).cgColor
        inputButton.layer.shadowRadius = 9
        inputButton.layer.shadowOffset = CGSize(width: 0.2, height: 0.2)
        inputButton.setTitleShadowColor(UIColor.init(rgb: 0xFFFFFF, alfa: 1), for: .normal)
        inputButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        inputButton.layer.cornerRadius = inputButton.layer.frame.height
        inputButton.addTarget(self, action: #selector(loadMainView), for: .touchDown)
    }
    
    @objc func loadMainView (){
        let viewController : ViewController = ViewController()
        navigationController?.setViewControllers([viewController], animated: true)
    }
}
