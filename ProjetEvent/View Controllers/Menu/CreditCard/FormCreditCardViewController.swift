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
        updateSaveButtonState()
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        if textField == self.nameTxtfield && string != "" // if deleting
        {
            if let v = textField.text?.count, v >= 1
            {
                return false
            }
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
