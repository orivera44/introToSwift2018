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

enum LocationTypeEnum: String, Codable {
    case point = "Point"
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

enum Type: String, Codable {
    case buildingPermitType = "Permiso Construccion"
    case buildingPermitCertType = "Permiso Construccion Cert."
}

