//
//  MenuItemTableViewCell.swift
//  ProjetEvent
//
//  Created by Sharon Chetrit on 14/01/2018.
//  Copyright © 2018 Sharon Chetrit. All rights reserved.
//

import UIKit

class MenuItemTableViewCell: UITableViewCell
{
    @IBOutlet weak var lblTitle: UILabel!
    
    func updateOnMenuItem(_ menuItem : MenuItem )
    {
        self.lblTitle.text = menuItem.title
    }
    
    static func cellHeight() -> Float
    {
        return 44.0
    }
    
}
