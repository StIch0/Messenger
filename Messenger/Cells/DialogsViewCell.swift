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
            let atributeStringMesaage = NSAttributedString(string: dialog.textMessage!, attributes: [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 18)])
            let atributeStringDate = NSAttributedString(string: dialog.dateTime!, attributes: [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 13)])
            textDialogs.attributedText = atributeStringMesaage
            dateDialog.attributedText = atributeStringDate
            dateDialog.textAlignment = .right
            textDialogs.textAlignment = .left
            textDialogs.backgroundColor = .black
            dateDialog.backgroundColor = .black
            textDialogs.textColor = .white
            textDialogs.numberOfLines = 1
            dateDialog.textColor = .white
            containerView.layer.cornerRadius = 8
            dateDialog.sizeToFit()
            textDialogs.sizeToFit()
            setUpView()
        }
    }
    var containerView : UIView! = {
        var view = UIView()
        return view
    }()
    var textDialogs : UILabel! = {
        var dialog = UILabel()
         return dialog
    }()
    var dateDialog : UILabel! = {
        var date  = UILabel()
         return date
    }()
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        sizeToFit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpView() -> Void {
        addSubview(containerView)
        containerView.addSubview(textDialogs)
        containerView.addSubview(dateDialog)
        containerView.translatesAutoresizingMaskIntoConstraints     = false
        textDialogs.translatesAutoresizingMaskIntoConstraints       = false
        dateDialog.translatesAutoresizingMaskIntoConstraints        = false
        
        containerView.clipsToBounds = true
        containerView.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
        
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
