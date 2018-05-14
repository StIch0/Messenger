//
//  Message+CoreDataProperties.swift
//  Messenger
//
//  Created by Pavel Burdukovskii on 13/05/2018.
//  Copyright © 2018 Pavel Burdukovskii. All rights reserved.
//
//

import Foundation
import CoreData


extension Message {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Message> {
        return NSFetchRequest<Message>(entityName: "Message")
    }

    @NSManaged public var textMessage: String?
    @NSManaged public var dateTime: String?
    @NSManaged public var user: User?

}
