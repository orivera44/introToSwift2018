//
//  UIViewControllerExtensions.swift
//  FinalProject_OR
//
//  Created by Oscar Rivera on 6/19/18.
//  Copyright © 2018 Oscar Rivera. All rights reserved.
//

import UIKit

extension UIViewController{
    
    func configureNavigationController(_ with: String? = nil) {
        title = with
        navigationController?.navigationBar.barTintColor = .principalBlue
        let attributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = attributes
    }
    
}
