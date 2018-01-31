//
//  LevelSelect.swift
//  Spark Slide
//
//  Created by Silas lenihan on 1/31/18.
//  Copyright © 2018 Silas lenihan. All rights reserved.
//

import Foundation
import UIKit

class LevelSelect: UIViewController {
    static var preset: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = UIColor(patternImage: UIImage(named:"Spark Slide Background")!)
        
    }
    
    @IBAction func levelOne(_ sender: UIButton) {
        LevelSelect.preset = 1
        
    }
    
    @IBAction func levelTwo(_ sender: UIButton) {
        LevelSelect.preset = 2
    }
    
    @IBAction func levelThree(_ sender: UIButton) {
        LevelSelect.preset = 3
    }
    
    @IBAction func levelFour(_ sender: UIButton) {
        LevelSelect.preset = 4
    }
    
    @IBAction func levelFive(_ sender: UIButton) {
        LevelSelect.preset = 5
    }
    
    @IBAction func levelSix(_ sender: UIButton) {
        LevelSelect.preset = 6
    }
    
    @IBAction func levelSeven(_ sender: UIButton) {
        LevelSelect.preset = 7
    }
    
    @IBAction func levelEight(_ sender: UIButton) {
        LevelSelect.preset = 8
    }
    
    @IBAction func levelNine(_ sender: UIButton) {
        LevelSelect.preset = 9
    }
    
    @IBAction func levelTen(_ sender: UIButton) {
        LevelSelect.preset = 10
    }
    
    @IBAction func levelEleven(_ sender: UIButton) {
        LevelSelect.preset = 11
    }
    
    @IBAction func levelTwelve(_ sender: UIButton) {
        LevelSelect.preset = 12
    }
    
    
    
    
}
