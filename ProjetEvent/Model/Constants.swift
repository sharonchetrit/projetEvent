//
//  Constants.swift
//  ProjetEvent
//
//  Created by Mac on 04/02/2018.
//  Copyright © 2018 Sharon Chetrit. All rights reserved.
//

import Firebase

struct Constants
{
    struct refs
    {
        static let databaseRoot = Database.database().reference()
        static let databaseChats = databaseRoot.child("chats")
    }
}

