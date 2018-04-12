//
//  ViewController.swift
//  Homework3_OR
//
//  Created by Oscar Rivera on 4/9/18.
//  Copyright © 2018 Oscar Rivera. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var messages: [Message] = []
    
    @IBOutlet var messageButtons: [UIButton]!

    @IBOutlet weak var fromLabel: UILabel!
    
    @IBOutlet weak var bodyLabel: UILabel!
    
    @IBOutlet weak var stateLabel: UILabel!
    
    
    //    @IBOutlet var labelList: [UILabel]!{
//        didSet {
//            for label in labelList {
//                label.apply(LabelStyle.standard)
//            }
//        }
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
        loadMessages()
        comnfigureButton()
        configureNavigationBar()

        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    private func loadMessages(){
        messages = Message.defaultData
    }
    
    @objc private func refreshButtonPressed(sender: UIBarButtonItem!) {
        print("MyRefreshButtonPressed")
    }
    
    @objc private func editButtonPressed(sender: UIBarButtonItem!) {
        print("MyEditButtonPressed")
    }
    
    private func configureNavigationBar(){
        title = "Messages"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Refresh", style: UIBarButtonItemStyle.plain, target: self, action: #selector(refreshButtonPressed(sender:)))
        navigationItem.leftBarButtonItem?.tintColor = .darkGray
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: UIBarButtonItemStyle.plain, target: self, action: #selector(editButtonPressed(sender:)))
        navigationItem.rightBarButtonItem?.isEnabled = false
        navigationItem.rightBarButtonItem?.tintColor = .darkGray
    }
    
    @IBAction func messageButtonPressed(_ sender: UIButton){
        let message = messages[sender.tag-1]
        fromLabel.apply(LabelStyle.standard, with: message.fromName)
        bodyLabel.apply(LabelStyle.standard, with: message.body)
        stateLabel.apply(LabelStyle.standard, with: message.stateLabel)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func comnfigureButton(){
        
        for button in messageButtons {
            //button.apply(ButtonStyle.standard)
            let index = button.tag - 1
            let message = messages[index]
            button.apply(ButtonStyle.standard, with: message.fromName)
        }

    }

   
    
}

