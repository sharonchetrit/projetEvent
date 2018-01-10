//
//  ProfileViewController.swift
//  ProjetEvent
//
//  Created by Mac on 03/01/2018.
//  Copyright © 2018 Sharon Chetrit. All rights reserved.
//

import UIKit


class ProfileViewController: BaseViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var firstNameTxt: UITextField!
    @IBOutlet weak var surnameTxt: UITextField!
    @IBOutlet weak var birthTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var phoneTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var confirmPassTxt: UITextField!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
//                self.save(nil)
            }
        }
        return true
    }
    
    @IBAction func menu(_ sender: Any)
    {
        self.viewDeckController?.open(.left, animated: true)
    }
}
