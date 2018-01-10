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
    
    
    @IBOutlet weak var shareBtn: FBSDKShareButton!
    
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
        func viewDidLoad() {
            super.viewDidLoad()
            let content = FBSDKShareLinkContent()
            content.contentURL = URL(string: "https://www.facebook.com/FacebookDevelopers")
            let shareButton = FBSDKShareButton()
            shareButton.shareContent = content
            shareButton.center = view.center
            view.addSubview(shareButton as? UIView ?? UIView())
        }
        
        var contentURL = URL(string: "https://www.facebook.com")
        var imageURL = URL(string: "http://upload.wikimedia.org/wikipedia/commons/thumb/9/95/Facebook_Headquarters_Menlo_Park.jpg/2880px-Facebook_Headquarters_Menlo_Park.jpg")
        shareBtn.shareContent = FBSDKShareLinkContent(contentURL: contentURL, contentTitle: "My Share Title", contentDescription: "Lorem ipsum dolor sit amet.", imageURL: imageURL, peopleIDs: ["1561082740838259"], placeID: "166793820034304", ref: "myRefId")
        
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
