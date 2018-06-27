//
//  BuildingPermitAddController.swift
//  FinalProject_OR
//
//  Created by Oscar Rivera on 6/26/18.
//  Copyright © 2018 Oscar Rivera. All rights reserved.
//

import UIKit

protocol AddBuildingPermitDelegate: class {
    func didPressSaveButton(_ buildingPermit: BuildingPermit)
}


class BuildingPermitAddController: UIViewController {
    
    var newBuildingPermit = BuildingPermit()
    weak var addDelegate: AddBuildingPermitDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
        
        configureNavigationController("Nuevo Favorito")
//        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonPressed))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "save"), style: .plain, target: self, action: #selector(saveButtonPressed))
        navigationItem.rightBarButtonItem?.tintColor = .white
        navigationItem.rightBarButtonItem?.isEnabled = false
        tableView.separatorStyle = .none
        
        newBuildingPermit.latitude = "18.4654917"
        newBuildingPermit.longitude = "-66.1190186"
        newBuildingPermit.favorite = true
    }
   

    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.keyboardDismissMode = .onDrag
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}


extension BuildingPermitAddController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        resignFirstResponder()
        self.view.endEditing(true)
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: "textEntryCell", for: indexPath) as! TextEntryCell
        cell.textField.text = ""
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont(name: "Futura", size: 17)!
        header.textLabel?.textColor = UIColor.lightGray
    }
}

extension BuildingPermitAddController: UITableViewDataSource{
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return BuildingPermitSectionType.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return BuildingPermitSectionType(rawValue: section)?.txt
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionType = BuildingPermitSectionType(rawValue: section)!
        switch sectionType {
        case .map:
            return 0
        case .status:
            return StatusSectionGroup.count
        case .info:
            return InfoSectionGroup.count
        case .owner:
            return OwnerSectionGroup.count
        case .location:
            return LocationSectionGroup.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionType = BuildingPermitSectionType(rawValue: indexPath.section)!
        
        switch sectionType {
        case .map:
            return UITableViewCell()
        case .status:
            let cellType = StatusSectionGroup(rawValue: indexPath.row)!
            return statusDetailCellFor(cellType, indexPath)
        case .info:
            let cellType = InfoSectionGroup(rawValue: indexPath.row)!
            return infoDetailCellFor(cellType, indexPath)
        case .owner:
            let cellType = OwnerSectionGroup(rawValue: indexPath.row)!
            return ownerDetailCellFor(cellType, indexPath)
        case .location:
            let cellType = LocationSectionGroup(rawValue: indexPath.row)!
            return locationDetailCellFor(cellType, indexPath)
        }
    }
    
    private func statusDetailCellFor(_ cellType: StatusSectionGroup, _ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "textEntryCell", for: indexPath) as! TextEntryCell
        cell.fieldName.text = cellType.txt
                cell.delegate = self
        cell.statusSectionGroup = cellType
        cell.textField.inputView = nil
        switch cellType {
        case .buildingPermitStatus:
            cell.textField.becomeFirstResponder()
            cell.textField.inputView = cell.pikerView
            cell.textField.text = newBuildingPermit.statusBuildingPermit?.rawValue
            break
        }
        
