//
//  CreditCardViewController.swift
//  ProjetEvent
//
//  Created by David Mamou on 21/01/18.
//  Copyright © 2018 Sharon Chetrit. All rights reserved.
//

import UIKit

class CreditCardViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource,AddCreditCardtDelegate {
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    lazy var creditCards : [CreditCard] = {
        if let userDefaultEvents = CreditCard.openFromUserDefaults()
        {
            return userDefaultEvents
        }
        
        return CreditCard.loadSampleFromPlist()
    }()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.tableView.register(UINib(nibName: "CreditCardTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "Cell")
        tableView.reloadData()
    }
    
    func addCreditCard(creditCard: CreditCard)
    {
        self.creditCards.append(creditCard)
        
        CreditCard.saveOnUserDefaults(creditCards: self.creditCards)
        
        self.tableView.reloadData()
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
        
        let creditCard : CreditCard = self.creditCards[indexPath.row]
        
        cell.updateWithCreditCard(creditCard: creditCard)
        cell.showsReorderControl = true
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (action, index) in
            self.creditCards.remove(at: indexPath.row)
            
            CreditCard.saveOnUserDefaults(creditCards: self.creditCards)
            
            self.tableView.deleteRows(at: [indexPath], with: .fade)
        }
        
        let editAction = UITableViewRowAction(style: .normal, title: "Edit") { (action, index) in
            
            let creditCard : CreditCard = self.creditCards[indexPath.row]
            
            self.performSegue(withIdentifier: "AddCreditCardSegway", sender: creditCard)
        }
        
        return [deleteAction, editAction]
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let creditCard : CreditCard = self.creditCards[indexPath.row]
        
        self.tableView.deselectRow(at: indexPath, animated: false)
        
        self.performSegue(withIdentifier: "AddCreditCardSegway", sender: creditCard)
    }
    
    @IBAction func addCreditCard(_ sender: Any)
    {
        self.performSegue(withIdentifier: "AddCreditCardSegway", sender: nil)
    }
    
    func addEvent(creditCard: CreditCard)
    {
        // save the data here
        
        self.creditCards.append(creditCard)
        
        CreditCard.saveOnUserDefaults(creditCards: self.creditCards)
        
        self.tableView.reloadData()
    }
    
    func updateCreditCard(creditCard: CreditCard)
    {
        CreditCard.saveOnUserDefaults(creditCards: self.creditCards)
        
        self.tableView.reloadData()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let addVC : AddCreditCardViewController = segue.destination as? AddCreditCardViewController
        {
            addVC.delegate = self
            addVC.creditCard = sender as? CreditCard
        }
    }
    
    
   
}
