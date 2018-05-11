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
    var startImage : UIImageView = {
        var image = UIImageView(image: #imageLiteral(resourceName: "StartScreen"))
        image.layer.shadowOffset = CGSize(width: 0.2, height: 0.2)
        image.layer.shadowColor = UIColor(rgb: 0x000000, alfa: 0.5).cgColor
        image.layer.shadowRadius = 4
        return image
    }()
    
    var inputButton : UIButton = {
        var button = UIButton()
        button.setTitle("Войти", for: .normal)
        button.backgroundColor = UIColor(rgb: 0xCF1F28, alfa : 1)
        button.layer.shadowColor = UIColor(rgb: 0xE4222D, alfa: 0.5).cgColor
        button.layer.shadowRadius = 9
        button.layer.shadowOffset = CGSize(width: 0.2, height: 0.2)
        button.setTitleShadowColor(UIColor.init(rgb: 0xFFFFFF, alfa: 1), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.titleLabel?.textColor = UIColor(rgb: 0xFFFFFF, alfa: 1)
        print(button.frame.height)
        print(button.bounds.height)
        print(button.layer.frame.height)
        print(button.layer.bounds.height)
        button.layer.cornerRadius = button.bounds.height
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(rgb: 0xFFFFFF, alfa: 1)
        setUpImageView()
        seUpButtonView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    func setUpImageView (){
        view.addSubview(startImage)
        startImage.backgroundColor = .white
        startImage.translatesAutoresizingMaskIntoConstraints = false
        startImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        startImage.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

    func seUpButtonView(){
        view.addSubview(inputButton)
        inputButton.translatesAutoresizingMaskIntoConstraints = false
        inputButton.bottomAnchor.constraint(equalTo: view.bottomAnchor)         .isActive = true
        inputButton.trailingAnchor.constraint(equalTo: startImage.trailingAnchor)    .isActive = true
        inputButton.leadingAnchor.constraint(equalTo: startImage.leadingAnchor)      .isActive = true
        inputButton.heightAnchor.constraint(equalTo: startImage.heightAnchor)        .isActive = true
        inputButton.addTarget(self, action: #selector(loadMainView), for: .touchDown)
    }
    
    @objc func loadMainView (){
        let viewController : ViewController = ViewController()
        navigationController?.setViewControllers([viewController], animated: true)
    }
}
