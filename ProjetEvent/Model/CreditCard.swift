//
//  CreditCard.swift
//  ProjetEvent
//
//  Created by David Mamou on 21/01/18.
//  Copyright © 2018 Sharon Chetrit. All rights reserved.
//

import Foundation
class CreditCard: NSObject, NSCoding
{
    
    var name : String
    var numeroCard : String
    var cvv : String
    var expiration : String
    
    static let DocumentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("creditCards")
    
    init(name:String, numeroCard:String, cvv:String,expiration: String) {
        self.name = name
        self.numeroCard = numeroCard
        self.cvv = cvv
        self.expiration = expiration
    }
    
    init(dictionary: [String : Any] )
    {
        self.name = (dictionary["name"] as? String)!
        self.numeroCard = (dictionary["numeroCard"] as? String)!
        self.cvv = (dictionary["cvv"] as? String)!
        self.expiration = (dictionary["expiration"] as? String)!
    }
    
    
    
    func serialize() -> Dictionary<String,Any>
    {
        var dict : Dictionary<String,Any> = Dictionary()
        
        dict["name"] = self.name
        dict["numeroCard"] = self.numeroCard
        dict["cvv"] = self.cvv
        dict["expiration"] = self.expiration
        
        return dict
    }
    
    static func loadFromFile() -> Array<CreditCard>?
    {
        return NSKeyedUnarchiver.unarchiveObject(withFile: CreditCard.ArchiveURL.path) as? [CreditCard]
    }
    
    static func loadSampleFromPlist() -> [CreditCard]
    {
        var sampleCreditCard : [CreditCard] = []
        
        var creditCardArray : [Any] = []
        
        if let path = Bundle.main.path(forResource: "creditCards", ofType: "plist")
        {
            if let url : URL = URL(fileURLWithPath: path)
            {
                creditCardArray = NSArray(contentsOf: url ) as! [Any] // we get the array from the file here!!!!!!!
            }
            
        }
        
        if let array : [Dictionary<String,Any>] = creditCardArray as! [Dictionary<String, Any>] {
            // Use your dict here
            
            for dict in array
            {
                let newCard = CreditCard(dictionary: dict)
                sampleCreditCard.append(newCard)
            }
        }
        
        return sampleCreditCard
    }
    
    
    
    static func loadCreditCardSample() -> Array<CreditCard>
    {
        let sampleCreditCard = [
            CreditCard(name: "David", numeroCard: "1983298429473645", cvv: "654", expiration: "19-11-2019")
            ]
        
        return sampleCreditCard
        
    }
    
    static func saveToFile(creditCards:Array<CreditCard> )
    {
        NSKeyedArchiver.archiveRootObject(creditCards, toFile: CreditCard.ArchiveURL.path)
        
    }
    
    static func openFromUserDefaults() -> [CreditCard]?
    {
        var sampleCreditCards : [CreditCard] = []
        
        if let creditCardsDicts : [Dictionary<String,Any>] = UserDefaults.standard.object(forKey: "CreditCard") as? [Dictionary<String, Any>]
        {
            for dict in creditCardsDicts
            {
                let card : CreditCard = CreditCard(dictionary: dict)
                sampleCreditCards.append(card)
            }
        }
        else
        {
            return nil
        }
        
        return sampleCreditCards
        
    }
    
    static func saveOnUserDefaults(creditCards: [CreditCard] )
    {
        // serialize
        
        var creditCardDicts : [Dictionary<String,Any>] = []
        
        for creditCard : CreditCard in creditCards
        {
            creditCardDicts.append(creditCard.serialize())
        }
        
        UserDefaults.standard.set(creditCardDicts, forKey: "CreditCard")
    }
    
    required convenience init?(coder aDecoder: NSCoder)
    {
        guard let name = aDecoder.decodeObject(forKey: "name") as? String,
            let numeroCard = aDecoder.decodeObject(forKey: "numeroCard") as? String,
            let cvv = aDecoder.decodeObject(forKey: "cvv") as? String,
            let expiration = aDecoder.decodeObject(forKey: "expiration") as? String
            else {
                return nil
        }
        
        self.init(name: name, numeroCard: numeroCard, cvv: cvv, expiration: expiration)
    }
    func encode(with aCoder: NSCoder) {
        
        aCoder.encode(name, forKey: "name")
        aCoder.encode(numeroCard, forKey: "numeroCard")
        aCoder.encode(cvv, forKey: "cvv")
        aCoder.encode(expiration, forKey: "expiration")
    }
    
}
