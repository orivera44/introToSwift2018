//
//  TextEntryCell.swift
//  Homework8_KL
//
//  Created by Kevin Lopez on 5/1/18.
//  Copyright © 2018 io.ricoLabs. All rights reserved.
//

import UIKit

protocol TextEntryDelegate: class {      
    func didUpdateField(_ text: String, _ cardDetailCellType: CardDetailSectionCellType?, _ addressCellType: AddressSectionCellType?)
}





class TextEntryCell: UITableViewCell {
    
    private let months = [ "JAN",
                             "FEB",
                             "MAR",
                             "APR"]
    
    private let years = [ "2018",
                             "2019",
                             "2020",
                             "2021"]
    
    private let myValues = [ "AK - Alaska",
                             "AL - Alabama",
                             "AR - Arkansas",
                             "AS - American Samoa",
                             "AZ - Arizona",
                             "CA - California",
                             "CO - Colorado",
                             "CT - Connecticut",
                             "DC - District of Columbia",
                             "DE - Delaware",
                             "FL - Florida",
                             "GA - Georgia",
                             "GU - Guam",
                             "HI - Hawaii",
                             "IA - Iowa",
                             "ID - Idaho",
                             "IL - Illinois",
                             "IN - Indiana",
                             "KS - Kansas",
                             "KY - Kentucky",
                             "LA - Louisiana",
                             "MA - Massachusetts",
                             "MD - Maryland",
                             "ME - Maine",
                             "MI - Michigan",
                             "MN - Minnesota",
                             "MO - Missouri",
                             "MS - Mississippi",
                             "MT - Montana",
                             "NC - North Carolina",
                             "ND - North Dakota",
                             "NE - Nebraska",
                             "NH - New Hampshire",
                             "NJ - New Jersey",
                             "NM - New Mexico",
                             "NV - Nevada",
                             "NY - New York",
                             "OH - Ohio",
                             "OK - Oklahoma",
                             "OR - Oregon",
                             "PA - Pennsylvania",
                             "PR - Puerto Rico",
                             "RI - Rhode Island",
                             "SC - South Carolina",
                             "SD - South Dakota",
                             "TN - Tennessee",
                             "TX - Texas",
                             "UT - Utah",
                             "VA - Virginia",
                             "VI - Virgin Islands",
                             "VT - Vermont",
                             "WA - Washington",
                             "WI - Wisconsin",
                             "WV - West Virginia",
                             "WY - Wyoming"]
    
    


    
    weak var delegate: TextEntryDelegate?
    var cardDetailCellType: CardDetailSectionCellType? = nil
    var addressCellType: AddressSectionCellType? = nil


    @IBOutlet weak var textField: UITextField! {
        didSet{
            textField.delegate = self
            pikerView.delegate = self
            pikerView.dataSource = self
        }
    }
    @IBOutlet weak var fieldName: UILabel!
    
    
    var pikerView = UIPickerView()
//    var pikerView: UIPickerView!
}

extension TextEntryCell: UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if cardDetailCellType == CardDetailSectionCellType.expirationDate  {
            return 2
        }
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if cardDetailCellType == CardDetailSectionCellType.expirationDate  {
            return component == 0 ? months.count : years.count
        }
        return myValues.count
    }
}

extension TextEntryCell: UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if cardDetailCellType == CardDetailSectionCellType.expirationDate  {
            return component == 0 ? months[row] : years[row]
        }
        return myValues[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if cardDetailCellType == CardDetailSectionCellType.expirationDate  {
            textField.text = months[row] + "/" + years[row]
        }
        if addressCellType == AddressSectionCellType.state{
            textField.text = myValues[row]
            textField.resignFirstResponder()
        }
        delegate?.didUpdateField(textField.text!, cardDetailCellType, addressCellType)
    }
    
}

extension TextEntryCell: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let currentText = textField.text else { return true }
        let expectedText = (currentText as NSString).replacingCharacters(in: range, with: string)
        if cardDetailCellType == CardDetailSectionCellType.expirationDate  {
            if currentText.count == 2 {
                textField.text = textField.text! + "/"
            }
            
            if expectedText.count > 5 {
                return false
            }
        }
        delegate?.didUpdateField(expectedText, cardDetailCellType, addressCellType)
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
