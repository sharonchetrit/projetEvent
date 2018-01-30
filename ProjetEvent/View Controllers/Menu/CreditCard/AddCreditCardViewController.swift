//
//  AddCreditCardViewController.swift
//  ProjetEvent
//
//  Created by Sharon Chetrit on 22/01/2018.
//  Copyright © 2018 Sharon Chetrit. All rights reserved.
//

import UIKit

protocol AddCreditCardDelegate : NSObjectProtocol // MUST inherit from NSObjectProtocol
{
    func addCreditCard(creditcard: CreditCard)
    func updateCreditCard(creditcard: CreditCard)
}
    
class AddCreditCardViewController: FormCreditCardViewController
{
    
    weak var delegate : AddCreditCardDelegate?

    @IBAction func back(_ sender: Any)
    {
            self.navigationController?.popViewController(animated: true)
      
    }
        
    @IBAction override func save(_ sender: Any?)
    {
        guard let name : String = self.nameTxtfield.text,
            let number : String = self.numberTxtfield.text,
            let date : String = self.dateTxtfield.text,
            let cryptograme : String = self.cryptoTxtfield.text
            else {
                return
        }
        
    
        
        let creditcard = CreditCard(name: name, number: number, date: date, cryptogram: cryptograme)
        
        self.delegate?.addCreditCard(creditcard: creditcard)
        
        self.navigationController?.popViewController(animated: true)
//        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func saveMe(_ sender: Any)
    {
        if let name : String = self.nameTxtfield.text
        {
            if let number : String = self.numberTxtfield.text
            {
                if let date : String = self.dateTxtfield.text
                {
                    if let crypto = self.cryptoTxtfield.text
                    {
                        if let creditCard = self.creditcard
                        {
                            creditCard.name = name
                            creditCard.number = number
                            creditCard.date = date
                            creditCard.cryptogram = crypto
                            
                            self.delegate?.updateCreditCard(creditcard: creditCard)
                        }
                        else
                        {
                            let creditCard = CreditCard(name: name, number: number, date: date, cryptogram: crypto)
                            
                            self.delegate?.addCreditCard(creditcard: creditCard)
                        }
                        
                        
                        do {
                            
                        }
                    }
                }
            }
        }
        navigationController?.popViewController(animated: true)
    }
    @IBAction override func textEditingChanged(_ sender: UITextField) {
        updateSaveButtonState()
    }
} 
