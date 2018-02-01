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
   
    
    
    @IBAction func levelSelecter(_ sender: UIButton) {
    if sender.currentTitle == "levelOne" {
        LevelSelect.preset = 1
    }
    if sender.currentTitle == "levelTwo" {
        LevelSelect.preset = 2
    }
    if sender.currentTitle == "levelThree" {
        LevelSelect.preset = 3
    }
    if sender.currentTitle == "levelFour" {
        LevelSelect.preset = 4
    }
    if sender.currentTitle == "levelFive" {
        LevelSelect.preset = 5
    }
    if sender.currentTitle == "levelSix" {
        LevelSelect.preset = 6
    }
    if sender.currentTitle == "levelSeven" {
        LevelSelect.preset = 7
    }
    if sender.currentTitle == "levelEight" {
        LevelSelect.preset = 8
    }
    if sender.currentTitle == "levelNine" {
        LevelSelect.preset = 9
    }
    if sender.currentTitle == "levelTen" {
        LevelSelect.preset = 10
    }
    if sender.currentTitle == "levelEleven" {
        LevelSelect.preset = 11
    }
    if sender.currentTitle == "levelTwelve" {
        LevelSelect.preset = 12
    }
        
    }
    
    @IBOutlet weak var levelOne: UIStackView!
    @IBOutlet weak var levelTwo: UIStackView!
    @IBOutlet weak var levelThree: UIStackView!
    @IBOutlet weak var levelFour: UIButton!
    @IBOutlet weak var levelFive: UIButton!
    @IBOutlet weak var levelSix: UIButton!
    @IBOutlet weak var levelSeven: UIButton!
    @IBOutlet weak var levelEight: UIButton!
    @IBOutlet weak var levelNine: UIButton!
    @IBOutlet weak var levelTen: UIButton!
    @IBOutlet weak var levelEleven: UIButton!
    @IBOutlet weak var levelTwelve: UIButton!
}
