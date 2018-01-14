//
//  ProfileViewController.swift
//  ProjetEvent
//
//  Created by Mac on 03/01/2018.
//  Copyright © 2018 Sharon Chetrit. All rights reserved.
//

import UIKit


class ProfileViewController: BaseViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    
    
    @IBOutlet var containerView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var firstNameTxt: UITextField!
    @IBOutlet weak var surnameTxt: UITextField!
    @IBOutlet weak var birthTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var phoneTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var confirmPassTxt: UITextField!
    
    @IBOutlet weak var confirmButton: UIBarButtonItem!
    
    lazy var user : User = User.sharedInstance
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.containerView.autoresizingMask = UIViewAutoresizing(rawValue: UIViewAutoresizing.RawValue(UInt8(UIViewAutoresizing.flexibleWidth.rawValue) | UInt8(UIViewAutoresizing.flexibleHeight.rawValue)))
        
        self.containerView.frame = CGRect(x: 0, y: 0, width: self.scrollView.frame.size.width, height: self.containerView.frame.size.height)
        
        self.scrollView.contentSize = self.containerView.frame.size
        self.scrollView.addSubview(self.containerView)
        
        birthTxt.delegate = self
        birthTxt.keyboardType = .numberPad
        phoneTxt.keyboardType = .phonePad
        emailTxt.keyboardType = .emailAddress
        
        self.updateConfirmButton()
        self.registerForKeyboardNotifications()
        
        imageView.layer.cornerRadius = imageView.frame.width / 4.0
        imageView.clipsToBounds = true
        
        self.firstNameTxt.text = self.user.name
        self.surnameTxt.text = self.user.surname
        self.phoneTxt.text = self.user.phone
        self.birthTxt.text = self.user.birthday
        self.passwordTxt.text = self.user.password
        self.emailTxt.text = self.user.email
        self.confirmPassTxt.text = self.user.confirmPass
        
        if let image : UIImage = self.user.profileImage
        {
            self.imageView.image = image
        }
//
//        let image = UIImage(named: "Photo")
//        let imageData: NSData = UIImagePNGRepresentation(image!)! as NSData
//
//        UserDefaults.standard.set(imageData, forKey: "savedImage")
//
//        let data = UserDefaults.standard.object(forKey: "savedImage") as! NSData
//        imageView.image = UIImage(data: data as Data)
        
        
        
    }
    
    
    @IBAction func txtEditingChange(_ sender: UITextField)
    {
        updateConfirmButton()
    }
    
    @IBAction func confirmAction(_ sender: Any)
    {
        guard let pass : String = self.passwordTxt.text,
            let confPass : String = self.confirmPassTxt.text,
            pass == confPass,
            let first_name : String = self.firstNameTxt.text,
            let surname : String = self.surnameTxt.text,
            let birthday : String = self.birthTxt.text,
            let email : String = self.emailTxt.text,
            let phone : String = self.phoneTxt.text,
            let image : UIImage = self.imageView.image
        
        else
        {
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
        
        let alertView = UIAlertController(title: "Welcome", message: "You updated your account", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertView.addAction(cancelAction)
        
        self.present(alertView, animated: true, completion: nil)
}

    
    
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown(_:)), name: .UIKeyboardDidShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden(_:)), name: .UIKeyboardWillHide, object: nil)
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
    
    
    @objc func keyboardWasShown(_ notificiation: NSNotification)
    {
        struct keyboard
        {
            static var userInfo : [AnyHashable : Any]?
        }
        
        if( keyboard.userInfo == nil )
        {
            keyboard.userInfo = notificiation.userInfo
        }
        
        if let keyboardFrameValue : NSValue =  keyboard.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue
        {
            let keyboardFrame = keyboardFrameValue.cgRectValue
            let keyboardSize = keyboardFrame.size
            
            
            let contentInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize.height, 0.0)
            self.scrollView.contentInset = contentInsets
            self.scrollView.scrollIndicatorInsets = contentInsets
        }
    }
    
    @objc func keyboardWillBeHidden(_ notification: NSNotification) {
        let contentInsets = UIEdgeInsets.zero
        self.scrollView.contentInset = contentInsets
        self.scrollView.scrollIndicatorInsets = contentInsets
    }
    
    @IBAction func menu(_ sender: Any)
    {
        self.viewDeckController?.open(.left, animated: true)
    }

}
