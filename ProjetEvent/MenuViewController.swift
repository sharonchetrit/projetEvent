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

class MenuViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "")
        cell.textLabel?.text = "share"
        
        return cell
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let shareVC = ShareViewController(nibName: "ShareViewController", bundle: Bundle.main)
        
        
        
        switch(indexPath.section, indexPath.row) {
            
        case (0, 0):
            self.present(shareVC, animated: true, completion: { () in
                print("Done🔨") })
       
        default :
            break
        }
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.delegate = self
        tblView.dataSource = self
        
    }
    
    @IBOutlet weak var tblView: UITableView!
    
    
    
    
    @IBAction func ratting(_ sender: Any)
    {
//        self.performSegue(withIdentifier: "ratingSegue", sender: nil)
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
    
}
