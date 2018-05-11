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
        image.clipsToBounds = false
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
        button.translatesAutoresizingMaskIntoConstraints = false
        
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
        startImage.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        startImage.contentMode = .scaleAspectFill
    
        startImage.sizeToFit()
    }

    func seUpButtonView(){
        view.addSubview(inputButton)
        
        inputButton.translatesAutoresizingMaskIntoConstraints = false
        inputButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -15) .isActive = true
        inputButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        inputButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        inputButton.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.08)        .isActive = true
        inputButton.addTarget(self, action: #selector(loadMainView), for: .touchDown)
        
        inputButton.layer.cornerRadius = UIScreen.main.bounds.height * 0.08 / 2
        print(inputButton.heightAnchor)
        print(inputButton.bounds.height)
        print(inputButton.layer.frame.height)
        print(inputButton.layer.bounds.height)
    }
    
    @objc func loadMainView (){
        let viewController : ViewController = ViewController()
        navigationController?.pushViewController(viewController, animated: true)
     }
}
