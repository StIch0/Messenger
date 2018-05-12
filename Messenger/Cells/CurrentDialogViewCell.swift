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
            textMessage.text = dialog.messageText
            dateTimeText.text = dialog.dateTime
            textMessage.font = UIFont.italicSystemFont(ofSize: 15)
        }
    }
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
        bubbleView.addSubview(textMessage)
        bubbleView.addSubview(dateTimeText)
        bubbleView.layer.cornerRadius = 4
        bubbleView.layer.masksToBounds = true
        bubbleView.backgroundColor = UIColor(rgb: 0xD9D8D8, alfa: 1)
        textMessage.backgroundColor = UIColor(rgb: 0xD9D8D8, alfa: 1)
        textMessage.isScrollEnabled = false
        textMessage.isEditable = false
        dateTimeText.translatesAutoresizingMaskIntoConstraints = false
        dateTimeText.leftAnchor.constraint(equalTo: bubbleView.rightAnchor).isActive = true
        dateTimeText.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        dateTimeText.heightAnchor.constraint(equalToConstant: 20).isActive = true
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
