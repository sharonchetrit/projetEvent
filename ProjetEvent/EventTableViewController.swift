//
//  EventTableViewController.swift
//  ProjetEvent
//
//  Created by David Mamou on 7/01/18.
//  Copyright © 2018 Sharon Chetrit. All rights reserved.
//

import UIKit

class EventTableViewController: UITableViewController {

    var events: [Event] = Array<Event>()
    
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.leftBarButtonItem = self.editButtonItem
        
        
        if let events = Event.loadFromFile(){
            self.events = events
        }else{
            self.events = Event.loadEventSample()
        }
    }

    @IBAction func menu(_ sender: Any)
    {
        self.viewDeckController?.open(.left, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath)
    {
        /*
         how to do this:
         we are modifying the DATA object "emojis", then reloading the data into the
         table
         */
        let movedEvent = events.remove(at: fromIndexPath.row)
        events.insert(movedEvent, at: to.row)
        
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            events.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
            Event.saveToFile(events:self.events)
        }
    }
    

}
