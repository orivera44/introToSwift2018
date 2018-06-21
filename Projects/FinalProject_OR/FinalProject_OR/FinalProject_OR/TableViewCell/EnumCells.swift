//
//  EnumCells.swift
//  FinalProject_OR
//
//  Created by Oscar Rivera on 6/19/18.
//  Copyright © 2018 Oscar Rivera. All rights reserved.
//

import UIKit

enum BuildingPermitSectionType: Int {
    case map = 0
    case status = 1
    case info = 2
    case owner = 3
    case location = 4
    
    var txt: String {
        switch self {
        case .map:
            return ""
        case .status:
            return "Estatus"
        case .info:
            return "Información"
        case .owner:
            return "Dueño"
        case .location:
            return "Dirección"
        }
    }
    
    static var count: Int {
        return BuildingPermitSectionType.location.rawValue + 1
    }
}

enum MapSectionGroup: Int {
    case location = 0
    
    var txt: String {
        switch self {
        case .location:
            return ""
        }
    }
    
    static var count: Int {
        return MapSectionGroup.location.rawValue + 1
    }
}

enum StatusSectionGroup: Int {
    case buildingPermitStatus = 0
    
    var txt: String {
        switch self {
        case .buildingPermitStatus:
            return "Estatus"
        }
    }
    
    static var count: Int {
        return StatusSectionGroup.buildingPermitStatus.rawValue + 1
    }
}

enum InfoSectionGroup: Int {
    case buildingPermitId = 0
    case type = 1
    case catasdre = 2
    case yearMonth = 3
    case cost = 4
    
    var txt: String {
        switch self {
        case .buildingPermitId:
            return "Caso #"
        case .type:
            return "Tramite"
        case .catasdre:
            return "Catastro"
        case .yearMonth:
            return "Radicación"
        case .cost:
            return "Costo Estimado"
        }
    }
    
    static var count: Int {
        return InfoSectionGroup.cost.rawValue + 1
    }
}

enum OwnerSectionGroup: Int {
    case owner = 0
    case investor = 1
    case sector = 2
    
    var txt: String {
        switch self {
        case .owner:
            return "Dueño"
        case .investor:
            return "Inversión"
        case .sector:
            return "Sector"
        }
    }
    
    static var count: Int {
        return OwnerSectionGroup.sector.rawValue + 1
    }
}

enum LocationSectionGroup: Int {
    case address = 0
    case city = 1
    
    var txt: String {
        switch self {
        case .address:
            return "Direccion"
        case .city:
            return "Ciudad"
        }
    }
    
    static var count: Int {
        return LocationSectionGroup.city.rawValue + 1
    }
}
