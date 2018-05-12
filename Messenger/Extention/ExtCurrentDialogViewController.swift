//
//  ExtCurrentDialogViewController.swift
//  Messenger
//
//  Created by Pavel Burdukovskii on 11/05/2018.
//  Copyright © 2018 Pavel Burdukovskii. All rights reserved.
//

import Foundation
import  UIKit
extension CurrentDialogsViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : CurrentDialogsViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cuurentMessageCell", for: indexPath) as! CurrentDialogsViewCell
        cell.dialogs = dialog[indexPath.row]
        
        let messText = dialog[indexPath.item].messageText
        let size = CGSize(width: 250, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let estimatedFrame = NSString(string: messText).boundingRect(with: size, options: options, attributes: [NSAttributedStringKey.font : UIFont.italicSystemFont(ofSize: 15)], context: nil)
 
        cell.textMessage.frame = CGRect(x: 10, y: 10, width: estimatedFrame.width + 10 + 30 , height: estimatedFrame.height + 15)
        cell.bubbleView.frame = CGRect(x: 10, y: 10, width: estimatedFrame.width + 10 + 35, height: estimatedFrame.height + 15 + 10)

        return cell
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dialog.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(10)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
         let messText = dialog[indexPath.item].messageText
            let size = CGSize(width: view.frame.width, height: 1000)
            let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let estimatedFrame = NSString(string: messText).boundingRect(with: size, options: options, attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 15)], context: nil)
        return CGSize(width: view.frame.width, height: estimatedFrame.height + 15)
    }
    
}
