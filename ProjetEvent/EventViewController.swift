//
//  EventViewController.swift
//  ProjetEvent
//
//  Created by David Mamou on 3/01/18.
//  Copyright © 2018 Sharon Chetrit. All rights reserved.
//

import UIKit

class EventViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource
{
    
    @IBOutlet weak var tableView: UITableView!
    
    var events : [Event] = Event.loadSampleFromPlist()
    
    
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
    
    @IBAction func addEvent(_ sender: Any)
    {
        self.performSegue(withIdentifier: "AddEventSegway", sender: nil)
    }
    
    
    
    
    
    
}
