//
//  MenuViewController.swift
//  ProjetEvent
//
//  Created by Sharon Chetrit on 03/01/2018.
//  Copyright © 2018 Sharon Chetrit. All rights reserved.
//

import UIKit
import ShareKit

class MenuViewController: BaseViewController {

    @IBAction func share(_ sender: Any)
    {
//        self.performSegue(withIdentifier: "shareSegue", sender: nil)
        
        let url : URL = URL(string: "http://getsharekit.com")!
        
        let item : SHKItem = SHKItem.url(url, title: "ShareKit is awesome", contentType: SHKURLContentTypeWebpage) as! SHKItem
        
        SHK.setRootViewController(self.viewDeckController)
        
        let alertController : SHKAlertController = SHKAlertController.actionSheet(for: item)
        
//        alertController.modalPresentationStyle = .popover
//        
//        let popPresent : UIPopoverPresentationController = alertController.popoverPresentationController()
//        
//        popPresent.barButtonItem = sender
        
        self.present(alertController, animated: true, completion: nil)
        
        
//        // Create the item to share (in this example, a url)
//        NSURL *url = [NSURL URLWithString:@"http://getsharekit.com"];
//        SHKItem *item = [SHKItem URL:url title:@"ShareKit is Awesome!" contentType:SHKURLContentTypeWebpage];
//
//        // ShareKit detects top view controller (the one intended to present ShareKit UI) automatically,
//        // but sometimes it may not find one. To be safe, set it explicitly
//        [SHK setRootViewController:self];
//
//        // Display the action sheet
//        if (NSClassFromString(@"UIAlertController")) {
//
//            //iOS 8+
//            SHKAlertController *alertController = [SHKAlertController actionSheetForItem:item];
//            [alertController setModalPresentationStyle:UIModalPresentationPopover];
//            UIPopoverPresentationController *popPresenter = [alertController popoverPresentationController];
//            popPresenter.barButtonItem = self.toolbarItems[1];
//            [self presentViewController:alertController animated:YES completion:nil];
//
//        } else {
//
//            //deprecated
//            SHKActionSheet *actionSheet = [SHKActionSheet actionSheetForItem:item];
//            [actionSheet showFromToolbar:self.navigationController.toolbar];
//        }
    }
    
    @IBAction func ratting(_ sender: Any)
    {
        self.performSegue(withIdentifier: "ratingSegue", sender: nil)
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
