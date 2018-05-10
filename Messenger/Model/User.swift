//
//  User.swift
//  Messenger
//
//  Created by Pavel Burdukovskii on 10/05/2018.
//  Copyright © 2018 Pavel Burdukovskii. All rights reserved.
//

import Foundation
class User {
    var id : Int = 0
    var message : [Message] = Array()
    init(id :Int) {
        self.id = id
    }
}
