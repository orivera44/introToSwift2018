//
//  LabelStyle.swift
//  Homework3_OR
//
//  Created by Oscar Rivera on 4/9/18.
//  Copyright © 2018 Oscar Rivera. All rights reserved.
//

import UIKit

protocol LabelStyleAttribiute {
    var fontSize: UIFont { get }
    var backgroundColor: UIColor { get }
    var textColor: UIColor { get }
}

struct StandardLabel: LabelStyleAttribiute {
    var fontSize: UIFont = UIFont.systemFont(ofSize: 20.0)
    var backgroundColor: UIColor = UIColor.white
    var textColor: UIColor = UIColor.Homework3LabelText
}

struct HighlightLabel: LabelStyleAttribiute {
    var fontSize: UIFont = UIFont.systemFont(ofSize: 20.0)
    var backgroundColor: UIColor = UIColor.white
    var textColor: UIColor = UIColor.Homework3LabelText
}

struct LabelStyle {
    static let standard = StandardLabel()
    static let highlight = HighlightLabel()
}

extension UILabel {
    func apply(_ attribute: LabelStyleAttribiute){
        self.font = attribute.fontSize
        self.backgroundColor = attribute.backgroundColor
        self.textColor = attribute.textColor
    }
    
    func apply(_ attribute: LabelStyleAttribiute, with labelText: String){
        self.font = attribute.fontSize
        self.backgroundColor = attribute.backgroundColor
        self.textColor = attribute.textColor
        self.text = labelText
    }
}
