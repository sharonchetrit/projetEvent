//
//  LoginViewController.swift
//  ProjetEvent
//
//  Created by Mac on 15/01/2018.
//  Copyright © 2018 Sharon Chetrit. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class LoginViewController: BaseViewController, FBSDKLoginButtonDelegate, UITextFieldDelegate {

    @IBOutlet weak var mailTxt: UITextField!
    @IBOutlet weak var passTxt: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func confAction(_ sender: Any)
    {
        performSegue(withIdentifier: "loginToMainSegue", sender: nil)
    }
    
    @IBAction func createAction(_ sender: Any)
    {
        performSegue(withIdentifier: "createAccountSegue", sender: nil)
    }
    
    @IBAction func Fb(_ sender: Any)
    {
        
    }
    

    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!)
    {
        
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton)
    {
        
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
