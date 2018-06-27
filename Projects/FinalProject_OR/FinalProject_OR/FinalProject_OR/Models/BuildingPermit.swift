//
//  BuildingPermit.swift
//  FinalProject_OR
//
//  Created by Oscar Rivera on 5/20/18.
//  Copyright © 2018 Oscar Rivera. All rights reserved.
//

import UIKit

struct BuildingPermit: Codable {
    var yearOfEstablishment: String?
    var statusBuildingPermit: StatusBuildingPermit?
    var buildingPermitId: String?
    var cadastre: String?
    var estimatedCost: String?
    var address: String?
    var owner: String?
    var awardDate: String?
    var radicationDate: String?
    var radicationYearMonth: String?
    var town: String?
    var projectName: String?
    var investor: Investor?
    var settledByPa: SettledByPa?
    var district: District?
    var sector: Sector?
    var acronym: Acronym?
    var status: Status?
    var type: Type?
    var location: Location?
    var latitude: String?
    var longitude: String?
    var pointX: String?
    var pointY: String?
    var favorite: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case yearOfEstablishment = "a_o_de_radicaci_n"
        case statusBuildingPermit = "adjudicado_o_pendiente"
        case buildingPermitId = "caso"
        case cadastre = "catastro"
        case estimatedCost = "costo_estimado"
        case address = "direcci_n"
        case owner = "due_o_del_proyecto"
        case awardDate = "fecha_de_adjudicaci_n"
        case radicationDate = "fecha_de_radicaci_n"
        case radicationYearMonth = "mes_de_radicaci_n"
        case town = "municipio"
        case projectName = "nombre_del_proyecto"
        case investor = "publico_o_privado"
        case settledByPa = "radicado_por_pa"
        case district = "regi_n"
        case sector = "rural_o_urbano"
        case acronym = "siglas"
        case status = "status"
        case type = "tr_mite"
        case latitude = "lat"
        case longitude = "lon"
        case location = "location_1"        
        case pointX = "x"
        case pointY = "y"
    }
}

extension BuildingPermit {
    
    var estimatedCostFormatted: String {
        guard Double(estimatedCost!) != nil else { return "N/A" }
        
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale.current
        
        if let cost = Double(estimatedCost!) {
            let priceString = currencyFormatter.string(from: NSNumber(value: cost))
            return priceString!
        } else {
            return "N/A"
        }
        
    }
    
    var isGranted: Bool {
        if statusBuildingPermit == StatusBuildingPermit.granted {
            return true
        }
        return false
    }
    
    var isFavorite: Bool {
        return favorite
    }
}

extension BuildingPermit {
    
    mutating func updateStatusDetail(_ type: StatusSectionGroup, _ value: String) -> BuildingPermit {
        switch type {
        case .buildingPermitStatus:
            self.statusBuildingPermit = StatusBuildingPermit.init(rawValue: value)
        }
        return self
    }
    
    mutating func updateInfoDetail(_ type: InfoSectionGroup, _ value: String) -> BuildingPermit {
        switch type {
        case .buildingPermitId:
            self.buildingPermitId = value
        case .catasdre:
            self.cadastre = value
        case .type:
            self.type = Type.init(rawValue: value)
        case .yearMonth:
            self.radicationYearMonth = value
        case .cost:
            self.estimatedCost = value
        }
        return self
    }
    
    mutating func updateOwnerDetail(_ type: OwnerSectionGroup, _ value: String) -> BuildingPermit {
        switch type {
        case .owner:
            self.owner = value
        case .investor:
            self.investor = Investor.init(rawValue: value)
        case .sector:
            self.sector = Sector.init(rawValue: value)
        }
        return self
    }
    
    mutating func updateLocationDetail(_ type: LocationSectionGroup, _ value: String) -> BuildingPermit {
        switch type {
        case .address:
            self.address = value
        case .city:
            self.town = value
        }
        return self
    }
    
    
}
