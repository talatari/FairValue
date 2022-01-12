//
//  ViewController.swift
//  TestingNewProject
//
//  Created by Tsaplin-SO on 09.01.2022.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var btnChangeText: UIButton!
    
    @IBOutlet weak var lblText: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
    }


    
    @IBAction func changeText(_ sender: Any) {
        
        lblText.text = "1"
        
    }
    
}

