//
//  ShareViewController.swift
//  ProjetEvent
//
//  Created by Sharon Chetrit on 03/01/2018.
//  Copyright © 2018 Sharon Chetrit. All rights reserved.
//

import UIKit
import MessageUI



class ShareViewController: BaseViewController, UINavigationControllerDelegate {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBOutlet weak var shareFB: FBSDKShareButton!
    
    @IBOutlet weak var sharebtn: UIButton!
    
    
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
        
        let subject = "Share my app"
        let body = "Please download this app here \(url)"
        
       mailVC.setSubject(subject)
       mailVC.setMessageBody(body, isHTML: false)
        
        self.present(mailVC, animated: true, completion: { () in
            print("Done🔨") })
    }
}

