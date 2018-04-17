//
//  ViewController.swift
//  Homework5_OR
//
//  Created by Oscar Rivera on 4/16/18.
//  Copyright © 2018 Oscar Rivera. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var colorsDictionary = [Int: [ColorViewModel]]()
    var selectedColor = [ColorViewModel]()
    

    @IBOutlet weak var segmentControl: UISegmentedControl!{
        didSet{
            segmentControl.addTarget(self, action: #selector(segmentControlValueChanged), for: .valueChanged)
        }
    }
    
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    @objc private func segmentControlValueChanged(_ sender: UISegmentedControl){
        selectedColor = colorsDictionary[sender.selectedSegmentIndex]!
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Color Table"
        colorsDictionary[0] = ColorManager.generateColors(typeColor: typeColor.RED, numberOfColors: 100)
        colorsDictionary[1] = ColorManager.generateColors(typeColor: typeColor.BLUE, numberOfColors: 100)
        colorsDictionary[2] = ColorManager.generateColors(typeColor: typeColor.RANDOM, numberOfColors: 100)
        selectedColor = colorsDictionary[0]!
        tableView.reloadData()

    }
    
}

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedColor.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let colorViewModel = selectedColor[indexPath.row]
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.backgroundColor = colorViewModel.color
        cell.textLabel?.text = colorViewModel.name
        cell.textLabel?.textColor = UIColor.white
        if colorViewModel.isSelected {
            cell.accessoryType = .checkmark
        }
        return cell
    }
}

extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = selectedColor[indexPath.row]
        item.isSelected = !item.isSelected
        selectedColor[indexPath.row] = item
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
