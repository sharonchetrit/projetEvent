//
//  User.swift
//  ProjetEvent
//
//  Created by Mac on 04/01/2018.
//  Copyright © 2018 Sharon Chetrit. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class User : NSObject
{
    private static var sharedUser : User?

    
    
    var name: String?
    var surname: String?
    var birthday: String?
    var email: String?
    var phone: String?
    var password: String?
    var confirmPass: String?
    var profileImage: UIImage?
    var ref: DatabaseReference?
    var key: String?
    
    
    init(snapshot: DataSnapshot)
    {
        self.key = snapshot.key
        
        if let dict = snapshot.value as? [String: AnyObject] {
            
            if let name = dict["name"] as? String
            {
                self.name = name
            }
            if let surname = dict["surname"] as? String
            {
                self.surname = surname
            }
            if let birthday = dict["age"] as? String
            {
                self.birthday = birthday
            }
            if let email = dict["email"] as? String
            {
                self.email = email
            }
            if let phone = dict["phone"] as? String
            {
                self.phone = phone
            }
            if let image = dict["image"] as? UIImage
            {
                self.profileImage = image
            }
          
            self.ref = snapshot.ref
        }
    }
    
    
    init(name: String, surname: String, birthday: String, email: String, phone: String, password: String, confirmPass: String, profileImage: UIImage )
    {
        self.name = name
        self.surname = surname
        self.birthday = birthday
        self.email = email
        self.phone = phone
        self.password = password
        self.confirmPass = confirmPass
        self.profileImage = profileImage
    }

  
    override init()
    {
        super.init()
    }
    
    static func sharedInstance() -> User?
    {
        if sharedUser == nil
        {
            self.fetchUserData(closure: { (user) in
                
                if user != nil
                {
                    sharedUser = user
                }
            })
            
            sharedUser = User()
        }
        
        return sharedUser
    }
    
    static func fetchUserData(closure: @escaping (User?) -> Void)
    {
        guard let uid = Auth.auth().currentUser?.uid
            else
        {
            closure(nil)
            return
        }
        
        Database.database().reference().child("User").child(uid).observeSingleEvent(of: .value) { (snapshot) in
            
            sharedUser = User(snapshot: snapshot)
            closure(sharedUser)
            
        }
        
    }
    
    static func updateData(user: User, closure: @escaping (User?) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid
        else {
            closure(nil)
            return
        }

//        let key = user.ref?.key
        let updateUser = Database.database().reference().child("User").child(uid)
        let dataToUpdate = ["age": user.birthday,
                            "confirmPass": user.confirmPass,
                            "email":user.email,
                            "name": user.name,
                            "phone": user.phone,
                            "surname": user.surname]
        
//        updateUser.updateChildValues(dataToUpdate)
        
        updateUser.updateChildValues(dataToUpdate) { (error, data) in
            if error == nil
            {
                sharedUser = user
                closure(user)
            }
            else
            {
                closure(nil)
            }
        }
        
    }
    
    static func handleRegister(user : User, closure: @escaping (User?) -> Void)
    {
        guard let firstName = user.name,
            let surname = user.surname,
            let birthday = user.birthday,
            let email = user.email,
            let phone = user.phone,
            let pass = user.password,
            let image : UIImage = user.profileImage,
            let confPass = user.confirmPass
            else {
                return
                
        }
        
        Auth.auth().createUser(withEmail: email, password: pass){ (newUser, error) in
            if error != nil
            {
                print(error as Any)
                closure(nil)
                return
            }
            guard let uid = newUser?.uid else
            {return}
            
            let ref = Database.database().reference(fromURL: "https://projevent-457b4.firebaseio.com/")
            
            let userRef = ref.child("User").child(uid)
            
            let userDict = ["name": "\(firstName)",
                "age": "\(birthday)",
                "email": "\(email)",
                "phone": "\(phone)",
                "surname": "\(surname)",
                "confirmPass": "\(confPass)",
                "image": "\(image)"]
            
            
            userRef.updateChildValues(userDict, withCompletionBlock: {(err,ref) in
                if err != nil
                {
                    print(err as Any)
                    closure(nil)
                    return
                }
                
                sharedUser = user
                
                closure(sharedUser)
                
                print("user saved succesfully")
            })
        }
    }

}

