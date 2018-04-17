//
//  ColorManager.swift
//  Homework5_OR
//
//  Created by Oscar Rivera on 4/16/18.
//  Copyright © 2018 Oscar Rivera. All rights reserved.
//

import UIKit

enum typeColor {
    case RED
    case GREEN
    case BLUE
    case RANDOM
}

class ColorManager {
    static let maxRGBFloatValue = 255
    static var randomRGBValue: CGFloat{
        return CGFloat(arc4random_uniform(255) + 1)
    }
    
    static func generateColors(typeColor: typeColor, numberOfColors: Int) -> [ColorViewModel] {
        var colors = [ColorViewModel]()
        for _ in 0...numberOfColors{
            colors.append(self.colorValues(typeColor: typeColor))
        }
        return colors
    }
    
    static private func colorValues(typeColor: typeColor) -> ColorViewModel {
        let color: UIColor?
        let colorName: NSString?
        switch typeColor {
        case .RED:
            let redRandom = self.randomRGBValue
            color = UIColor.init(red: redRandom/CGFloat(ColorManager.maxRGBFloatValue), green: 0.0/CGFloat(ColorManager.maxRGBFloatValue), blue: 0.0/CGFloat(ColorManager.maxRGBFloatValue), alpha: 1)
            colorName = NSString(format:"R: %.0f, G: %.0f, B: %.0f, A: %d", redRandom, 0.0, 0.0,  1)
        case .BLUE:
            let blueRandom = self.randomRGBValue
            color = UIColor.init(red: 0.0/CGFloat(ColorManager.maxRGBFloatValue), green: 0.0/CGFloat(ColorManager.maxRGBFloatValue), blue: blueRandom/CGFloat(ColorManager.maxRGBFloatValue), alpha: 1)
            colorName = NSString(format:"R: %.0f, G: %.0f, B: %.0f, A: %d", 0.0, 0.0, blueRandom,  1)
        case .RANDOM:
            let redRandom = self.randomRGBValue
            let blueRandom = self.randomRGBValue
            let greenRandom = self.randomRGBValue
            color = UIColor.init(red: redRandom/CGFloat(ColorManager.maxRGBFloatValue), green: greenRandom/CGFloat(ColorManager.maxRGBFloatValue), blue: blueRandom/CGFloat(ColorManager.maxRGBFloatValue), alpha: 1)
            colorName = NSString(format:"R: %.0f, G: %.0f, B: %.0f, A: %d", redRandom, greenRandom, blueRandom,  1)
        case .GREEN:
            let greenRandom = self.randomRGBValue
            color = UIColor.init(red: 0.0/CGFloat(ColorManager.maxRGBFloatValue), green: greenRandom/CGFloat(ColorManager.maxRGBFloatValue), blue: 0.0/CGFloat(ColorManager.maxRGBFloatValue), alpha: 1)
            colorName = NSString(format:"R: %.0f, G: %.0f, B: %.0f, A: %d", 0.0, greenRandom, 0.0,  1)
        }
        
        let colorViewModel = ColorViewModel(name: String(colorName!), color: color!, isSelected: false)
        return colorViewModel
    }
    
}
