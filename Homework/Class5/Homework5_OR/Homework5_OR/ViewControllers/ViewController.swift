//
//  ViewController.swift
//  Homework5_OR
//
//  Created by Oscar Rivera on 4/16/18.
//  Copyright © 2018 Oscar Rivera. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var namesOfIntegers = [Int: [ColorViewModel]]()
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
    
//    segmentControl.addTarget(self, action: #selector(changeWebView(sender:)), for: .valueChanged)
//    or
//    
//    addTarget(self, action: #selector(changeWebView), for: .valueChanged)
    
    @objc private func segmentControlValueChanged(_ sender: UISegmentedControl){
        selectedColor = namesOfIntegers[sender.selectedSegmentIndex]!
        tableView.reloadData()
        //print (sender.selectedSegmentIndex)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Color Table"
        
        
        namesOfIntegers[0] = ColorManager.generateColors(typeColor: typeColor.RED, numberOfColors: 100)
        namesOfIntegers[1] = ColorManager.generateColors(typeColor: typeColor.BLUE, numberOfColors: 100)
        namesOfIntegers[2] = ColorManager.generateColors(typeColor: typeColor.RANDOM, numberOfColors: 100)
        selectedColor = namesOfIntegers[0]!
//        //var dic = [1: redColorViewModels, 2: blueColorViewModels, 3: randomColorViewModels]
//
//
//        let mappedValues = dic.map { $0.value[1].name }
//        print(mappedValues)
        
        tableView.reloadData()
        //print(redColorViewModels.count)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

extension ViewController{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = selectedColor[indexPath.row]
        item.isSelected = !item.isSelected
        selectedColor[indexPath.row] = item
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
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
    
}
