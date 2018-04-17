//
//  ColorViewModel.swift
//  Homework5_OR
//
//  Created by Oscar Rivera on 4/16/18.
//  Copyright © 2018 Oscar Rivera. All rights reserved.
//

import UIKit

class ColorViewModel {
    var name: String
    var color: UIColor
    var isSelected: Bool

    init(name: String, color: UIColor, isSelected: Bool) {
        self.name = name
        self.color = color
        self.isSelected = isSelected
    }
}
