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
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dialogs.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = CurrentDialogsViewController()
        controller.dialog.append(dialogs[indexPath.row])
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func deleteItem (at indexPath : IndexPath)->UIContextualAction{
        let action = UIContextualAction(style: .destructive, title: ""){
            (action, view, completion) in
            self.dialogs.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
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
