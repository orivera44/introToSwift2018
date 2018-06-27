//
//  DetailViewController.swift
//  FinalProject_OR
//
//  Created by Oscar Rivera on 6/3/18.
//  Copyright © 2018 Oscar Rivera. All rights reserved.
//

import UIKit
import MapKit

class DetailViewController: UIViewController {
    
    let appData = AppData.shared
    
    var buildingPermit: BuildingPermit!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationController(buildingPermit.buildingPermitId)
        tableView.reloadData()
    }

}

extension DetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        let sectionType = BuildingPermitSectionType(rawValue: section)!
        switch sectionType {
        case .map:
            return 0
        case .status:
            return 40
        case .info:
            return 40
        case .owner:
            return 40
        case .location:
            return 40
        }
    }
}

extension DetailViewController: UITableViewDataSource {
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
            return MapSectionGroup.count
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
            let cellType = MapSectionGroup(rawValue: indexPath.row)!
            return mapCellFor(cellType, indexPath)
        case .status:
            let cellType = StatusSectionGroup(rawValue: indexPath.row)!
            return statusCellFor(cellType, indexPath)
        case .info:
            let cellType = InfoSectionGroup(rawValue: indexPath.row)!
            return infoCellFor(cellType, indexPath)
        case .owner:
            let cellType = OwnerSectionGroup(rawValue: indexPath.row)!
            return ownerCellFor(cellType, indexPath)
        case .location:
            let cellType = LocationSectionGroup(rawValue: indexPath.row)!
            return locationCellFor(cellType, indexPath)
        }
    }
    
    private func mapCellFor(_ cellType: MapSectionGroup, _ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "textDetailCell", for: indexPath) as! TextDetailCell
        cell.titleLabel.text = cellType.txt
        switch cellType {
        case .location:
            let cellMap = tableView.dequeueReusableCell(withIdentifier: "mapCell", for: indexPath) as! MapCell
            if let lat = buildingPermit.latitude, let doubleLat = Double(lat) {
                if let lon = buildingPermit.longitude, let doubleLon = Double(lon) {
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = CLLocationCoordinate2D(latitude: doubleLat, longitude: doubleLon)
                    cellMap.mapView.addAnnotation(annotation)
                    let span = MKCoordinateSpanMake(0.3, 0.3)
                    let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: doubleLat, longitude: doubleLon), span: span)
                    cellMap.mapView.setRegion(region, animated: true)
                    return cellMap
                }
            }
            return cellMap
        }
    }
    
    private func statusCellFor(_ cellType: StatusSectionGroup, _ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "textDetailCell", for: indexPath) as! TextDetailCell
        cell.titleLabel.text = cellType.txt
        switch cellType {
        case .buildingPermitStatus:
            cell.dataLabel.text = buildingPermit.statusBuildingPermit?.rawValue
        }
        return cell
    }
    
    private func infoCellFor(_ cellType: InfoSectionGroup, _ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "textDetailCell", for: indexPath) as! TextDetailCell
        cell.titleLabel.text = cellType.txt
        switch cellType {
        case .buildingPermitId:
            cell.dataLabel.text = (buildingPermit.buildingPermitId != nil) ? buildingPermit.buildingPermitId : "N/A"
        case .type:
            cell.dataLabel.text = (buildingPermit.type != nil) ? buildingPermit.type?.rawValue : "N/A"
        case .catasdre:
            cell.dataLabel.text = (buildingPermit.cadastre != nil) ? buildingPermit.cadastre : "N/A"
        case .yearMonth:
            cell.dataLabel.text = (buildingPermit.yearOfEstablishment != nil) ? buildingPermit.yearOfEstablishment : "N/A"
        case .cost:
            cell.dataLabel.text = buildingPermit.estimatedCostFormatted
        }
        return cell
    }
    
    private func ownerCellFor(_ cellType: OwnerSectionGroup, _ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "textDetailCell", for: indexPath) as! TextDetailCell
        cell.titleLabel.text = cellType.txt
        switch cellType {
        case .owner:
            cell.dataLabel.text = (buildingPermit.owner != nil) ? buildingPermit.owner : "N/A"
        case .investor:
            cell.dataLabel.text = (buildingPermit.investor != nil) ? buildingPermit.investor?.rawValue : "N/A"
        case .sector:
            cell.dataLabel.text = (buildingPermit.sector != nil) ? buildingPermit.sector?.rawValue : "N/A"
        }
        return cell
    }
    
    private func locationCellFor(_ cellType: LocationSectionGroup, _ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "textDetailCell", for: indexPath) as! TextDetailCell
        cell.titleLabel.text = cellType.txt
        switch cellType {
        case .city:
            cell.dataLabel.text = (buildingPermit.town != nil) ? buildingPermit.town : "N/A"
        case .address:
            cell.dataLabel.text = (buildingPermit.address != nil) ? buildingPermit.address : "N/A"
        }
        return cell
    }
    
}
