//
//  ShareViewController.swift
//  ProjetEvent
//
//  Created by Sharon Chetrit on 03/01/2018.
//  Copyright © 2018 Sharon Chetrit. All rights reserved.
//

import UIKit


class ShareViewController: BaseViewController, UINavigationControllerDelegate {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func menu(_ sender: Any) {
        self.viewDeckController?.open(.left, animated: true)
    }
    
}

