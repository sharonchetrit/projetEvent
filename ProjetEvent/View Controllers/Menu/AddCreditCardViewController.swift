//
//  AddCreditCardViewController.swift
//  ProjetEvent
//
//  Created by Sharon Chetrit on 22/01/2018.
//  Copyright © 2018 Sharon Chetrit. All rights reserved.
//

import UIKit


    
    class AddCreditCardViewController: BaseViewController,UITextFieldDelegate {
        
        weak var creditcard : CreditCard?
        @IBOutlet weak var navBar: UINavigationBar!
        
        @IBOutlet weak var nameTxtfield: UITextField!
        @IBOutlet weak var numberTxtfield: UITextField!
        @IBOutlet weak var dateTxtfield: UITextField!
        @IBOutlet weak var cryptoTxtfield: UITextField!
        
}
        

