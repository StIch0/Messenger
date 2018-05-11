//
//  DialogsViewCell.swift
//  Messenger
//
//  Created by Pavel Burdukovskii on 11/05/2018.
//  Copyright © 2018 Pavel Burdukovskii. All rights reserved.
//

import Foundation
import UIKit
class DialogsViewCell : UITableViewCell {
    var dialogs : Message?  {
        didSet {
            guard let dialog = dialogs else {
                return
            }
            let atributeStringMesaage = NSAttributedString(string: dialog.messageText, attributes: [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 18), NSAttributedStringKey.strokeColor: UIColor.black])
            let atributeStringDate = NSAttributedString(string: dialog.dateTime, attributes: [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 13), NSAttributedStringKey.strokeColor: UIColor.black])
            textDialogs.attributedText = atributeStringMesaage
            dateDialog.attributedText = atributeStringDate
            dateDialog.textAlignment = .right
            textDialogs.textAlignment = .left
            dateDialog.sizeToFit()
            textDialogs.sizeToFit()
            setUpView()
        }
    }
    var containerView : UIView! = {
        var view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        return view
    }()
    var textDialogs : UITextView! = {
        var dialog = UITextView()
        dialog.isEditable = false
        return dialog
    }()
    var dateDialog : UITextView! = {
        var date  = UITextView()
        date.isEditable = false
        return date
    }()
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    func setUpView() -> Void {
        addSubview(containerView)
        containerView.addSubview(textDialogs)
        containerView.addSubview(dateDialog)
        containerView.translatesAutoresizingMaskIntoConstraints     = false
        textDialogs.translatesAutoresizingMaskIntoConstraints       = false
        dateDialog.translatesAutoresizingMaskIntoConstraints        = false
        
        containerView.topAnchor.constraint(equalTo: topAnchor)             .isActive = true
        containerView.heightAnchor.constraint(equalTo: heightAnchor)       .isActive = true
        containerView.leadingAnchor.constraint(equalTo: leadingAnchor)     .isActive = true
        containerView.trailingAnchor.constraint(equalTo: trailingAnchor)   .isActive = true
        
        textDialogs.topAnchor.constraint(equalTo: containerView.topAnchor) .isActive = true
        textDialogs.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        textDialogs.bottomAnchor.constraint(equalTo: containerView.centerYAnchor, constant: 0).isActive = true
        textDialogs.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        
        dateDialog.topAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        dateDialog.bottomAnchor.constraint(equalTo: containerView.bottomAnchor) .isActive = true
        dateDialog.leftAnchor.constraint(equalTo: containerView.leftAnchor) .isActive = true
        dateDialog.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
    }
}
