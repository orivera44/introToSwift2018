//
//  BuildingPermit.swift
//  FinalProject_OR
//
//  Created by Oscar Rivera on 5/20/18.
//  Copyright © 2018 Oscar Rivera. All rights reserved.
//

import UIKit

struct BuildingPermit: Codable {
    let yearOfEstablishment: String?
    let statusBuildingPermit: StatusBuildingPermit?
    let buildingPermitId: String?
    let cadastre: String?
    let estimatedCost: String?
    let address: String?
    let owner: String?
    let awardDate: String?
    let radicationDate: String?
    let radicationYearMonth: String?
    let town: String?
    let projectName: String?
    let investor: Investor?
    let settledByPa: SettledByPa?
    let district: District?
    let sector: Sector?
    let acronym: Acronym?
    let status: Status?
    let type: Type?
    let location: Location?
    let latitude: String?
    let longitude: String?
    let pointX: String?
    let pointY: String?
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
