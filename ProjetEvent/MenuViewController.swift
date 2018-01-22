//
//  MenuViewController.swift
//  ProjetEvent
//
//  Created by Sharon Chetrit on 03/01/2018.
//  Copyright © 2018 Sharon Chetrit. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import FBSDKCoreKit

class MenuViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        displayUserInfo()
    }

    @IBAction func share(_ sender: Any)
    {
        self.performSegue(withIdentifier: "shareSegue", sender: nil)
    }
    
    @IBAction func ratting(_ sender: Any)
    {
        self.performSegue(withIdentifier: "ratingSegue", sender: nil)
    }
    
    @IBAction func profile(_ sender: Any)
    {
        if let slideMenuController: ProjectEventDeckController = self.viewDeckController as? ProjectEventDeckController
        {
            slideMenuController.centerViewController = slideMenuController.profileController
            slideMenuController.closeSide(true)
        }
    }
    
    @IBAction func events(_ sender: Any)
    {
        if let slideMenuController: ProjectEventDeckController = self.viewDeckController as? ProjectEventDeckController
        {
            slideMenuController.centerViewController = slideMenuController.eventController
            slideMenuController.closeSide(true)
        }
    }
    func displayUserInfo()
    {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        Database.database().reference().child("User").child(uid).observeSingleEvent(of: .value) { (snapshot) in
            print(snapshot)
        }
        
    }
    
    @IBAction func logOut(_ sender: Any)
    {
        handleLogOut()
        navigationController?.popViewController(animated: true)
    }
    
    func handleLogOut()
    {
        if Auth.auth().currentUser?.uid != nil {
            do
            {
                try Auth.auth().signOut()
            self.dismiss(animated: true, completion: nil)
            } catch let logOutError
            {
                print(logOutError.localizedDescription)
            }
        }
    }
    
    
    @IBAction func fetchButton(_ sender: Any)
    {
        fetchFB()
    }
    
    func fetchFB()
    {
        if (FBSDKAccessToken.current() != nil) {
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "name"]).start(completionHandler: {(connection, result : Any?, error) -> Void in
                if error == nil {
                   if let dictionary = result as? Dictionary<String,Any> {
                        let username : String = dictionary["name"] as! String
                        print("fetched name:\(username)")
                        
                    }
                    print("fetched user:\(result)")
                }
                })
        }
    }
}