        return cell
    }
    
    private func infoDetailCellFor(_ cellType: InfoSectionGroup, _ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "textEntryCell", for: indexPath) as! TextEntryCell
        cell.fieldName.text = cellType.txt
        cell.delegate = self
        cell.infoSectionGroup = cellType
        cell.textField.inputView = nil
        switch cellType {
        case .buildingPermitId:
            cell.textField.keyboardType = .default
            cell.textField.text = newBuildingPermit.buildingPermitId
            break
        case .type:
            cell.textField.inputView = cell.pikerView
            cell.textField.text = newBuildingPermit.type?.rawValue
            break
        case .catasdre:
            cell.textField.keyboardType = .default
            cell.textField.text = newBuildingPermit.cadastre
            break
        case .yearMonth:
            cell.textField.inputView = cell.pikerView
            cell.textField.text = newBuildingPermit.radicationYearMonth
            break
        case . cost:
            cell.textField.keyboardType = .numberPad
            cell.textField.text = newBuildingPermit.estimatedCost
            break
        }
        
        return cell
    }
    
    private func ownerDetailCellFor(_ cellType: OwnerSectionGroup, _ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "textEntryCell", for: indexPath) as! TextEntryCell
        cell.fieldName.text = cellType.txt
                cell.delegate = self
        cell.ownerSectionGroup = cellType
        cell.textField.inputView = nil
        switch cellType {
        case .owner:
            cell.textField.keyboardType = .default
            cell.textField.text = newBuildingPermit.owner
            break
        case .investor:
            cell.textField.inputView = cell.pikerView
            cell.textField.text = newBuildingPermit.investor?.rawValue
            break
        case .sector:
            cell.textField.inputView = cell.pikerView
            cell.textField.text = newBuildingPermit.sector?.rawValue
            break
        }
        
        return cell
    }
    
    private func locationDetailCellFor(_ cellType: LocationSectionGroup, _ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "textEntryCell", for: indexPath) as! TextEntryCell
        cell.fieldName.text = cellType.txt
                cell.delegate = self
        cell.locationSectionGroup = cellType
        cell.textField.inputView = nil
        switch cellType {
        case .address:
            cell.textField.keyboardType = .default
            cell.textField.text = newBuildingPermit.address
            break
        case .city:
            cell.textField.keyboardType = .default
            cell.textField.text = newBuildingPermit.town
            break
        }
        
        return cell
    }
    
    @objc private func saveButtonPressed() {
        self.addDelegate?.didPressSaveButton(newBuildingPermit)
    }
    
    private func updateSaveButton() {
        navigationItem.rightBarButtonItem?.isEnabled = areDetailsFilledOut
    }
    
    var areDetailsFilledOut: Bool {
//        return !(newBuildingPermit.buildingPermitId?.isEmpty)! && !(newBuildingPermit.cadastre?.isEmpty)! && !(newBuildingPermit.radicationYearMonth?.isEmpty)! && !(newBuildingPermit.estimatedCost?.isEmpty)! && !(newBuildingPermit.owner?.isEmpty)! && !(newBuildingPermit.address?.isEmpty)! && !(newBuildingPermit.town?.isEmpty)!
        return (newBuildingPermit.statusBuildingPermit != nil) && (newBuildingPermit.buildingPermitId != nil) && (newBuildingPermit.type != nil) && (newBuildingPermit.cadastre != nil) && (newBuildingPermit.radicationYearMonth != nil) && (newBuildingPermit.estimatedCost != nil) && (newBuildingPermit.owner != nil) && (newBuildingPermit.investor != nil) && (newBuildingPermit.sector != nil) && (newBuildingPermit.address != nil) && (newBuildingPermit.town != nil)
    }
    
}

extension BuildingPermitAddController: TextEntryDelegate {
    
    func didUpdateField(_ text: String, _ statusSectionGroup: StatusSectionGroup?, _ infoSectionGroup: InfoSectionGroup?, _ ownerSectionGroup: OwnerSectionGroup?, _ locationSectionGroup: LocationSectionGroup?) {
        
        if let statusType = statusSectionGroup {
            newBuildingPermit = newBuildingPermit.updateStatusDetail(statusType, text)
        } else if let infoDetail = infoSectionGroup {
            newBuildingPermit = newBuildingPermit.updateInfoDetail(infoDetail, text)
        } else if let ownerDetail = ownerSectionGroup {
            newBuildingPermit = newBuildingPermit.updateOwnerDetail(ownerDetail, text)
        } else if let infoLocation = locationSectionGroup {
            newBuildingPermit = newBuildingPermit.updateLocationDetail(infoLocation, text)
        }
        updateSaveButton()
    }
}

extension BuildingPermitAddController {
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
