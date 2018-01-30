//
//  FormCreditCardViewController.swift
//  ProjetEvent
//
//  Created by Sharon Chetrit on 22/01/2018.
//  Copyright © 2018 Sharon Chetrit. All rights reserved.
//

import UIKit


class FormCreditCardViewController: BaseViewController, UITextFieldDelegate {
    
    
    weak var creditcard : CreditCard?
    
    @IBOutlet weak var navigBar: UINavigationBar!
    
    @IBOutlet weak var saveMe: UIBarButtonItem!
    
    @IBOutlet weak var nameTxtfield: UITextField!
    @IBOutlet weak var numberTxtfield: UITextField!
    @IBOutlet weak var dateTxtfield: UITextField!
    @IBOutlet weak var cryptoTxtfield: UITextField!
    
    
    
    @IBAction func textEditingChanged(_ sender : UITextField)
    {
        updateSaveButtonState()
    }
    
    func updateSaveButtonState() {
        // Save button is enabled when txtsFields are empty
        let name = nameTxtfield.text ?? ""
        let number = numberTxtfield.text ?? ""
        let date = dateTxtfield.text ?? ""
        let cryptogram = cryptoTxtfield.text ?? ""
        
        saveMe.isEnabled = !name.isEmpty && !number.isEmpty && !date.isEmpty && !cryptogram.isEmpty
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let creditCard = creditcard
        {
            self.navigBar.topItem?.title = creditCard.name
            nameTxtfield.text = creditcard?.name
            numberTxtfield.text = creditcard?.number
            dateTxtfield.text = creditcard?.date
            cryptoTxtfield.text = creditcard?.cryptogram
        }
        
        updateSaveButtonState()
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        if textField == self.cryptoTxtfield && string != "" // if deleting
        {
            if let v = textField.text?.count, v >= 3
            {
                return false
            }
            
        }
        else if textField == dateTxtfield {
            
            // check the chars length dd -->2 at the same time calculate the dd-MM --> 5
            if (dateTxtfield?.text?.count == 2) //|| (dateTxtfield?.text?.characters.count == 5)
            {
                //Handle backspace being pressed
                if !(string == "") {
                    // append the text
                    dateTxtfield?.text = (dateTxtfield?.text)! + "-"
                }
            }
            // check the condition not exceed 9 chars
            return !(textField.text!.count > 4 && (string.count ) > range.length)
        }
        
        else if textField == numberTxtfield {
            
            // check the chars length dd -->2 at the same time calculate the dd-MM --> 5
            if (numberTxtfield?.text?.count == 4) || (numberTxtfield?.text?.count == 9) || (numberTxtfield?.text?.count == 14)
            {
                //Handle backspace being pressed
                if !(string == "") {
                    // append the text
                    numberTxtfield?.text = (numberTxtfield?.text)! + "-"
                }
            }
            // check the condition not exceed 9 chars
            return !(textField.text!.count > 18 && (string.count ) > range.length)
        }
        
        return true
    }
   
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if let linkedTextField : LinkedTextField = textField as? LinkedTextField
        {
            if( linkedTextField.nextField != nil )
            {
                linkedTextField.nextField?.becomeFirstResponder()
            }
            else
            {
                linkedTextField.resignFirstResponder()
                self.save(nil)
            }
        }
        
        return true
    }
    
    @IBAction func save(_ sender : Any? )
    {
        
    }
}

