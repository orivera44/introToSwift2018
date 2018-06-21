//
//  TextDetailCell.swift
//  FinalProject_OR
//
//  Created by Oscar Rivera on 6/3/18.
//  Copyright © 2018 Oscar Rivera. All rights reserved.
//

import UIKit

class TextDetailCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!{
        didSet{
            titleLabel.apply(LabelStyle.info)
        }
    }
    
    @IBOutlet weak var dataLabel: UILabel!{
        didSet{
            dataLabel.apply(LabelStyle.text)
        }
    }
    
}
