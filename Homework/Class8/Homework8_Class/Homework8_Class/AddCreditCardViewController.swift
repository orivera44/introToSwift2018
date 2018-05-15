        //
        //  AddCreditCardViewController.swift
        //  Homework8_KL
        //
        //  Created by Kevin Lopez on 5/1/18.
        //  Copyright © 2018 io.ricoLabs. All rights reserved.
        //
        
        import UIKit
        import Foundation
        
        
        enum CardDetailSectionCellType: Int {
            case firstName = 0
            case lastName = 1
            case cardNumber = 2
            case expirationDate = 3
            case securityCode = 4
            
            var txt: String {
                switch self {
                case .firstName:
                    return "First Name"
                case .lastName:
                    return "Last Name"
                case .cardNumber:
                    return "Card Number"
                case .expirationDate:
                    return "Expiration Date"
                case .securityCode:
                    return "Security Code"
                }
            }
            
            static var count: Int {
                return CardDetailSectionCellType.securityCode.rawValue + 1
            }
        }
        
        enum AddressSectionCellType: Int {
            case addressOne = 0
            case addressTwo = 1
            case cityTown = 2
            case state = 3
            case zipCode = 4
            
            var txt: String {
                switch self {
                case .addressOne:
                    return "Address"
                case .addressTwo:
                    return "Apt. Number (optional)"
                case .cityTown:
                    return "City or Town"
                case .state:
                    return "State"
                case .zipCode:
                    return "Zip Code"
                }
            }
            
            static var count: Int {
                return AddressSectionCellType.zipCode.rawValue + 1
            }
        }
        
        enum NewCreditCardSectionType: Int {
            case cardDetails = 0
            case address = 1
            
            var txt: String {
                switch self {
                case .cardDetails:
                    return "Card Details"
                case .address:
                    return "Address"
                }
            }
            
            static var count: Int {
                return NewCreditCardSectionType.address.rawValue + 1
            }
        }
        
        protocol AddCreditCardDelegate: class {
            func didPressSaveButton(_ creditCard: CreditCard)
        }
        
        class AddCreditCardViewController: UIViewController {
            
//            private let myValues: NSArray = ["one","two","three","four"]
            
            
            
            var newCreditCard = CreditCard()
            weak var addDelegate: AddCreditCardDelegate?
            
           
            
            @IBOutlet weak var tableView: UITableView! {
                didSet{
                    tableView.keyboardDismissMode = .onDrag
                }
            }
            
            deinit {
                NotificationCenter.default.removeObserver(self)
            }
            
            override func viewDidLoad() {
                super.viewDidLoad()
                title = "Add Credit Card"
                NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
                NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
                navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonPressed))
                navigationItem.rightBarButtonItem?.isEnabled = false
                
                
            }
            
