//
//  Event.swift
//  ProjetEvent
//
//  Created by David Mamou on 4/01/18.
//  Copyright © 2018 Sharon Chetrit. All rights reserved.
//

import UIKit

class Event: NSObject
{
    static func ==(lhs: Event, rhs: Event) -> Bool {
        return lhs.name == rhs.name
    }
    
    
    var name : String
    var depart : String
    var arrive : String
    var eventDescription : String
    
    init(name:String, depart:String, arrive:String,eventDescription: String) {
        self.name = name
        self.depart = depart
        self.arrive = arrive
        self.eventDescription = eventDescription
    }

    
  
    
}
