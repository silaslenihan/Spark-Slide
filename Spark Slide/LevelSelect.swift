//
//  LevelSelect.swift
//  Spark Slide
//
//  Created by Silas lenihan on 1/31/18.
//  Copyright © 2018 Silas lenihan. All rights reserved.
//

import Foundation
import UIKit

class LevelSelect: UIViewController, starUpdateProtocol {
    
     let starKeyArray = ["levelOneStars","levelTwoStars","levelThreeStars","levelFourStars","levelFiveStars","levelSixStars","levelSevenStars","levelEightStars","levelNineStars","levelTenStars","levelElevenStars","levelTwelveStars"]
    
    func updateStars() {
        print("stars: \(GameScene.starCount)")
                var total = 0
        for star in starKeyArray {
            total += UserDefaults.standard.integer(forKey: star)
        }
        UserDefaults.standard.set(total,forKey: "starKey")
        starsCount.text = "Stars: \(String(UserDefaults.standard.integer(forKey: "starKey")))"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        GameScene.starDelegate = self
        updateStars()
        levelImageUpdate()
    }
    
    static var preset: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = UIColor(patternImage: UIImage(named:"Spark Slide Background")!)
        GameScene.starCount = UserDefaults.standard.integer(forKey: "starsKey")
        updateStars()
    }
    
    func levelImageUpdate() {
        let levelButtonArray = [levelOne,levelTwo,levelThree,levelFour,levelFive,levelSix,levelSeven,levelEight,levelNine,levelTen,levelEleven,levelTwelve]
        
        for index in 0...11 {
            let starAmount = UserDefaults.standard.integer(forKey: starKeyArray[index])
            if(starAmount == 3) {
                levelButtonArray[index]?.setBackgroundImage(#imageLiteral(resourceName: "green star"), for: [.normal])
            } else if(starAmount > 0) {
                levelButtonArray[index]?.setBackgroundImage(#imageLiteral(resourceName: "green"), for: [.normal])
            }
        }
    }
    
    func resetStars() {
        for star in starKeyArray {
            UserDefaults.standard.set(0, forKey: star)
        }
    }
    
    
    
    @IBAction func levelSelecter(_ sender: UIButton) {
    if sender.currentTitle == "1" {
        LevelSelect.preset = 1
    }
    if sender.currentTitle == "2" {
        LevelSelect.preset = 2
    }
    if sender.currentTitle == "3" {
        LevelSelect.preset = 3
    }
    if sender.currentTitle == "4" {
        LevelSelect.preset = 4
    }
    if sender.currentTitle == "5" {
        LevelSelect.preset = 5
    }
    if sender.currentTitle == "6" {
        LevelSelect.preset = 6
    }
    if sender.currentTitle == "7" {
        LevelSelect.preset = 7
    }
    if sender.currentTitle == "8" {
        LevelSelect.preset = 8
    }
    if sender.currentTitle == "9" {
        LevelSelect.preset = 9
    }
    if sender.currentTitle == "10" {
        LevelSelect.preset = 10
    }
    if sender.currentTitle == "11" {
        LevelSelect.preset = 11
    }
    if sender.currentTitle == "12" {
        LevelSelect.preset = 12
    }
        
    }
    
  

    @IBOutlet weak var starsCount: UILabel!
    @IBOutlet weak var levelOne: UIButton!
    @IBOutlet weak var levelTwo: UIButton!
    @IBOutlet weak var levelThree: UIButton!
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
