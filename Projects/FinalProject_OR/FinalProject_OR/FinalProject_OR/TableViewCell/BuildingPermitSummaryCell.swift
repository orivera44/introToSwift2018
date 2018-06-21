//
//  BuildingPermitSummaryCell.swift
//  FinalProject_OR
//
//  Created by Oscar Rivera on 5/27/18.
//  Copyright © 2018 Oscar Rivera. All rights reserved.
//

import UIKit

class BuildingPermitSummaryCell: UITableViewCell {
    
    @IBOutlet weak var statusImage: UIImageView!
    @IBOutlet weak var viewOverlay: UIView!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var favoriteImage: UIImageView!
    
    @IBOutlet weak var addressLabel: UILabel!{
        didSet{
            addressLabel.apply(LabelStyle.info)
        }
    }
    
    @IBOutlet weak var nameLabel: UILabel!{
        didSet{
            nameLabel.apply(LabelStyle.text)
        }
    }
    
    @IBOutlet weak var buildingPermitIdLabel: UILabel!{
        didSet{
            buildingPermitIdLabel.apply(LabelStyle.text)
        }
    }
    
    @IBOutlet weak var cityLabel: UILabel!{
        didSet{
            cityLabel.apply(LabelStyle.titleList)
        }
    }
    
    @IBOutlet weak var costLabel: UILabel!{
        didSet{
            costLabel.apply(LabelStyle.standard)
        }
    }
    
    @IBOutlet weak var yearLabel: UILabel!{
        didSet{
            yearLabel.apply(LabelStyle.standard)
        }
    }
    
    func configure(with buildingPermit: BuildingPermit, at indexPath: Int) {
        let buildingPermitId = buildingPermit.buildingPermitId ?? "N/A"
        let city = buildingPermit.town ?? "N/A"
        let year = buildingPermit.yearOfEstablishment ?? "N/A"
        let name = buildingPermit.projectName ?? "N/A"
        let address = buildingPermit.address ?? "N/A"
        let cost = buildingPermit.estimatedCostFormatted
        
        buildingPermitIdLabel.text = "\(buildingPermitId)"
        cityLabel.text = "\(city)"
        yearLabel.text = "\(year)"
        costLabel.text = "\(cost)"
        nameLabel.text = "\(name)"
        addressLabel.text = "\(address)"
        statusImage.image = (buildingPermit.isGranted) ? #imageLiteral(resourceName: "permitcompleted") : #imageLiteral(resourceName: "permitpending")
        favoriteImage.image = (buildingPermit.isFavorite) ? #imageLiteral(resourceName: "icons8-heart-outline-filled-50") : #imageLiteral(resourceName: "icons8-heart-outline-50")
        favoriteButton.tag = indexPath
    }
}
