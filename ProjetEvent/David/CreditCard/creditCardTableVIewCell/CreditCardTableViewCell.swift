//
//  CreditCardTableViewCell.swift
//  ProjetEvent
//
//  Created by David Mamou on 21/01/18.
//  Copyright © 2018 Sharon Chetrit. All rights reserved.
//

import UIKit

class CreditCardTableViewCell: UITableViewCell {
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblNumeroCard: UILabel!
    @IBOutlet weak var lblCvv: UILabel!
    @IBOutlet weak var lblExpiration: UILabel!
    
    func updateWithCreditCard(creditCard: CreditCard)
    {
        self.lblName.text = creditCard.name
        self.lblNumeroCard.text = String(creditCard.numeroCard)
        self.lblCvv.text = String(creditCard.cvv)
        self.lblExpiration.text = creditCard.expiration
    }

}
