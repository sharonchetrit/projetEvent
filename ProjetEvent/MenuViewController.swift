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

class MenuViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func share(_ sender: FBSDKShareButton)
    {
        // Example content. Replace with content from your app.
//        FBSDKShareLinkContent *content = [[FBSDKShareLinkContent alloc] init];
//        content.contentURL = [NSURL URLWithString:@"https://developers.facebook.com"];
//
//        FBSDKShareDialog *dialog = [[FBSDKShareDialog alloc] init];
//        dialog.fromViewController = self;
//        dialog.content = content;
//        dialog.mode = FBSDKShareDialogModeShareSheet;
//        [dialog show];
        
        let content = FBSDKShareLinkContent()
        content.contentURL = URL(string: "https://sharonchetrit.wixsite.com/event")
        
        let dialog: FBSDKShareDialog = FBSDKShareDialog()
        dialog.fromViewController = self
        dialog.shareContent = content
        dialog.mode = .shareSheet
        dialog.show()
        
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
