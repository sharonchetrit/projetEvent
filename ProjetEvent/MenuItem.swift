//
//  MenuItem.swift
//  SlideMenuExample
//
//  Created by Eric Shorr on 11/01/2018.
//  Copyright © 2018 Developer Institute. All rights reserved.
//

import UIKit

class MenuItem: NSObject
{
    var title : String
    var selector : Selector
    var cellType : String
    
    
    init( json: [String : Any])
    {
        self.title = json["title"] as! String
        self.selector = Selector(json["selector"] as! String)
        self.cellType = json["cellType"] as! String
    }
    
    static func loadSampleFromPlist() -> [MenuItem]
    {
        var menuItem : [MenuItem] = []
        var menuArray : [Any] = []
        
        if let path = Bundle.main.path(forResource: "defaultMenuItems", ofType: "plist")
        {
            menuArray = NSArray(contentsOf: URL(fileURLWithPath: path)) as! [Any] // we get the array from the file here!!!!!!!
        }
        if let array : [Dictionary<String,Any>] = menuArray as? [Dictionary<String, Any>] {
            // Use your dict here
            
            for dict in array
            {
                let newEmoji = MenuItem(json: dict)
                menuItem.append(newEmoji)
            }
        }
        
        return menuItem
    }
}

