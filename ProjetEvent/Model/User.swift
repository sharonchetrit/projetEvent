//
//  User.swift
//  ProjetEvent
//
//  Created by Mac on 04/01/2018.
//  Copyright © 2018 Sharon Chetrit. All rights reserved.
//

import Foundation


class User : NSObject
{
    static var sharedInstance = User()
    
    var name: String?
    var surname: String?
    var birthday: String?
    var email: String?
    var phone: String?
    var password: String?
    var confirmPass: String?
    
}

