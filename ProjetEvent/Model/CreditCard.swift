//
//  CreditCard.swift
//  ProjetEvent
//
//  Created by Sharon Chetrit on 21/01/2018.
//  Copyright © 2018 Sharon Chetrit. All rights reserved.
//

import Foundation

class CreditCard : NSObject, NSCoding
{
    var name: String
    var number: String
    var date: String
    var cryptogram: String
    
    static let DocumentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("creditCards")
    
    init(name: String, number: String, date: String, cryptogram: String) {
        self.name = name
        self.number = number
        self.date = date
        self.cryptogram = cryptogram
    }
    
    init(dictionary: [String : Any] )
    {
        self.name = (dictionary["name"] as? String)!
        self.number = (dictionary["number"] as? String)!
        self.date = (dictionary["date"] as? String)!
        self.cryptogram = (dictionary["cryptogram"] as? String)!
    }
    
    func serialize() -> Dictionary<String,Any>
    {
        var dict : Dictionary<String,Any> = Dictionary()
        
        dict["name"] = self.name
        dict["number"] = self.number
        dict["date"] = self.date
        dict["cryptogram"] = self.cryptogram
        
        return dict
    }
    
    static func loadFromFile() -> Array<CreditCard>?
    {
        return NSKeyedUnarchiver.unarchiveObject(withFile: CreditCard.ArchiveURL.path) as? [CreditCard]
    }
    
    static func loadSampleFromPlist() -> [CreditCard]
    {
        var sampleCreditCard : [CreditCard] = []
        
        var CreditCardArray : [Any] = []
        
        if let path = Bundle.main.path(forResource: "creditCards", ofType: "plist")
        {
            CreditCardArray = NSArray(contentsOf: URL(fileURLWithPath: path)) as! [Any]
        }
        
        if let array : [Dictionary<String,Any>] = CreditCardArray as? [Dictionary<String, Any>] {
            
            for dict in array
            {
                let newCreditCard = CreditCard(dictionary: dict)
                sampleCreditCard.append(newCreditCard)
            }
        }
        
        return sampleCreditCard
    }
    
    
    
    static func loadCreditCardSample() -> Array<CreditCard>
    {
        let sampleCreditCard = [
            CreditCard(name: "Sharon Chetrit", number: "2498305484", date: "07-03-2021", cryptogram: "309"),
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
        
        if let CreditCardDicts : [Dictionary<String,Any>] = UserDefaults.standard.object(forKey: "CreditCard") as? [Dictionary<String, Any>]
        {
            for dict in CreditCardDicts
            {
                let creditcard : CreditCard = CreditCard(dictionary: dict)
                sampleCreditCards.append(creditcard)
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
        
        var CreditCardDicts : [Dictionary<String,Any>] = []
        
        for creditcard : CreditCard in creditCards
        {
            CreditCardDicts.append(creditcard.serialize())
        }
        
        UserDefaults.standard.set(CreditCardDicts, forKey: "CreditCard")
    }
    
    required convenience init?(coder aDecoder: NSCoder)
    {
        guard let name = aDecoder.decodeObject(forKey: "name") as? String,
            let number = aDecoder.decodeObject(forKey: "number") as? String,
            let date = aDecoder.decodeObject(forKey: "date") as? String,
            let cryptogram = aDecoder.decodeObject(forKey: "cryptogram") as? String
            else {
                return nil
        }
        
        self.init(name: name, number: number, date: date, cryptogram: cryptogram)
    }
    func encode(with aCoder: NSCoder) {
        
        aCoder.encode(name, forKey: "name")
        aCoder.encode(number, forKey: "number")
        aCoder.encode(date, forKey: "date")
        aCoder.encode(cryptogram, forKey: "cryptogram")
    }
    
}

