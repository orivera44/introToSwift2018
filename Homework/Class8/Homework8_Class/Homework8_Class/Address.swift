//
//  Address.swift
//  Homework8_KL
//
//  Created by Kevin Lopez on 5/1/18.
//  Copyright © 2018 io.ricoLabs. All rights reserved.
//

import UIKit

struct Address {

    var addressOne: String = ""
    var addressTwo: String = ""
    var cityTown: String = ""
    var state: String = ""
    var zipcode: String = ""
    
}

extension Address {
    var isFilledOut: Bool {
        return !cityTown.isEmpty && !state.isEmpty && !zipcode.isEmpty
    }
}
