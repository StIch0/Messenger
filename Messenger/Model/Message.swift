//
//  Messange.swift
//  Messenger
//
//  Created by Pavel Burdukovskii on 10/05/2018.
//  Copyright © 2018 Pavel Burdukovskii. All rights reserved.
//

import Foundation
class Message {
    var messageText : String
    var dateTime    : Date
    init(messageText :String, dateTime : Date) {
        self.messageText = messageText
        self.dateTime = dateTime
    }
}
