//
//  CreditCardTableViewController.swift
//  ProjetEvent
//
//  Created by David Mamou on 21/01/18.
//  Copyright © 2018 Sharon Chetrit. All rights reserved.
//

import UIKit

class CreditCardTableViewController: UITableViewController {
    var creditCards: [CreditCard] = Array<CreditCard>()
    
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        
        
        if let creditCard = CreditCard.loadFromFile(){
            self.creditCards = creditCard
        }else{
            self.creditCards = CreditCard.loadCreditCardSample()
        }
    }
    
    @IBAction func menu(_ sender: Any)
    {
        self.viewDeckController?.open(.left, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath)
    {
    
        let movedCreditCard = creditCards.remove(at: fromIndexPath.row)
        creditCards.insert(movedCreditCard, at: to.row)
        
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            creditCards.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
            CreditCard.saveToFile(creditCards:self.creditCards)
        }
    }
    
    
}
