//
//  EventViewController.swift
//  ProjetEvent
//
//  Created by David Mamou on 3/01/18.
//  Copyright © 2018 Sharon Chetrit. All rights reserved.
//

import UIKit

class EventViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource,AddEventDelegate
{
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    lazy var events : [Event] = {
        if let userDefaultEvents = Event.openFromUserDefaults()
        {
            return userDefaultEvents
        }
        
        return Event.loadSampleFromPlist()
    }()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        self.tableView.register(UINib(nibName: "CurrentTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "Cell")
        tableView.reloadData()
    }
    
    @IBAction func menu(_ sender: Any)
    {
        self.viewDeckController?.open(.left, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.events.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : CurrentTableViewCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CurrentTableViewCell
        
        let event : Event = self.events[indexPath.row]
        
        cell.updateWithEvent(event: event)
        cell.showsReorderControl = true
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let event : Event = self.events[indexPath.row]
        
        self.performSegue(withIdentifier: "AddEventSegway", sender: event)
    }
    
    @IBAction func addEvent(_ sender: Any)
    {
        self.performSegue(withIdentifier: "AddEventSegway", sender: nil)
    }
    
    func addEvent(event: Event)
    {
        // save the data here
        
        self.events.append(event)
        
        Event.saveOnUserDefaults(events: self.events)
        
        self.tableView.reloadData()
    }
    
    func updateEvent(event: Event)
    {
        self.events[(self.tableView.indexPathForSelectedRow?.row)!] = event
        
        Event.saveOnUserDefaults(events: self.events)
        
        self.tableView.reloadData()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let addVC : AddEventViewController = segue.destination as? AddEventViewController
        {
            addVC.delegate = self
            addVC.event = sender as? Event
        }
    }
    
    
    
}
