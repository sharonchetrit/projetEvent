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
        static let uid = Auth.auth().currentUser?.uid
        static let currentUser = Database.database().reference().child("User").child(uid!)
        static let databaseChats = currentUser.child("chats")
    }
}

