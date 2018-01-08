//
//  MenuViewController.swift
//  ProjetEvent
//
//  Created by Sharon Chetrit on 03/01/2018.
//  Copyright © 2018 Sharon Chetrit. All rights reserved.
//

import UIKit
import StoreKit

class MenuViewController: BaseViewController {

    @IBAction func share(_ sender: UIButton)
    {
        self.performSegue(withIdentifier: "shareSegue", sender: nil)
    }
    
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
