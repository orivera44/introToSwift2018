//
//  Message.swift
//  Homework3_OR
//
//  Created by Oscar Rivera on 4/9/18.
//  Copyright © 2018 Oscar Rivera. All rights reserved.
//

import UIKit

enum MessageState: Int {
    case pending = 1
    case sent = 2
    case failed = 3
    
    
    var txt: String{
        switch self {
        case .pending:
            return "Pending"
        case .sent:
            return "Sent"
        case .failed:
            return "Failed"
        }
    }
}


struct Message {
    var fromName: String
    var body: String
    var state: MessageState
}

extension Message{
    var stateLabel: String{
        return "State: \(state.txt)"
    }
}

extension Message {

    static var defaultData: [Message] = [Message.init(fromName: "Maria", body: "We are in this for the long haul. We are in this for the long haul. We are in this for the long haul. We are in this for the long haul. We are in this for the long haul. We are in this for the long haul. We are in this for the long haul. We are in this for the long haul. We are in this for the long haul. We are in this for the long haul. We are in this for the long haul.", state: MessageState.pending), Message.init(fromName: "Antonio", body: "Vamos jugar poker este Sabado a las diez de la tarde. Vamos jugar poker este Sabado a las diez de la tarde. Vamos jugar poker este Sabado a las diez de la tarde. Vamos jugar poker este Sabado a las diez de la tarde. Vamos jugar poker este Sabado a las diez de la tarde. Vamos jugar poker este Sabado a las diez de la tarde. Vamos jugar poker este Sabado a las diez de la tarde. Vamos jugar poker este Sabado a las diez de la tarde. Vamos jugar poker este Sabado a las diez de la tarde.", state: MessageState.sent), Message.init(fromName: "Ricardo", body: "I need to go to the grocery store, I have no food at home. I need to go to the grocery store, I have no food at home. I need to go to the grocery store, I have no food at home. I need to go to the grocery store, I have no food at home. I need to go to the grocery store, I have no food at home. I need to go to the grocery store, I have no food at home. I need to go to the grocery store, I have no food at home.", state: MessageState.failed), Message.init(fromName: "Jessica", body: "Would you like to go to the movies tomorrow, quiero ver esa pelicula. Would you like to go to the movies tomorrow, quiero ver esa pelicula. Would you like to go to the movies tomorrow, quiero ver esa pelicula. Would you like to go to the movies tomorrow, quiero ver esa pelicula. Would you like to go to the movies tomorrow, quiero ver esa pelicula. Would you like to go to the movies tomorrow, quiero ver esa pelicula.", state: MessageState.pending), Message.init(fromName: "Alex", body: "Voy para la casa de mi mai esta manana. Voy para la casa de mi mai esta manana. Voy para la casa de mi mai esta manana. Voy para la casa de mi mai esta manana. Voy para la casa de mi mai esta manana. Voy para la casa de mi mai esta manana. Voy para la casa de mi mai esta manana. Voy para la casa de mi mai esta manana.", state: MessageState.sent)]
    
}
