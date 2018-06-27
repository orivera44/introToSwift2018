//
//  TextEntryCell.swift
//  FinalProject_OR
//
//  Created by Oscar Rivera on 6/26/18.
//  Copyright © 2018 Oscar Rivera. All rights reserved.
//

import UIKit

protocol TextEntryDelegate: class {
    func didUpdateField(_ text: String, _ statusSectionGroup: StatusSectionGroup?, _ infoSectionGroup: InfoSectionGroup?, _ ownerSectionGroup: OwnerSectionGroup?, _ locationSectionGroup: LocationSectionGroup?)
}

class TextEntryCell: UITableViewCell {
    
    private let radicationYear = [ "2010","2011","2012","2013","2014","2015","2016","2017","2018","2019","2020","2021"]
    
    @IBOutlet weak var textField: UITextField! {
        didSet{
            textField.delegate = self
            pikerView.delegate = self
            pikerView.dataSource = self
        }
    }
    
    @IBOutlet weak var fieldName: UILabel! {
        didSet{
            fieldName.apply(LabelStyle.info)
        }
    }
    
    var pikerView = UIPickerView()
    
    weak var delegate: TextEntryDelegate?
    var statusSectionGroup: StatusSectionGroup? = nil
    var infoSectionGroup: InfoSectionGroup? = nil
    var ownerSectionGroup: OwnerSectionGroup? = nil
    var locationSectionGroup: LocationSectionGroup? = nil
    
}

extension TextEntryCell: UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if infoSectionGroup == InfoSectionGroup.type {
            return Type1.count
        }
        if statusSectionGroup == StatusSectionGroup.buildingPermitStatus {
            return StatusBuildingPermitAdd.count
        }
        if infoSectionGroup == InfoSectionGroup.yearMonth {
            return radicationYear.count
        }
        if ownerSectionGroup == OwnerSectionGroup.investor {
            return InvestorAdd.count
        }
        if ownerSectionGroup == OwnerSectionGroup.sector {
            return SectorAdd.count
        }
        return 0
    }
}

extension TextEntryCell: UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if infoSectionGroup == InfoSectionGroup.type  {
            return Type1(rawValue: row)?.description
        }
        if statusSectionGroup == StatusSectionGroup.buildingPermitStatus {
            return StatusBuildingPermitAdd(rawValue: row)?.description
        }
        if infoSectionGroup == InfoSectionGroup.yearMonth {
            return radicationYear[row]
        }
        if ownerSectionGroup == OwnerSectionGroup.investor {
            return InvestorAdd(rawValue: row)?.description
        }
        if ownerSectionGroup == OwnerSectionGroup.sector {
            return SectorAdd(rawValue: row)?.description
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if infoSectionGroup == InfoSectionGroup.type  {
            textField.text = Type1(rawValue: row)?.description
        }
        if statusSectionGroup == StatusSectionGroup.buildingPermitStatus {
            textField.text = StatusBuildingPermitAdd(rawValue: row)?.description
        }
        if infoSectionGroup == InfoSectionGroup.yearMonth {
            textField.text = radicationYear[row]
        }
        if ownerSectionGroup == OwnerSectionGroup.investor {
            textField.text = InvestorAdd(rawValue: row)?.description
        }
        if ownerSectionGroup == OwnerSectionGroup.sector {
            textField.text = SectorAdd(rawValue: row)?.description
        }
        
        delegate?.didUpdateField(textField.text!, statusSectionGroup, infoSectionGroup, ownerSectionGroup, locationSectionGroup)
    }
    
}

extension TextEntryCell: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let currentText = textField.text else { return true }
        let expectedText = (currentText as NSString).replacingCharacters(in: range, with: string)
        
        delegate?.didUpdateField(expectedText, statusSectionGroup, infoSectionGroup, ownerSectionGroup, locationSectionGroup)
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
