//
//  Event.swift
//  ProjetEvent
//
//  Created by David Mamou on 4/01/18.
//  Copyright © 2018 Sharon Chetrit. All rights reserved.
//

import UIKit

class Event: Codable
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
    
    init(dictionary: [String : Any] )
    {
        self.name = (dictionary["name"] as? String)!
        self.depart = (dictionary["depart"] as? String)!
        self.arrive = (dictionary["arrive"] as? String)!
        self.eventDescription = (dictionary["eventDescription"] as? String)!
    }

    static var archiveURL: URL{
        get{
            let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            return documentDirectory.appendingPathComponent("events").appendingPathExtension(".plist")
        }
    }
    
    static func loadSampleFromPlist() -> [Event]
    {
        var sampleEvent : [Event] = []
        
        var eventArray : [Any] = []
        
        if let path = Bundle.main.path(forResource: "events", ofType: "plist")
        {
            eventArray = NSArray(contentsOf: URL(fileURLWithPath: path)) as! [Any] // we get the array from the file here!!!!!!!
        }
        
        if let array : [Dictionary<String,Any>] = eventArray as! [Dictionary<String, Any>] {
            // Use your dict here
            
            for dict in array
            {
                let newEvent = Event(dictionary: dict)
                sampleEvent.append(newEvent)
            }
        }
        
        return sampleEvent
    }
    
    static func loadFromFile() -> Array<Event>?
    {
        let propertyListDecoder = PropertyListDecoder()
        if let eventsData = try? Data(contentsOf: archiveURL){
            if let eventsArray = try? propertyListDecoder.decode(Array<Event>.self, from: eventsData){
                return eventsArray
            }
        }
        return nil
        
    }
    
    static func loadEventSample() -> Array<Event>
    {
        let sampleEvents = [
            Event(name: "Anniversaire", depart: "14-11-2018", arrive: "17-11-1998", eventDescription: "restaurant"),
            ]
        
        return sampleEvents
        
    }
    
    static func saveToFile(events:Array<Event> )
    {
        let propertyListEncoder = PropertyListEncoder()
        if let eventEncoded = try? propertyListEncoder.encode(events)
        {
            try? eventEncoded.write(to: archiveURL, options: .noFileProtection)
        }
        
    }
        
    
  
    
}
