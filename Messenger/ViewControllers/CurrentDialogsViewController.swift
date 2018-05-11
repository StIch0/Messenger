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
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCollectionView()
        view.backgroundColor = .white
    }
    
    func setUpCollectionView (){
        let layout = UICollectionViewFlowLayout()
        
        collectionView = UICollectionView(frame: CGRect.init(x: 0, y: 0, width: view.frame.width, height: view.frame.height), collectionViewLayout: layout)
        view.addSubview(collectionView)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.heightAnchor.constraint(equalTo: view.heightAnchor)      .isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)      .isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)  .isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor)    .isActive = true
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}
