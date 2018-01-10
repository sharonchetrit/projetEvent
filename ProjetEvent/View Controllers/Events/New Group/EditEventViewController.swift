//
//  EditEventViewController.swift
//  ProjetEvent
//
//  Created by David Mamou on 10/01/18.
//  Copyright © 2018 Sharon Chetrit. All rights reserved.
//

import UIKit
protocol EditEventDelegate : NSObjectProtocol // MUST inherit from NSObjectProtocol
{
    func editEmoji(event: Event)
}
class EditEventViewController: BaseViewController {
    
    weak var delegate : EditEventDelegate?
    
    var event : Event?
    

    @IBOutlet weak var txtFieldEvent: UITextField!
    @IBOutlet weak var txtFieldDepart: UITextField!
    @IBOutlet weak var txtFieldArrive: UITextField!
    @IBOutlet weak var txtFieldDescription: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.txtFieldEvent.text = self.event?.name
        self.txtFieldDepart.text = self.event?.depart
        self.txtFieldArrive.text = self.event?.arrive
        self.txtFieldDescription.text = self.event?.eventDescription
    }
    
    
}
