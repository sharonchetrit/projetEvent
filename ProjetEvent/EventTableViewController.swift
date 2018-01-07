//
//  EventTableViewController.swift
//  ProjetEvent
//
//  Created by David Mamou on 7/01/18.
//  Copyright © 2018 Sharon Chetrit. All rights reserved.
//

import UIKit

class EventTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    @IBAction func menu(_ sender: Any)
    {
        self.viewDeckController?.open(.left, animated: true)
    }
    

}
