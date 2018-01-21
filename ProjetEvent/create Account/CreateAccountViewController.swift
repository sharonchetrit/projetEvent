//
//  CreateAccountViewController.swift
//  ProjetEvent
//
//  Created by Mac on 17/01/2018.
//  Copyright © 2018 Sharon Chetrit. All rights reserved.
//

import UIKit

class CreateAccountViewController: BaseViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var firstNameTxt: UITextField!
    @IBOutlet weak var surnameTxt: UITextField!
    @IBOutlet weak var birthTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var phoneTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var confirmPassTxt: UITextField!
    
    @IBOutlet weak var confirmButton: UIBarButtonItem!
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var scroll: UIScrollView!
    
    lazy var user : User = User.sharedInstance

    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.containerView.autoresizingMask = UIViewAutoresizing(rawValue: UIViewAutoresizing.RawValue(UInt8(UIViewAutoresizing.flexibleWidth.rawValue) | UInt8(UIViewAutoresizing.flexibleHeight.rawValue)))
        
        self.containerView.frame = CGRect(x: 0, y: 0, width: self.scroll.frame.size.width, height: self.containerView.frame.size.height)
        
        self.scroll.contentSize = self.containerView.frame.size
        self.scroll.addSubview(self.containerView)
        
        
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //Format Date of Birth dd-MM-yyyy
        
        //initially identify your textfield
        
        if textField == birthTxt {
            
            // check the chars length dd -->2 at the same time calculate the dd-MM --> 5
            if (birthTxt?.text?.characters.count == 2) || (birthTxt?.text?.characters.count == 5) {
                //Handle backspace being pressed
                if !(string == "") {
                    // append the text
                    birthTxt?.text = (birthTxt?.text)! + "-"
                }
            }
            // check the condition not exceed 9 chars
            return !(textField.text!.characters.count > 9 && (string.characters.count ) > range.length)
        }
        if textField == phoneTxt {
            if (phoneTxt?.text?.first == "+"){
                return !(textField.text!.characters.count > 12 && (string.characters.count ) > range.length)
            }
            return !(textField.text!.characters.count > 9 && (string.characters.count ) > range.length)
        }
        else {
            return true
        }
    }
    
    @IBAction func TxtEdittingChange(_ sender: Any)
    {
        updateConfirmButton()
    }
    
    @IBAction func confirmAction(_ sender: Any)
    {
        performSegue(withIdentifier: "inscriptionToMainSegue", sender: nil)
        
        guard let pass : String = self.passwordTxt.text,
            let confPass : String = self.confirmPassTxt.text,
            pass == confPass,
            let first_name : String = self.firstNameTxt.text,
            let surname : String = self.surnameTxt.text,
            let birthday : String = self.birthTxt.text,
            let email : String = self.emailTxt.text,
            let phone : String = self.phoneTxt.text,
            let image : UIImage = self.imageView.image
            else {
                let alertView = UIAlertController(title: "ERROR", message: "Confirm Password Incorect", preferredStyle: .alert)
                
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                alertView.addAction(cancelAction)
                
                self.present(alertView, animated: true, completion: nil)
                
                return
                
        }
        
        
        self.user.password = pass
        self.user.confirmPass = confPass
        self.user.name = first_name
        self.user.birthday = birthday
        self.user.email = email
        self.user.phone = phone
        self.user.profileImage = image
        self.user.surname = surname
        
        
        User.saveOnUserDefaults(users: self.user)
    }
    
    func updateConfirmButton()
    {
        let name = firstNameTxt.text ?? ""
        let surname = surnameTxt.text ?? ""
        let birth = birthTxt.text ?? ""
        let email = emailTxt.text ?? ""
        let phone = phoneTxt.text ?? ""
        let password = passwordTxt.text ?? ""
        let confirmPass = confirmPassTxt.text ?? ""
        
        confirmButton.isEnabled = !name.isEmpty && !surname.isEmpty && !birth.isEmpty && !email.isEmpty && !phone.isEmpty && !password.isEmpty && !confirmPass.isEmpty
    }
    
    @IBAction func addPhoto(_ sender: Any) {
        let alertView = UIAlertController(title: "Do you want", message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertView.addAction(cancelAction)
        
        let pictureAction = UIAlertAction(title: "Take a picture", style: .default, handler:{ action in
            
            let picker : UIImagePickerController = UIImagePickerController()
            picker.delegate = self
            
            picker.sourceType = .camera
            
            self.present(picker, animated: true, completion: nil)
        })
        alertView.addAction(pictureAction)
        
        let libraryAction = UIAlertAction(title: "Choose from library", style: .default, handler:{ action in
            
            let picker : UIImagePickerController = UIImagePickerController()
            picker.delegate = self
            
            picker.sourceType = .photoLibrary
            
            self.present(picker, animated: true, completion: nil)
        })
        alertView.addAction(libraryAction)
        
        self.present(alertView, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage
            else { return }
        self.imageView.image = selectedImage
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelButton(_ sender: Any)
    {
       navigationController?.popViewController(animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if let linkedTextField : LinkedTextField = textField as? LinkedTextField
        {
            if( linkedTextField.nextField != nil )
            {
                linkedTextField.nextField?.becomeFirstResponder()
            }else
            {
                linkedTextField.resignFirstResponder()
                
            }
        }
        return true
    }
    
}
