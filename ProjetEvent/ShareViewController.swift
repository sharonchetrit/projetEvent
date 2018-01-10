//
//  ShareViewController.swift
//  ProjetEvent
//
//  Created by Sharon Chetrit on 03/01/2018.
//  Copyright © 2018 Sharon Chetrit. All rights reserved.
//

import UIKit
import MessageUI


class ShareViewController: BaseViewController {
    

    @IBAction func share(_ sender: FBSDKShareButton)
    {
        
        
        let content = FBSDKShareLinkContent()
        content.contentURL = URL(string: "https://sharonchetrit.wixsite.com/event")
        
        let dialog: FBSDKShareDialog = FBSDKShareDialog()
        dialog.fromViewController = self
        dialog.shareContent = content
        dialog.mode = .shareSheet
        dialog.show()
        
    }
    
    
    @IBAction func menu(_ sender: Any) {
//        self.viewDeckController?.open(.left, animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    
   
    @IBAction func shareToEmail(_ sender: Any) {
        guard MFMailComposeViewController.canSendMail() else {
            return
        }
        let mailVC: MFMailComposeViewController = MFMailComposeViewController()
        
        
        var url : String = "https://itunes.apple.com/us/app/whatsapp-messenger/id310633997?mt=8"
        
       var subject = "Share my app"
        var body = "Please download this app here \(url)"
        
       mailVC.setSubject(subject)
       mailVC.setMessageBody(body, isHTML: false)
        
        self.present(mailVC, animated: true, completion: { () in
            print("Done🔨") })
    }
}
