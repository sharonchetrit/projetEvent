//
//  EventViewController.swift
//  ProjetEvent
//
//  Created by David Mamou on 3/01/18.
//  Copyright © 2018 Sharon Chetrit. All rights reserved.
//

import UIKit

class EventViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.register(UINib(nibName: "DetailTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "Cell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
