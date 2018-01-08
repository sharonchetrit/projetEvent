//
//  MenuViewController.swift
//  ProjetEvent
//
//  Created by Sharon Chetrit on 03/01/2018.
//  Copyright © 2018 Sharon Chetrit. All rights reserved.
//

import UIKit
import StoreKit
import ShareKit

class MenuViewController: BaseViewController {

    @IBAction func share(_ sender: UIButton)
    {
//        self.performSegue(withIdentifier: "shareSegue", sender: nil)
        // Create the item to share (in this example, a url)
//        NSURL *url = [NSURL URLWithString:@"http://getsharekit.com"];
//        SHKItem *item = [SHKItem URL:url title:@"ShareKit is Awesome!" contentType:SHKURLContentTypeWebpage];
//
//        // Get the ShareKit action sheet
//        SHKActionSheet *actionSheet = [SHKActionSheet actionSheetForItem:item];
//
//        // ShareKit detects top view controller (the one intended to present ShareKit UI) automatically,
//        // but sometimes it may not find one. To be safe, set it explicitly
//        [SHK setRootViewController:self];
//
//        // Display the action sheet
//        SHKAlertController *alertController = [SHKAlertController actionSheetForItem:item];
//        [alertController setModalPresentationStyle:UIModalPresentationPopover];
//        UIPopoverPresentationController *popPresenter = [alertController popoverPresentationController];
//        popPresenter.barButtonItem = self.toolbarItems[1];
//        [self presentViewController:alertController animated:YES completion:nil];
        
        let url : URL = URL(string: "https://developers.institute/")!
        let item : SHKItem = SHKItem.url(url, title: "Developers Institute is awesome!", contentType: SHKURLContentTypeWebpage) as! SHKItem
        
        let actionSheet : SHKAlertController = SHKAlertController.actionSheet(for: item)
        
        self.present(actionSheet, animated: true, completion: nil)
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
