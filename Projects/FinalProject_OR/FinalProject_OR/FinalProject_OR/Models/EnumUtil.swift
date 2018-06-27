//
//  EnumUtil.swift
//  FinalProject_OR
//
//  Created by Oscar Rivera on 5/20/18.
//  Copyright © 2018 Oscar Rivera. All rights reserved.
//

import UIKit

enum StatusBuildingPermit: String, Codable {
    case granted = "Adjudicado"
    case pending = "Pendiente"
}

enum StatusBuildingPermitAdd: Int, Codable {
    case granted = 0
    case pending = 1
    
    static var count: Int { return StatusBuildingPermitAdd.pending.hashValue + 1 }
    
    var description: String {
        switch self {
        case .granted: return "Adjudicado"
        case .pending: return "Pendiente"
        }
    }
}

enum LocationTypeEnum: String, Codable {
    case point = "Point"
}

enum InvestorAdd: Int, Codable {
    case together = 0
    case propietary = 1
    case overt = 2
    
    static var count: Int { return InvestorAdd.overt.hashValue + 1 }
    
    var description: String {
        switch self {
        case .together: return "Alianza Público Privada"
        case .propietary: return "Privado"
        case .overt: return "Público"
        }
    }
}

enum Investor: String, Codable {
    case together = "Alianza Público Privada"
    case propietary = "Privado"
    case overt = "Público"
}

enum SettledByPa: String, Codable {
    case no = "No"
    case yes = "Si"
}

enum District: String, Codable {
    case aToHandle = "N/A"
    case aguadilla = "Aguadilla"
    case arecibo = "Arecibo"
    case central = "Central"
    case humacao = "Humacao"
    case ponce = "Ponce"
}

enum SectorAdd: Int, Codable {
    case rural = 0
    case urban = 1
    
    static var count: Int { return SectorAdd.urban.hashValue + 1 }
    
    var description: String {
        switch self {
        case .rural: return "Rural"
        case .urban: return "Urbano"
        }
    }
}

enum Sector: String, Codable {
    case rural = "Rural"
    case urban = "Urbano"
}

enum Acronym: String, Codable {
    case pcoCert = "PCO-CERT"
    case pcoConv = "PCO-CONV"
}

enum Status: String, Codable {
    case canceled = "Cancelado"
    case denied = "Denegado"
    case rectification = "En Subsanación"
    case issued = "Expedido"
    case preApproved = "Pre-aprobado"
    case evaluation = "Evaluación"
    case validation = "Validación"
}

enum Type1: Int, Codable {
    case buildingPermitType = 0
    case buildingPermitCertType = 1

    static var count: Int { return Type.buildingPermitCertType.hashValue + 1 }

    var description: String {
        switch self {
        case .buildingPermitType: return "Permiso Construcción"
        case .buildingPermitCertType : return "Permiso Construccion Cert."
        }
    }
}

enum Type: String, Codable {
    case buildingPermitType = "Permiso Construccion"
    case buildingPermitCertType = "Permiso Construccion Cert."
    
    static var count: Int {
        return 2
    }
    
}

