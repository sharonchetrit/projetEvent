//
//  CurrentTableViewCell.swift
//  ProjetEvent
//
//  Created by David Mamou on 9/01/18.
//  Copyright © 2018 Sharon Chetrit. All rights reserved.
//

import UIKit

class CurrentTableViewCell: UITableViewCell {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDeparture: UILabel!
    @IBOutlet weak var lblArrival: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    
    func updateWithEvent(event: Event)
    {
        self.lblName.text = event.name
        self.lblDeparture.text = event.depart
        self.lblArrival.text = event.arrive
        self.lblDescription.text = event.eventDescription
    }

    
}
