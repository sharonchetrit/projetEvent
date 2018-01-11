//
//  Event.swift
//  ProjetEvent
//
//  Created by David Mamou on 4/01/18.
//  Copyright © 2018 Sharon Chetrit. All rights reserved.
//

import UIKit

class Event: NSObject, NSCoding
{

    var name : String
    var depart : String
    var arrive : String
    var eventDescription : String
    
    static let DocumentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("events")
    
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

    
    
    func serialize() -> Dictionary<String,Any>
    {
        var dict : Dictionary<String,Any> = Dictionary()
        
        dict["name"] = self.name
        dict["depart"] = self.depart
        dict["arrive"] = self.arrive
        dict["eventDescription"] = self.eventDescription
        
        return dict
    }
    
    static func loadFromFile() -> Array<Event>?
    {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Event.ArchiveURL.path) as? [Event]
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
    
    
    
    static func loadEventSample() -> Array<Event>
    {
        let sampleEvents = [
            Event(name: "Anniversaire", depart: "14-11-2018", arrive: "17-11-1998", eventDescription: "restaurant"),
            ]
        
        return sampleEvents
        
    }
    
    static func saveToFile(events:Array<Event> )
    {
        NSKeyedArchiver.archiveRootObject(events, toFile: Event.ArchiveURL.path)
        
    }
        
    static func openFromUserDefaults() -> [Event]?
    {
        var sampleEvents : [Event] = []
        
        if let eventDicts : [Dictionary<String,Any>] = UserDefaults.standard.object(forKey: "Event") as? [Dictionary<String, Any>]
        {
            for dict in eventDicts
            {
                let event : Event = Event(dictionary: dict)
                sampleEvents.append(event)
            }
        }
        else
        {
            return nil
        }
        
        return sampleEvents
        
    }
    
    static func saveOnUserDefaults(events: [Event] )
    {
        // serialize
        
        var eventDicts : [Dictionary<String,Any>] = []
        
        for event : Event in events
        {
            eventDicts.append(event.serialize())
        }
        
        UserDefaults.standard.set(eventDicts, forKey: "Event")
    }
    
    required convenience init?(coder aDecoder: NSCoder)
    {
        guard let name = aDecoder.decodeObject(forKey: "name") as? String,
            let depart = aDecoder.decodeObject(forKey: "depart") as? String,
            let arrive = aDecoder.decodeObject(forKey: "arrive") as? String,
            let eventDescription = aDecoder.decodeObject(forKey: "eventDescription") as? String
            else {
                return nil
        }
        
        self.init(name: name, depart: depart, arrive: arrive, eventDescription: eventDescription)
    }
    func encode(with aCoder: NSCoder) {
        
        aCoder.encode(name, forKey: "name")
        aCoder.encode(depart, forKey: "depart")
        aCoder.encode(arrive, forKey: "arrive")
        aCoder.encode(eventDescription, forKey: "eventDescription")
    }
    
}
