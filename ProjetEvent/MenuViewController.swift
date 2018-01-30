/*
//  MenuViewController.swift
//  ProjetEvent
//
//  Created by Sharon Chetrit on 03/01/2018.
//  Copyright © 2018 Sharon Chetrit. All rights reserved.
*/

import UIKit
import StoreKit
import ViewDeck
import FBSDKShareKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class MenuViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
  // var tableData = ["Share", "Rate", "Profile", "Event", "Credit Card"]
    
    @IBOutlet weak var tblView: UITableView!
    
    let menuItems = MenuItem.loadSampleFromPlist()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tblView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        NotificationCenter.default.addObserver(self.tblView, selector: #selector(UICollectionView.reloadData), name: NSNotification.Name(rawValue: "UserProfileUpdated"), object: nil)
        
        self.tblView.register(UINib(nibName: "MenuItemTableViewCell" , bundle: Bundle.main), forCellReuseIdentifier: "MenuItemTableViewCell")
        self.tblView.register(UINib(nibName: "ProfileTableViewCell" , bundle: Bundle.main), forCellReuseIdentifier: "ProfileTableViewCell")
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.menuItems.count
       // return tableData.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let menuItem = self.menuItems[indexPath.row]
        
        let cell : MenuItemTableViewCell = tableView.dequeueReusableCell(withIdentifier: menuItem.cellType, for: indexPath) as! MenuItemTableViewCell
        
        cell.updateOnMenuItem(menuItem)
        
        
//      cell.textLabel?.text = tableData[indexPath.row]
//      cell.textLabel?.text = menuItem.title
//      cell.backgroundColor = UIColor.black
//      cell.textLabel?.textColor = UIColor.red
//      cell.layer.backgroundColor = UIColor.clear.cgColor

        
        return cell
    }
    
       func colorForIndex(index: Int) -> UIColor {
            let itemCount = menuItems.count - 1
            let color = (CGFloat(index) / CGFloat(itemCount)) * 0.6
            return UIColor(red: 1.0, green: color, blue: 0.0, alpha: 1.0)
        }

    private func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.backgroundColor = colorForIndex(index: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        let menuItem = self.menuItems[indexPath.row]
        
        if menuItem.cellType == "ProfileTableViewCell"
        {
            return 265
        }
        
        return 44.0
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: false)
        let menuItem = self.menuItems[indexPath.row]
        
        if self.responds(to: menuItem.selector )
        {
            self.perform(menuItem.selector, with: nil)
        }
        
        
    }
    
    @IBAction func ratting(_ sender: Any)
    {
        if #available(iOS 10.3, *) {
            SKStoreReviewController.requestReview()
        } else {
            
        }
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
    
    @IBAction func creditCards(_ sender: Any)
    {
        if let slideMenuController: ProjectEventDeckController = self.viewDeckController as? ProjectEventDeckController
        {
            slideMenuController.centerViewController = slideMenuController.creditCardController
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
        if Auth.auth().currentUser?.uid != nil || FBSDKAccessToken.current() != nil {
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
    
    

    
//    func fetchFB()
//    {
//        if (FBSDKAccessToken.current() != nil) {
//            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "name"]).start(completionHandler: {(connection, result : Any?, error) -> Void in
//                if error == nil {
//                   if let dictionary = result as? Dictionary<String,Any> {
//                        let username : String = dictionary["name"] as! String
//                        print("fetched name:\(username)")
//
//                    }
//                    print("fetched user:\(result)")
//                }
//                })
//        }
//    }
}
