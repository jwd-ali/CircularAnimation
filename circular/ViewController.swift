//
//  ViewController.swift
//  circular
//
//  Created by Jawad Ali on 09/05/2020.
//  Copyright © 2020 Jawad Ali. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let circle = CirclesView()
          self.view.addSubview(circle)
        
        circle.translatesAutoresizingMaskIntoConstraints = false
        circle.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        circle.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        circle.widthAnchor.constraint(equalToConstant: 120).isActive = true
        circle.heightAnchor.constraint(equalToConstant: 120).isActive = true
        
      
        // Do any additional setup after loading the view.
    }


}

