//
//  ExtViewController.swift
//  Messenger
//
//  Created by Pavel Burdukovskii on 10/05/2018.
//  Copyright © 2018 Pavel Burdukovskii. All rights reserved.
//

import Foundation
import UIKit
extension ViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : DialogsViewCell = tableView.dequeueReusableCell(withIdentifier: "dialogCell", for: indexPath) as! DialogsViewCell
        cell.dialogs = dialogs[indexPath.row]
        if let id = dialogs[indexPath.row].user?.id{
            cell.id = id
    }
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dialogs.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! DialogsViewCell
        let controller = CurrentDialogsViewController()
        if controller.id != 0 {
        controller.user = dialogs[indexPath.row].user
        controller.id = UInt32(cell.id)
        print(cell.id)
            navigationController?.pushViewController(controller, animated: true)
            
        }
    }
    
    func deleteItem (at indexPath : IndexPath)->UIContextualAction{
        let action = UIContextualAction(style: .destructive, title: ""){
            (action, view, completion) in
            self.manageContext.delete(self.dialogs[indexPath.row])
            if let user = self.dialogs[indexPath.row].user {
                self.manageContext.delete(user)
                
            }
            self.dialogs.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
                 do {
                    try self.manageContext.save()
                }
                catch let error {
                    print("Error = " ,error.localizedDescription)
                }
            completion(true)
        }
        action.image = #imageLiteral(resourceName: "iconDelete")
        return action
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = deleteItem(at: indexPath)
        return UISwipeActionsConfiguration(actions: [delete])
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
