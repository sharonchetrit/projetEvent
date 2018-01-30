//
//  CreditCardTableViewCell.swift
//  ProjetEvent
//
//  Created by Sharon Chetrit on 22/01/2018.
//  Copyright © 2018 Sharon Chetrit. All rights reserved.
//

import UIKit

class CreditCardTableViewCell: UITableViewCell {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblNumber: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblCryptogram: UILabel!
    
    func updateWithCreditCard(creditcard: CreditCard) {
        self.lblName.text = creditcard.name
        self.lblNumber.text = String(creditcard.number)
        self.lblDate.text = creditcard.date
        self.lblCryptogram.text = String(creditcard.cryptogram)
    }
}