//            @IBAction func btnScanCardClk(_ sender: UIButton) {
//
//
//                let cardIOVC = CardIOPaymentViewController(paymentDelegate: self)
//                cardIOVC?.collectCardholderName = true
//                cardIOVC?.modalPresentationStyle = .formSheet
//                cardIOVC?.guideColor = UIColor(red:0.13, green:0.54, blue:0.61, alpha:1.00)
//                cardIOVC?.disableManualEntryButtons = true
//                cardIOVC?.hideCardIOLogo = true
//                present(cardIOVC!, animated: true, completion: nil)
//            }

            @objc private func saveButtonPressed() {
                self.addDelegate?.didPressSaveButton(newCreditCard)
            }
            
            private func updateSaveButton() {
                navigationItem.rightBarButtonItem?.isEnabled = newCreditCard.areDetailsFilledOut
            }
        
            
        }
        extension AddCreditCardViewController: UITableViewDelegate {
            func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                tableView.deselectRow(at: indexPath, animated: false)
            }
            
            func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
                let header = view as! UITableViewHeaderFooterView
                header.textLabel?.font = UIFont(name: "Futura", size: 17)!
                header.textLabel?.textColor = UIColor.lightGray
            }
            
        }
        
        extension AddCreditCardViewController: UITableViewDataSource {
            
            
            func numberOfSections(in tableView: UITableView) -> Int {
                
                return 2
            }
            
            func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
                return NewCreditCardSectionType(rawValue: section)?.txt
            }
            
            
            
            func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                let sectionType = NewCreditCardSectionType(rawValue: section)!
                switch sectionType {
                case .cardDetails:
                    return CardDetailSectionCellType.count
                case .address:
                    return AddressSectionCellType.count
                }
            }
            
            func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                let sectionType = NewCreditCardSectionType(rawValue: indexPath.section)!
                
                switch sectionType {
                case .cardDetails:
                    let cellType = CardDetailSectionCellType(rawValue: indexPath.row)!
                    return cardDetailCellFor(cellType, indexPath)
                    
                case .address:
                    let cellType = AddressSectionCellType(rawValue: indexPath.row)!
                    return addressCellFor(cellType, indexPath)
                }
            }
            
            private func cardDetailCellFor(_ cellType: CardDetailSectionCellType, _ indexPath: IndexPath) -> UITableViewCell {
                let cell = tableView.dequeueReusableCell(withIdentifier: "textEntryCell", for: indexPath) as! TextEntryCell
                cell.fieldName.text = cellType.txt
                cell.delegate = self
                cell.cardDetailCellType = cellType
                switch cellType {
                case .expirationDate:
                    cell.textField.inputView = cell.pikerView
                case .cardNumber:
                    cell.textField.keyboardType = .numberPad
                case .securityCode:
                    cell.textField.keyboardType = .numberPad
                    cell.textField.isSecureTextEntry = true
                default:
                    cell.textField.keyboardType = .default
                }
                
                return cell
            }
            
            private func addressCellFor(_ cellType: AddressSectionCellType, _ indexPath: IndexPath) -> UITableViewCell {
                let cell = tableView.dequeueReusableCell(withIdentifier: "textEntryCell", for: indexPath) as! TextEntryCell
                cell.fieldName.text = cellType.txt
                cell.delegate = self
                cell.addressCellType = cellType
                
                switch cellType {
                case .state:
                    cell.textField.inputView = cell.pikerView
                    
                case .zipCode:
                    cell.textField.keyboardType = .default
                default:
                    cell.textField.keyboardType = .emailAddress
                }
                
                return cell
            }
        }
        

        
        extension AddCreditCardViewController: TextEntryDelegate {
            
            func didUpdateField(_ text: String, _ cardDetailCellType: CardDetailSectionCellType?, _ addressCellType: AddressSectionCellType?) {
                
                if let addressType = addressCellType {
                    newCreditCard = newCreditCard.updateAddressDetail(addressType, text)
                } else if let cardDetail = cardDetailCellType {
                    newCreditCard = newCreditCard.updateCardDetail(cardDetail, text)
                }
                updateSaveButton()
            }
        }
        
        extension AddCreditCardViewController {
            @objc func keyboardWillShow(_ sender: Notification) {
                let height: CGFloat = (sender.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size.height ?? 0
                let duration: TimeInterval = (sender.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
                let curveOption: UInt = (sender.userInfo?[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber)?.uintValue ?? 0
                
                UIView.animate(withDuration: duration, delay: 0, options: UIViewAnimationOptions(rawValue: UIViewAnimationOptions.beginFromCurrentState.rawValue|curveOption), animations: {
                    let edgeInsets = UIEdgeInsetsMake(0, 0, height, 0)
                    self.tableView.contentInset = edgeInsets
                    self.tableView.scrollIndicatorInsets = edgeInsets
                }, completion: nil)
            }
            
            @objc func keyboardWillHide(_ sender: Notification) {
                let duration: TimeInterval = (sender.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
                let curveOption: UInt = (sender.userInfo?[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber)?.uintValue ?? 0
                
                UIView.animate(withDuration: duration, delay: 0, options: UIViewAnimationOptions(rawValue: UIViewAnimationOptions.beginFromCurrentState.rawValue|curveOption), animations: {
                    let edgeInsets = UIEdgeInsets.zero
                    self.tableView.contentInset = edgeInsets
                    self.tableView.scrollIndicatorInsets = edgeInsets
                }, completion: nil)
            }
        }
