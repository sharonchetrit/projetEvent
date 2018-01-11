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
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let shareAction = UITableViewRowAction(style: .destructive, title: "Share") { (action, index) in
            print("saved action pressed")
            let event : Event = self.events[indexPath.row]
            let activityVC = UIActivityViewController(activityItems: ["\(event.name)"], applicationActivities: nil)
            activityVC.popoverPresentationController?.sourceView = self.view
            self.present(activityVC, animated: true, completion: nil)
        }
        shareAction.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (action, index) in
            self.events.remove(at: indexPath.row)
            
            Event.saveOnUserDefaults(events: self.events)
            
            self.tableView.deleteRows(at: [indexPath], with: .fade)
        }
        
        let editAction = UITableViewRowAction(style: .normal, title: "Edit") { (action, index) in
            
            let event : Event = self.events[indexPath.row]
                        
            self.performSegue(withIdentifier: "AddEventSegway", sender: event)
        }
        
        return [deleteAction, shareAction, editAction]
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let event : Event = self.events[indexPath.row]
        
        self.tableView.deselectRow(at: indexPath, animated: false)
        
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
