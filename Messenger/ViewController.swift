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
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = .red
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setUpActivityIndicatorView(){
        activityIndicator = UIActivityIndicatorView()
        backView = UIView()
        view.addSubview(backView)
        backView.addSubview(activityIndicator)
        backView.topAnchor.constraint(equalTo: view.topAnchor)          .isActive = true
        backView.bottomAnchor.constraint(equalTo: view.bottomAnchor)    .isActive = true
        backView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backView.leadingAnchor.constraint(equalTo: view.leadingAnchor)  .isActive = true
    }
}

