//
//  Settings.swift
//  Spark Slide
//
//  Created by Silas lenihan on 4/26/18.
//  Copyright © 2018 Silas lenihan. All rights reserved.
//

import Foundation
import UIKit

class Settings: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    let starKeyArray = ["levelOneStars","levelTwoStars","levelThreeStars","levelFourStars","levelFiveStars","levelSixStars","levelSevenStars","levelEightStars","levelNineStars","levelTenStars","levelElevenStars","levelTwelveStars"]
    
    @IBAction func resetStars(_ sender: Any) {
        let alert = UIAlertController(title: "Reset All Stars?", message: "This action cannot be undone.", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in switch action.style {
                case .default:
                    for star in self.starKeyArray {
                        UserDefaults.standard.set(0,forKey:star)
                    }
            
                case .cancel:
                    print("cancel")
            
                case .destructive:
                    print("destructive")
            }
        }))

        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
        
        
        
        
    }
    
    
}
