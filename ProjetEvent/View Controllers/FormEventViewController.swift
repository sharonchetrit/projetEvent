//
//  FormEmojiViewController.swift
//  EmojiDictionary
//
//  Created by Eric Shorr on 30/11/2017.
//  Copyright © 2017 Developer Institute. All rights reserved.
//

import UIKit

class FormEventViewController: BaseViewController,UITextFieldDelegate {
//
//    @IBOutlet weak var txtFieldEvent: UITextField!
//    @IBOutlet weak var txtFieldDepart: UITextField!
//    @IBOutlet weak var txtFieldArrive: UITextField!
//    @IBOutlet weak var txtFieldDescription: UITextField!
//
//    @IBAction func cancel(_ sender: Any?)
//    {
//
//        self.dismiss(animated: true)
//    }
//
//    @IBAction func save(_ sender: Any?)
//    {
//        self.dismiss(animated: true)
//    }
//
//
//
//
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//
//        if let linkedTextField : LinkedTextField = textField as? LinkedTextField
//        {
//            if( linkedTextField.nextField != nil )
//            {
//                linkedTextField.nextField?.becomeFirstResponder()
//            }
//            else
//            {
//                linkedTextField.resignFirstResponder()
//                self.save(nil)
//            }
//        }
//
//        return true
//    }
//
//
//
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        //Format Date of Birth dd-MM-yyyy
//
//        //initially identify your textfield
//
//        if textField == txtFieldDepart {
//
//            // check the chars length dd -->2 at the same time calculate the dd-MM --> 5
//            if (txtFieldDepart?.text?.characters.count == 2) || (txtFieldDepart?.text?.characters.count == 5) {
//                //Handle backspace being pressed
//                if !(string == "") {
//                    // append the text
//                    txtFieldDepart?.text = (txtFieldDepart?.text)! + "-"
//                }
//            }
//            // check the condition not exceed 9 chars
//            return !(textField.text!.characters.count > 9 && (string.characters.count ) > range.length)
//        }
//        if textField == txtFieldArrive {
//
//            // check the chars length dd -->2 at the same time calculate the dd-MM --> 5
//            if (txtFieldArrive?.text?.characters.count == 2) || (txtFieldArrive?.text?.characters.count == 5) {
//                //Handle backspace being pressed
//                if !(string == "") {
//                    // append the text
//                    txtFieldArrive?.text = (txtFieldArrive?.text)! + "-"
//                }
//            }
//            // check the condition not exceed 9 chars
//            return !(textField.text!.characters.count > 9 && (string.characters.count ) > range.length)
//        }
//
//        else {
//            return true
//        }
//
//    }
//
//
//
//
//
}

