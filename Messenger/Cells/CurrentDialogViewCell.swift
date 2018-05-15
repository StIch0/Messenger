//
//  CurrentDialogViewCell.swift
//  Messenger
//
//  Created by Pavel Burdukovskii on 12/05/2018.
//  Copyright © 2018 Pavel Burdukovskii. All rights reserved.
//

import Foundation
import UIKit
class CurrentDialogsViewCell: UICollectionViewCell {
    var textMessage : UITextView! = {
    var textView  = UITextView()
//        textView.backgroundColor = UIColor(rgb: 0xD9D8D8, alfa: 1)
        return textView
    }()
    var dateTimeText: UILabel! = {
        var label = UILabel()
        return label
    }()
    var bubbleView : UIView! = {
        var view = UIView()
//        view.layer.cornerRadius = 4
//        view.layer.masksToBounds = true
//        view.backgroundColor = UIColor(rgb: 0xD9D8D8, alfa: 1)
        return view
    }()
    var dialogs : Message? {
        didSet {
            guard let dialog = dialogs else { return }
            textMessage.text = dialog.textMessage
            dateTimeText.text = dialog.dateTime
            textMessage.font = UIFont.italicSystemFont(ofSize: 15)
        }
    }
    
    var RightSideDateAnchor : NSLayoutConstraint = NSLayoutConstraint()
    var LeftSideDateAnchor : NSLayoutConstraint = NSLayoutConstraint()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        sizeToFit()
        setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        

    }
    func setUpView(){
        bubbleView = UIView()
        textMessage = UITextView()
        dateTimeText = UILabel()
        addSubview(bubbleView)
        
        textMessage.backgroundColor = .clear
        
        bubbleView.addSubview(textMessage)
        addSubview(dateTimeText)
        bubbleView.layer.cornerRadius = 4
        bubbleView.layer.masksToBounds = true
        bubbleView.backgroundColor = UIColor(rgb: 0xD9D8D8, alfa: 1)
        textMessage.isScrollEnabled = false
        textMessage.isEditable = false
        bubbleView.layer.shadowRadius = 4
        bubbleView.layer.shadowOffset = CGSize(width: 0.2, height: 0.2)
        bubbleView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor
        dateTimeText.translatesAutoresizingMaskIntoConstraints = false
        RightSideDateAnchor = dateTimeText.leftAnchor.constraint(equalTo: bubbleView.rightAnchor, constant: 8)
        LeftSideDateAnchor = dateTimeText.rightAnchor.constraint(equalTo: bubbleView.leftAnchor, constant: -8)
        dateTimeText.heightAnchor.constraint(equalToConstant: 20).isActive = true
        dateTimeText.bottomAnchor.constraint(equalTo: bubbleView.bottomAnchor, constant: -3).isActive = true
        dateTimeText.font = UIFont.systemFont(ofSize: 11)
        dateTimeText.textColor = .black
//        textMessage.layer.cornerRadius = 4
//        textMessage.layer.masksToBounds = true
//        bubbleView.addSubview(textMessage)
//        bubbleView.addSubview(dateTimeText)
//        bubbleView.translatesAutoresizingMaskIntoConstraints = false
//        textMessage.translatesAutoresizingMaskIntoConstraints = false
//        textMessage.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
//        textMessage.topAnchor.constraint(equalTo: topAnchor).isActive = true
//        textMessage.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
//        textMessage.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
//        textMessage.rightAnchor.constraint(equalTo: bubbleView.rightAnchor).isActive = true
//        textMessage.topAnchor.constraint(equalTo: bubbleView.topAnchor).isActive = true
//        textMessage.widthAnchor.constraint(equalTo: bubbleView.widthAnchor) .isActive = true
//        textMessage.heightAnchor.constraint(equalTo: bubbleView.heightAnchor).isActive = true
    }
}
