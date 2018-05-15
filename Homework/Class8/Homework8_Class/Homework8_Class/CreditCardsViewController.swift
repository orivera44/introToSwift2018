//
//  CreditCardsViewController.swift
//  Homework8_KL
//
//  Created by Kevin Lopez on 5/1/18.
//  Copyright © 2018 io.ricoLabs. All rights reserved.
//

import UIKit

class CreditCardsViewController: UIViewController {

    var creditCards = [CreditCard]()
    
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.dataSource = self
            tableView.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Credit Cards"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewCreditCardButtonPressed))
        
        let defaults = UserDefaults.standard
        creditCards = defaults.object(forKey: "CreditCards") as? [CreditCard] ?? [CreditCard]()
        
        }
    
    @objc private func addNewCreditCardButtonPressed() {
        let newAddressVC = storyboard?.instantiateViewController(withIdentifier: "newCreditCard") as! AddCreditCardViewController
        newAddressVC.newCreditCard = CreditCard()
        newAddressVC.addDelegate = self
        navigationController?.pushViewController(newAddressVC, animated: true)
    }
}



extension CreditCardsViewController: AddCreditCardDelegate {
    func didPressSaveButton(_ creditCard: CreditCard) {
        navigationController?.popViewController(animated: true)
        creditCards.append(creditCard)
        
        let defaults = UserDefaults.standard
        defaults.set(creditCards, forKey: "CreditCards")
        
        tableView.reloadData()
    }
}
extension CreditCardsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            creditCards.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
}
extension CreditCardsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return creditCards.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "creditCardSummary", for: indexPath) as! CreditCardSummaryCell
        let creditCard = creditCards[indexPath.row]
        cell.nameLabel.text = "\(creditCard.firstName) " + "\(creditCard.lastName)"
        
        cell.cardInfoLabel.text = "***\(creditCard.cardNumber.suffix(4))\(creditCard.securityCode), expires \(creditCard.expirationDate)"
        return cell
    }
    
    
}
