//
//  CreditCardViewController.swift
//  ProjetEvent
//
//  Created by Sharon Chetrit on 16/01/2018.
//  Copyright © 2018 Sharon Chetrit. All rights reserved.
//

import UIKit

class CreditCardViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource,AddCreditCardDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    lazy var creditCards : [CreditCard] = {
        if let userDefaultCreditCards = CreditCard.openFromUserDefaults()
        {
            return userDefaultCreditCards
        }
        
        return CreditCard.loadSampleFromPlist()
    }()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.tableView.register(UINib(nibName: "CreditCardTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "Cell")
        tableView.reloadData()
    }
    
    @IBAction func menu(_ sender: Any)
    {
        self.viewDeckController?.open(.left, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.creditCards.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : CreditCardTableViewCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CreditCardTableViewCell
        
        let creditcard : CreditCard = self.creditCards[indexPath.row]
        
        cell.updateWithCreditCard(creditcard: creditcard)
        cell.showsReorderControl = true
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let creditcard : CreditCard = self.creditCards[indexPath.row]
        
        self.tableView.deselectRow(at: indexPath, animated: false)
        
        self.performSegue(withIdentifier: "addCreditCardSegue", sender: creditcard)
    }
    
    @IBAction func addCreditCard(_ sender: Any) {
        self.performSegue(withIdentifier: "addCreditCardSegue", sender: nil)
    }
    
    func addCreditCard(creditcard: CreditCard)
    {
        // save the data here
        
        self.creditCards.append(creditcard)
        
        CreditCard.saveOnUserDefaults(creditCards: self.creditCards)
        
        self.tableView.reloadData()
    }
    
    func updateCreditCard(creditcard: CreditCard)
    {
        CreditCard.saveOnUserDefaults(creditCards: self.creditCards)
        
        self.tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let addVC : AddCreditCardViewController = segue.destination as? AddCreditCardViewController
        {
            addVC.delegate = self 
            addVC.creditcard = sender as? CreditCard
        }
    }
    
}
