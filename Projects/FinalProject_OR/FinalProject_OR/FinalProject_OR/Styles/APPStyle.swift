//
//  APPStyle.swift
//  FinalProject_OR
//
//  Created by Oscar Rivera on 5/27/18.
//  Copyright © 2018 Oscar Rivera. All rights reserved.
//

import UIKit
import Foundation

protocol ButtonStyleAttribiute {
    var cornerRadius: CGFloat { get }
    var backgroundColor: UIColor { get }
    var titleColor: UIColor { get }
}

protocol LabelStyleAttribute {
    var font: UIFont { get }
    var textColor: UIColor { get }
}

struct StandardButton: ButtonStyleAttribiute {
    var cornerRadius: CGFloat = 5.0
    var backgroundColor: UIColor = UIColor.deepBlue
    var titleColor: UIColor = UIColor.white
}

struct HighlightButton: ButtonStyleAttribiute {
    var cornerRadius: CGFloat = 5.0
    var backgroundColor: UIColor = UIColor.gray
    var titleColor: UIColor = UIColor.deepBlue
}

struct ButtonStyle {
    static let standard = StandardButton()
    static let highlight = HighlightButton()
}

struct StandardLabel: LabelStyleAttribute {
    var font: UIFont = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.medium)
    var textColor: UIColor = UIColor.deepBlue
}

struct TitleLabel: LabelStyleAttribute {
    var font: UIFont = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.medium)
    var textColor: UIColor = UIColor.principalBlue
}

struct TextLabel: LabelStyleAttribute {
    var font: UIFont = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.medium)
    var textColor: UIColor = UIColor.lightGray
}

struct InfoLabel: LabelStyleAttribute {
    var font: UIFont = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.light)
    var textColor: UIColor = UIColor.lightGray
}

struct LabelStyle {
    static let standard = StandardLabel()
    static let text = TextLabel()
    static let info = InfoLabel()
    static let titleList = TitleLabel()
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

extension UILabel {
    func apply(_ attribute: LabelStyleAttribute){
        self.textColor = attribute.textColor
        self.font = attribute.font
    }
    
    func apply(_ attribute: LabelStyleAttribute, with text: String){
        self.font = attribute.font
        self.text = text
    }
}
