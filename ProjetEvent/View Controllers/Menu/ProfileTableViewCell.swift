//
//  ProfileTableViewCell.swift
//  ProjetEvent
//
//  Created by Sharon Chetrit on 14/01/2018.
//  Copyright © 2018 Sharon Chetrit. All rights reserved.
//

import UIKit

class ProfileTableViewCell: MenuItemTableViewCell
{
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var lblLastName: UILabel!
    
    override func updateOnMenuItem(_ menuItem: MenuItem)
    {
        self.profileImageView.image = User.sharedInstance.profileImage
        self.lblName.text = User.sharedInstance.name
        self.lblLastName.text = User.sharedInstance.surname
    }
}
