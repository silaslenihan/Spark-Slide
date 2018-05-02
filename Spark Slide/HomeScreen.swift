//
//  homeScreen.swift
//  Spark Slide
//
//  Created by Silas lenihan on 1/30/18.
//  Copyright © 2018 Silas lenihan. All rights reserved.
//

import Foundation
import UIKit

class HomeScreen: UIViewController {
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = UIColor(patternImage: UIImage(named:"Spark Slide Background")!)
        
    }
   
}
