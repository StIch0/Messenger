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
        let userDef = UserDefaults.standard
        cell.dialogs = dialog[indexPath.row]
        print("dialog[indexPath.row].textMessage = ", dialog[indexPath.row].textMessage)
        if let messText = dialog[indexPath.item].textMessage{
        let size = CGSize(width: 250, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let estimatedFrame = NSString(string: messText).boundingRect(with: size, options: options, attributes: [:], context: nil)

        cell.textMessage.frame = CGRect(x: 5, y: 0, width: estimatedFrame.width + 10 + 30, height: estimatedFrame.height + 15)
        cell.bubbleView.frame = CGRect(x: 10, y: 0, width: estimatedFrame.width + 10 + 35 , height: estimatedFrame.height + 15 + 10)
        }
        //different users
        print (dialog[indexPath.row].user?.id)
         let id = dialog[indexPath.row].user?.id
        print("id in collection view cell = ", id)
            if id  == 0 {
            cell.bubbleView.backgroundColor = .red
        }
        else {
            cell.bubbleView.backgroundColor = .green
            }
        
    
        
//        collectionView.scrollToItem(at: indexPath, at: .bottom, animated: true)
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
//    override func viewDidLayoutSubviews() {
//        let section = 0
//        let lastItemIndex = self.collectionView.numberOfItems(inSection: section) - 1
//        let indexPath:NSIndexPath = NSIndexPath(item: lastItemIndex, section: section)
//        self.collectionView.scrollToItem(at: indexPath as IndexPath, at: .bottom, animated: true)
//    }
}
