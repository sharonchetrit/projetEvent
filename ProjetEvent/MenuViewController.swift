//
//  MenuViewController.swift
//  ProjetEvent
//
//  Created by Sharon Chetrit on 03/01/2018.
//  Copyright © 2018 Sharon Chetrit. All rights reserved.
//

import UIKit
import StoreKit
import ViewDeck
import FBSDKShareKit

class MenuViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource
{
    @IBOutlet weak var tblView: UITableView!
    
    let menuItems = MenuItem.loadSampleFromPlist()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tblView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
    }
    
    
    
    
    @IBAction func ratting(_ sender: Any)
    {
        if #available(iOS 10.3, *) {
            SKStoreReviewController.requestReview()
        } else {
            
        }
    }
    
    @IBAction func profile(_ sender: Any)
    {
        if let slideMenuController: ProjectEventDeckController = self.viewDeckController as? ProjectEventDeckController
        {
            slideMenuController.centerViewController = slideMenuController.profileController
            slideMenuController.closeSide(true)
        }
    }
    
    @IBAction func events(_ sender: Any)
    {
        if let slideMenuController: ProjectEventDeckController = self.viewDeckController as? ProjectEventDeckController
        {
            slideMenuController.centerViewController = slideMenuController.eventController
            slideMenuController.closeSide(true)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.menuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let menuItem = self.menuItems[indexPath.row]
        
        cell.textLabel?.text = menuItem.title
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let menuItem = self.menuItems[indexPath.row]
        
        self.perform(menuItem.selector, with: nil)
        
    }
    
}
