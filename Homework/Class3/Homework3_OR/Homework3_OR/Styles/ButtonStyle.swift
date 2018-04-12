//
//  ButtonStyle.swift
//  Homework3_OR
//
//  Created by Oscar Rivera on 4/9/18.
//  Copyright © 2018 Oscar Rivera. All rights reserved.
//

import UIKit

protocol ButtonStyleAttribiute {
    var cornerRadius: CGFloat { get }
    var backgroundColor: UIColor { get }
    var titleColor: UIColor { get }
}

struct StandardButton: ButtonStyleAttribiute {
    var cornerRadius: CGFloat = 1.0
    var backgroundColor: UIColor = UIColor.Homework3Background
    var titleColor: UIColor = UIColor.Homework3Text
}

struct HighlightButton: ButtonStyleAttribiute {
    var cornerRadius: CGFloat = 1.0
    var backgroundColor: UIColor = UIColor.Homework3BackgroundLight
    var titleColor: UIColor = UIColor.Homework3Text
}

struct ButtonStyle {
    static let standard = StandardButton()
    static let highlight = HighlightButton()
}

extension UIButton {
    func apply(_ attribute: ButtonStyleAttribiute){
        self.layer.cornerRadius = attribute.cornerRadius
        self.backgroundColor = attribute.backgroundColor
        self.setTitleColor(attribute.titleColor, for: .normal)
    }
    
    func apply(_ attribute: ButtonStyleAttribiute, with title: String){
        self.layer.cornerRadius = attribute.cornerRadius
        self.backgroundColor = attribute.backgroundColor
        self.setTitleColor(attribute.titleColor, for: .normal)
        self.setTitle(title, for: .normal)
    }
}

