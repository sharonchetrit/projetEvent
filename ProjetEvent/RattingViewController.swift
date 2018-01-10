//
//  RattingViewController.swift
//  ProjetEvent
//
//  Created by Sharon Chetrit on 03/01/2018.
//  Copyright © 2018 Sharon Chetrit. All rights reserved.
//

import UIKit
import ViewDeck


class RattingViewController: BaseViewController {
    
    

    
    @IBAction func menu(_ sender: Any) {
        self.viewDeckController?.open(.left, animated: true)
    }


}
