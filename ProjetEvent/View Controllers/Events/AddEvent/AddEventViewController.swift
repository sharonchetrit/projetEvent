//
//  AddEventViewController.swift
//  ProjetEvent
//
//  Created by David Mamou on 7/01/18.
//  Copyright © 2018 Sharon Chetrit. All rights reserved.
//

import UIKit

protocol AddEventDelegate : NSObjectProtocol // MUST inherit from NSObjectProtocol
{
    func addEvent(event: Event)
    func updateEvent(event: Event)
}

class AddEventViewController: BaseViewController, UITextFieldDelegate {
    
    weak var event : Event?
    
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var txtFieldEvent: UITextField!
    @IBOutlet weak var txtFieldDepart: UITextField!
    @IBOutlet weak var txtFieldArrive: UITextField!
    @IBOutlet weak var txtFieldDescription: UITextField!
    
    weak var delegate : AddEventDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let event = event
        {
            self.navBar.topItem?.title = event.name
            txtFieldEvent.text = event.name
            txtFieldDepart.text = event.depart
            txtFieldArrive.text = event.arrive
            txtFieldDescription.text = event.eventDescription
        }
        updateSaveButtonState()
        
    }
    
    @IBAction func cancel(_ sender: Any?)
    {
        self.dismiss(animated: true)
    }
    
    
    @IBAction  func save(_ sender: Any?)
    {
        if let eventCharacter : String = self.txtFieldEvent.text
        {
            if let depart : String = self.txtFieldDepart.text
            {
                if let arrive : String = self.txtFieldArrive.text
                {
                    if let description = self.txtFieldDescription.text
                    {
                        if let event = self.event
                        {
                            event.name = eventCharacter
                            event.depart = depart
                            event.arrive = arrive
                            event.eventDescription = description
                            
                            self.delegate?.updateEvent(event: event)
                        }
                        else
                        {
                            let event = Event(name: eventCharacter, depart: depart, arrive: arrive, eventDescription: description)
                            
                            self.delegate?.addEvent(event: event)
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
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //Format Date of Birth dd-MM-yyyy
        
        //initially identify your textfield
        
        if textField == txtFieldDepart {
            
            // check the chars length dd -->2 at the same time calculate the dd-MM --> 5
            if (txtFieldDepart?.text?.count == 2) || (txtFieldDepart?.text?.count == 5) {
                //Handle backspace being pressed
                if !(string == "") {
                    // append the text
                    txtFieldDepart?.text = (txtFieldDepart?.text)! + "-"
                }
            }
            // check the condition not exceed 9 chars
            return !(textField.text!.count > 9 && (string.count ) > range.length)
        }
        if textField == txtFieldArrive {
            
            // check the chars length dd -->2 at the same time calculate the dd-MM --> 5
            if (txtFieldArrive?.text?.count == 2) || (txtFieldArrive?.text?.count == 5) {
                //Handle backspace being pressed
                if !(string == "") {
                    // append the text
                    txtFieldArrive?.text = (txtFieldArrive?.text)! + "-"
                }
            }
            // check the condition not exceed 9 chars
            return !(textField.text!.count > 9 && (string.count ) > range.length)
        }
            
        else {
            return true
        }
        
    }
    
    @IBAction func textEditingChanged(_ sender: UITextField) {
        updateSaveButtonState()
    }

    @IBOutlet weak var saveButton: UIBarButtonItem! // declaration of saveButton
    
    
    func updateSaveButtonState() {
        // Save button is enabled when txtsFields are empty
        let arrive = txtFieldArrive.text ?? ""
        let Event = txtFieldEvent.text ?? ""
        let desc = txtFieldDescription.text ?? ""
        let depart = txtFieldDepart.text ?? ""
        
        saveButton.isEnabled = !arrive.isEmpty && !Event.isEmpty && !desc.isEmpty && !depart.isEmpty
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        guard segue.identifier == "saveUnwind" else { return }
        
        let name = txtFieldEvent.text ?? ""
        let depart = txtFieldDepart.text ?? ""
        let desc = txtFieldDescription.text ?? ""
        let arrive = txtFieldArrive.text ?? ""
        
        event = Event(name: name, depart: depart, arrive: arrive, eventDescription: desc)
    }
    
}
