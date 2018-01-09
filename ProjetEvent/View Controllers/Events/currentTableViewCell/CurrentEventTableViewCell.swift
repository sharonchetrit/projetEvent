//
//  CurrentEventTableViewCell.swift
//  ProjetEvent
//
//  Created by David Mamou on 7/01/18.
//  Copyright © 2018 Sharon Chetrit. All rights reserved.
//

import UIKit

class CurrentEventTableViewCell: UITableViewCell {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblDepart: UILabel!
    @IBOutlet weak var lblArrive: UILabel!
  
    func updateWithEvent(event: Event)
    {
        self.lblName.text = event.name
        self.lblDescription.text = event.eventDescription
        self.lblDepart.text = event.depart
        self.lblArrive.text = event.arrive
        
    }
    
}
