//
//  CreditCardTableViewController.swift
//  ProjetEvent
//
//  Created by Sharon Chetrit on 21/01/2018.
//  Copyright © 2018 Sharon Chetrit. All rights reserved.
//

import UIKit

class CreditCardTableViewController: UITableViewController {
    
    var creditCards: [CreditCard] = Array<CreditCard>()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .delete 
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            creditCards.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
            CreditCard.saveToFile(creditCards:self.creditCards)
        }
    }

}
