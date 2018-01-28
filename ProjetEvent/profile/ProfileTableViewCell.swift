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
    @IBOutlet weak var lblMail: UILabel!
    @IBOutlet weak var lblTel: UILabel!
    
    
    @IBAction func editProfile(_ sender: Any)
    {
        
    }
    
    override func updateOnMenuItem(_ menuItem: MenuItem)
    {
        if let image = User.sharedInstance()?.profileImage
        {
            self.profileImageView.image = image
        }
        
        self.lblName.text = User.sharedInstance()?.name
        self.lblLastName.text = User.sharedInstance()?.surname
        self.lblMail.text = User.sharedInstance()?.email
        self.lblTel.text = User.sharedInstance()?.phone
        
        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
        profileImageView.clipsToBounds = true
    }
    
   
}
