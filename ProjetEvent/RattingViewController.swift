//
//  RattingViewController.swift
//  ProjetEvent
//
//  Created by Sharon Chetrit on 03/01/2018.
//  Copyright © 2018 Sharon Chetrit. All rights reserved.
//

import UIKit



class RattingViewController: BaseViewController {

    
    
    @IBAction func menu(_ sender: Any) {
        self.viewDeckController?.open(.left, animated: true)
        
        self.dismiss(animated: true, completion: nil)
    }
    
   
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if #available(iOS 10.3, *) {
            SKStoreReviewController.requestReview()
        } else {
            
        }
        
    }

}
