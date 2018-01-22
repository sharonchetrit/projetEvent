//
//  AddCreditCardViewController.swift
//  ProjetEvent
//
//  Created by David Mamou on 21/01/18.
//  Copyright © 2018 Sharon Chetrit. All rights reserved.
//

import UIKit

protocol AddCreditCardtDelegate : NSObjectProtocol // MUST inherit from NSObjectProtocol
{
    func addCreditCard(creditCard: CreditCard)
    func updateCreditCard(creditCard: CreditCard)
}

class AddCreditCardViewController: BaseViewController,UITextFieldDelegate {

    
        
        weak var creditCard : CreditCard?
        @IBOutlet weak var navBar: UINavigationBar!
        
    @IBOutlet weak var txtFieldName: UITextField!
    
    @IBOutlet weak var txtFieldNumeroCard: UITextField!
    
    @IBOutlet weak var txtFieldCvv: UITextField!
    
    @IBOutlet weak var txtFieldExpiration: UITextField!
    
    
        
//        let datepicker = UIDatePicker()
//
//        func createDatePicker(){
//
//            datepicker.datePickerMode = .date
//
//
//            let toolBar = UIToolbar()
//            toolBar.sizeToFit()
//
//            let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(buttonPressed))
//            toolBar.setItems([doneButton], animated: false)
//
//            txtFieldExpiration.inputAccessoryView = toolBar
//            txtFieldExpiration.inputView = datepicker
//
//            
//        }
//
//        @objc func buttonPressed() {
//
//            let dateFormatteur = DateFormatter()
//            dateFormatteur.dateStyle = .short
//            dateFormatteur.timeStyle = .none
//            txtFieldExpiration.text = dateFormatteur.string(from: datepicker.date)
//            self.view.endEditing(true)
//
//        }
        weak var delegate : AddCreditCardtDelegate?
        
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            if let creditCard = creditCard
            {
                self.navBar.topItem?.title = creditCard.name
                txtFieldName.text = creditCard.name
                txtFieldNumeroCard.text = creditCard.numeroCard
                txtFieldCvv.text = creditCard.cvv
                txtFieldExpiration.text = creditCard.expiration
            }
            updateSaveButtonState()
//            createDatePicker()
            
        }
        
        
        
        
        @IBAction func cancel(_ sender: Any?)
        {
            
            self.dismiss(animated: true)
        }
        
    
        
        
        
        @IBAction  func save(_ sender: Any?)
        {
            if let name : String = self.txtFieldName.text
            {
                if let numCard : String = self.txtFieldNumeroCard.text
                {
                    if let cvv : String = self.txtFieldCvv.text
                    {
                        if let expiration = self.txtFieldExpiration.text
                        {
                            if let creditCard = self.creditCard
                            {
                                creditCard.name = name
                                creditCard.numeroCard = numCard
                                creditCard.cvv = cvv
                                creditCard.expiration = expiration

                                self.delegate?.updateCreditCard(creditCard: creditCard)
                            }
                            else
                            {
                                let creditCard = CreditCard(name: name, numeroCard: numCard, cvv: cvv, expiration: expiration)

                                self.delegate?.addCreditCard(creditCard: creditCard)
                            }


                            self.dismiss(animated: true) {

                            }
                        }
                    }
                }
            }
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

    
        @IBAction func textEditingChanged(_ sender: UITextField) {
            updateSaveButtonState()
        }
        
        
        
        
        @IBOutlet weak var saveButton: UIBarButtonItem! // declaration of saveButton
        
        
        func updateSaveButtonState() {
            // Save button is enabled when txtsFields are empty
            let name = txtFieldName.text ?? ""
            let numcard = String(describing: txtFieldNumeroCard.text) ?? ""
            let cvv = String(describing: txtFieldCvv.text) ?? ""
            let expiration = txtFieldExpiration.text ?? ""
            
            saveButton.isEnabled = !name.isEmpty && !numcard.isEmpty && !cvv.isEmpty && !expiration.isEmpty
            
        }
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            
            super.prepare(for: segue, sender: sender)
            
            guard segue.identifier == "saveUnwind" else { return }
            
            let name = txtFieldName.text ?? ""
            let numcard = txtFieldNumeroCard.text! ?? ""
            let cvv = txtFieldCvv.text ?? ""
            let expiration = txtFieldExpiration.text ?? ""
            
            creditCard = CreditCard(name: name, numeroCard: numcard, cvv: cvv, expiration: expiration)
        }
        
        
        
    }


