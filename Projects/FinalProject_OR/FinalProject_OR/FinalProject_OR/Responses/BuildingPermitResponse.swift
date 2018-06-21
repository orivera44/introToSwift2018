//
//  BuildPermitResponse.swift
//  FinalProject_OR
//
//  Created by Oscar Rivera on 5/24/18.
//  Copyright © 2018 Oscar Rivera. All rights reserved.
//

import UIKit

struct BuildingPermitResponse: Codable {
    var next: String = ""
    var results: [BuildingPermit] = []
    
}
