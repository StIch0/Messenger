//
//  ExtCurrentDialogViewController.swift
//  Messenger
//
//  Created by Pavel Burdukovskii on 11/05/2018.
//  Copyright © 2018 Pavel Burdukovskii. All rights reserved.
//

import Foundation
import  UIKit
@available(iOS 10.0, *)
extension CurrentDialogsViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : CurrentDialogsViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cuurentMessageCell", for: indexPath) as! CurrentDialogsViewCell
        cell.dialogs = dialog[indexPath.row]
        if let messText = dialog[indexPath.item].textMessage{
        let size = CGSize(width: 250, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let estimatedFrame = NSString(string: messText).boundingRect(with: size, options: options, attributes: [:], context: nil)

        cell.textMessage.frame = CGRect(x: 5, y: 0, width: estimatedFrame.width + 10 + 30, height: estimatedFrame.height + 15)
        
        //different users
        let id = dialog[indexPath.row].user?.id
        if id  == 0 {
            cell.bubbleView.backgroundColor = UIColor(rgb: 0xD9D8D8, alfa: 1)
            cell.RightSideDateAnchor.isActive = false
            cell.LeftSideDateAnchor.isActive = true
            cell.bubbleView.frame = CGRect(x: UIScreen.main.bounds.width - 10 - (estimatedFrame.width + 10 + 35), y: 0, width: estimatedFrame.width + 10 + 35 , height: estimatedFrame.height + 15 + 10)
        }
        else {
            cell.bubbleView.backgroundColor = UIColor(rgb: 0xFFFFFF, alfa: 1)
            cell.LeftSideDateAnchor.isActive = false
            cell.RightSideDateAnchor.isActive = true
            cell.bubbleView.frame = CGRect(x: 10, y: 0, width: estimatedFrame.width + 10 + 35 , height: estimatedFrame.height + 15 + 10)
        }
        }
        
    
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dialog.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(10)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let messText = dialog[indexPath.item].textMessage{
            let size = CGSize(width: view.frame.width, height: 1000)
            let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let estimatedFrame = NSString(string: messText).boundingRect(with: size, options: options, attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 15)], context: nil)
            return CGSize(width: view.frame.width, height: estimatedFrame.height + 30)
            
        }
        return CGSize(width: view.frame.width, height: view.frame.height)

    }
}
