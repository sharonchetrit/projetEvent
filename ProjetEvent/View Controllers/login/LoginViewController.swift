//
//  LoginViewController.swift
//  ProjetEvent
//
//  Created by Mac on 15/01/2018.
//  Copyright © 2018 Sharon Chetrit. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FirebaseAuth
import Firebase


class LoginViewController: BaseViewController, FBSDKLoginButtonDelegate, UITextFieldDelegate {

    @IBOutlet weak var mailTxt: UITextField!
    @IBOutlet weak var passTxt: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        checkIfUserIn()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func confAction(_ sender: Any)
    {
        handleLogin()
    }
    
    @IBAction func createAction(_ sender: Any)
    {
        performSegue(withIdentifier: "createAccountSegue", sender: nil)
    }
    
    @IBAction func Fb(_ sender: Any)
    {
        
    }
    

    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if let error = error {
            print(error.localizedDescription)
            return
        }
        
        let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
        Auth.auth().signIn(with: credential) { (user, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            self.fetchFB()
            print(credential)

        }
        
        
        
        self.performSegue(withIdentifier: "loginToMainSegue", sender: nil)
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
    
    func handleLogin()
    {
        guard let email = mailTxt.text,
            let password = passTxt.text else {return}
        
        Auth.auth().signIn(withEmail: email, password: password, completion: { [weak self] (user, error)  in
            if error != nil
            {
                let alertView = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                
                alertView.addAction(okAction)
                
                self?.present(alertView, animated: true, completion: nil)
                
                return
            }
            self?.performSegue(withIdentifier: "loginToMainSegue", sender: nil)
        })
    }
    
    
    func fetchFB()
    {
        let graphRequest: FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "name, first_name, last_name, email"])
        if (FBSDKAccessToken.current() != nil) {
            graphRequest.start(completionHandler: {(connection, result : Any?, error) -> Void in
                if error == nil {
                    if let dictionary = result as? Dictionary<String,Any> {
                        let firstName : String = dictionary["first_name"] as! String
                        let lastName : String = dictionary["last_name"] as! String
                        let username : String = dictionary["name"] as! String
                        print("fetched name: \(username), first: \(firstName), last: \(lastName), email: ")
                        
                    }
                    print("fetched user:\(String(describing: result))")
                }
            })
        }
    }
    
    func checkIfUserIn()
    {
        if  FBSDKAccessToken.current() != nil || Auth.auth().currentUser?.uid != nil
        {
            performSegue(withIdentifier: "loginToMainSegue", sender: nil)
        }
    }
}
