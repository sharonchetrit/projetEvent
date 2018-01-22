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

class AddEventViewController: BaseViewController,UITextFieldDelegate {
    
    weak var event : Event?
    @IBOutlet weak var navBar: UINavigationBar!
    
    @IBOutlet weak var txtFieldEvent: UITextField!
    @IBOutlet weak var txtFieldDepart: UITextField!
    @IBOutlet weak var txtFieldArrive: UITextField!
    @IBOutlet weak var txtFieldDescription: UITextField!
    
    let datepicker = UIDatePicker()
    let datepicker2 = UIDatePicker()
    
    func createDatePicker(){
        
        datepicker.datePickerMode = .date
        datepicker2.datePickerMode = .date
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(buttonPressed))
        toolBar.setItems([doneButton], animated: false)
        
        txtFieldDepart.inputAccessoryView = toolBar
        txtFieldDepart.inputView = datepicker
        
        txtFieldArrive.inputAccessoryView = toolBar
        txtFieldArrive.inputView = datepicker2
    }
    
    @objc func buttonPressed() {
        
        let dateFormatteur = DateFormatter()
        dateFormatteur.dateStyle = .short
        dateFormatteur.timeStyle = .none
        txtFieldDepart.text = dateFormatteur.string(from: datepicker.date)
        self.view.endEditing(true)
        

//        var endDate = dateFormatteur.calendar.date(byAdding: .day, value: 1, to: datepicker.date)
        txtFieldArrive.text = dateFormatteur.string(from: datepicker2.date)
        self.view.endEditing(true)

    }
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
        createDatePicker()
        
    }
    

    
    
    @IBAction func cancel(_ sender: Any?)
    {
        
        self.dismiss(animated: true)
    }
    
//    @IBAction func save(_ sender: Any?)
//    {
//        self.dismiss(animated: true)
//    }
//
    
    
    
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
