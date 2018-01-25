//
//  BaseViewController.swift
//  CaseStudy
//
//  Created by Eric Shorr on 22/11/2017.
//  Copyright © 2017 Developer Institute. All rights reserved.
//

import UIKit
import CoreData
import FacebookShare
import FBSDKShareKit

class BaseViewController: UIViewController {
    
    @IBOutlet weak var mainView:UIView!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // loading xib file of the subclass's name and then adding it to self.view from self.mainView
        
        let mainBundle = Bundle.main // the packet of all of the information inside the application such as the storyboard, xibs, pictures, and other multimedia.
        
        if let nibName:String = NSStringFromClass(type(of: self)).components(separatedBy: ".").last
            /* name was originally "CaseStudy.ViewController" -> components(seperatedBy: ".") = ["CaseStudy","ViewController"] -> components(seperatedBy:".").last == "ViewController"
             */
        {
            print(nibName) // printing the sanitized name
            
            mainBundle.loadNibNamed(nibName, owner: self, options: nil) // loading the xib file
            
            if( self.mainView != nil )
            {
                self.mainView.autoresizingMask = UIViewAutoresizing(rawValue: UIViewAutoresizing.RawValue(UInt8(UIViewAutoresizing.flexibleWidth.rawValue) | UInt8(UIViewAutoresizing.flexibleHeight.rawValue)))
                
                self.mainView.frame = self.view.bounds
                
                self.view.addSubview(self.mainView)
            }
        }
    }
    
    @IBAction func share(_ sender: Any?)
    {
        
        let content = FBSDKShareLinkContent()
        content.contentURL = URL(string: "https://sharonchetrit.wixsite.com/event")
        
        let dialog: FBSDKShareDialog = FBSDKShareDialog()
        dialog.fromViewController = self
        dialog.shareContent = content
        dialog.mode = .shareSheet
        dialog.show()
        
    }

}
