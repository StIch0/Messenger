//
//  Messange.swift
//  Messenger
//
//  Created by Pavel Burdukovskii on 10/05/2018.
//  Copyright © 2018 Pavel Burdukovskii. All rights reserved.
//

import Foundation
class Message{
    var messageText : String
    var dateTime    : String
    var user : User
    init(messageText :String, dateTime : String, user : User) {
        self.messageText = messageText
        self.dateTime = dateTime
        self.user = user
    }
}
