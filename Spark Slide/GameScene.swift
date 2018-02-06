//
//  GameScene.swift
//  Spark Slide
//
//  Created by Silas lenihan on 1/22/18.
//  Copyright © 2018 Silas lenihan. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    
    var redSquare: SKSpriteNode?
    var greyCircle: SKSpriteNode?
    var yellowTriangle: SKSpriteNode?
    var yellowGoal: SKSpriteNode?
    var redGoal: SKSpriteNode?
    var nextLevelIcon: SKSpriteNode?
    var oneStar: SKSpriteNode?
    var twoStars: SKSpriteNode?
    var threeStars: SKSpriteNode?
    var zeroStars: SKSpriteNode?
    
    var touchBegan = CGPoint(x: 0.0, y: 0.0)
    var touchEnd = CGPoint(x: 0.0, y: 0.0)
    
    var redScored:Bool = false
    var yellowScored:Bool = false
    var levelButton:Bool = false
    
    var numShapes:Int = 2
    var swipeCount:Int = 0
    var par: Int = 0
    var stars: Int = 0
   
    override func didMove(to view: SKView) {
        redSquare = self.childNode(withName: "redSquare") as? SKSpriteNode
        greyCircle = self.childNode(withName: "greyCircle") as? SKSpriteNode
        yellowTriangle = self.childNode(withName: "yellowTriangle") as? SKSpriteNode
        yellowGoal = self.childNode(withName: "yellowGoal") as? SKSpriteNode
        redGoal = self.childNode(withName: "redGoal") as? SKSpriteNode
        nextLevelIcon = self.childNode(withName: "nextLevelIcon") as? SKSpriteNode
        zeroStars = self.childNode(withName: "zeroStars") as? SKSpriteNode
        oneStar = self.childNode(withName: "oneStar") as? SKSpriteNode
        twoStars = self.childNode(withName: "twoStars") as? SKSpriteNode
        threeStars = self.childNode(withName: "threeStars") as? SKSpriteNode
        
        
        greyCircle?.physicsBody = SKPhysicsBody(circleOfRadius: (greyCircle?.size.width)! / 2.0)
        greyCircle?.physicsBody?.affectedByGravity = false
        greyCircle?.physicsBody?.friction = 0.01
        
        greyCircle?.physicsBody?.mass = 0.01
        redSquare?.physicsBody?.mass = 0.005
        yellowTriangle?.physicsBody?.mass = 0.01
        nextLevelIcon?.isHidden = true
        oneStar?.isHidden = true
        twoStars?.isHidden = true
        threeStars?.isHidden = true
        
        nextLevelIcon?.name = "nextLevelIcon"
        nextLevelIcon?.isUserInteractionEnabled = false

        levelSetup()
    }
    
    func touchDown(atPoint pos : CGPoint) {
        touchBegan = pos
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        //greyCircle?.run(SKAction.move(to: pos, duration: 0.5))
    }
    
    func touchUp(atPoint pos : CGPoint) {
        touchEnd = pos
        greyCircle?.physicsBody?.velocity = CGVector(dx: (greyCircle?.anchorPoint.x)!, dy: (greyCircle?.anchorPoint.y)!)
        greyCircle?.physicsBody?.angularVelocity = 0.0
        swipeCount += 1
        move()
    }
    
    //------------------------------------------------------------------------
    // move() - moves greyCircle based on touchBegan and touchEnd locations.
    //------------------------------------------------------------------------
    func move () {
        let Bx = touchEnd.x
        let By = touchEnd.y
        let Ax = touchBegan.x
        let Ay = touchBegan.y
        let deltaX = (Bx - Ax)
        let deltaY = (By - Ay)
        
        let vectorX: CGFloat = deltaX
        let vectorY: CGFloat = deltaY

        let vector = CGVector(dx: vectorX, dy: vectorY)
        greyCircle?.physicsBody?.applyForce(vector)
    }
    
    func nextLevel() {
        LevelSelect.preset += 1
        levelSetup()
    }
    
   
    //------------------------------------------------------------------------
    // touchesBegan() - allows for next level icons to be touched, resulting in
    // a change to the next screen.
    //------------------------------------------------------------------------
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        if(levelButton == true) {
            if (zeroStars?.contains(touch.location(in: self)))! {
                nextLevel()
            } else if (oneStar?.contains(touch.location(in: self)))! {
                self.nextLevel()
            } else if (twoStars?.contains(touch.location(in: self)))! {
                nextLevel()
            } else if (threeStars?.contains(touch.location(in: self)))! {
                nextLevel()
            }
        }
        
        
        if let label = self.label {
            label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
        }
        
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    
    
    //------------------------------------------------------------------------
    // update() checks every frame for whether each shape is being touched by
    // the grey ball, and if so updates their properties accordingly.
    //------------------------------------------------------------------------
    override func update(_ currentTime: TimeInterval) {
        //these bools mean whether their color is still in play
        var redYes: Bool = true
        var yellowYes:Bool = true
        //checks whether is contacting grey ball
        if(redYes) {
            if(redSquare?.physicsBody?.allContactedBodies().contains((redGoal?.physicsBody)!))! {
                redSquare?.isHidden = true
                redSquare?.physicsBody?.isDynamic = false
                redScored = true
            }
        }
        if(yellowYes) {
            if(yellowTriangle?.physicsBody?.allContactedBodies().contains((yellowGoal?.physicsBody)!))! {
                yellowTriangle?.isHidden = true
                yellowTriangle?.physicsBody?.isDynamic = false
                yellowScored = true
            }
        }
        
        //if red is scored, it means that that color is no longer in play
        if(redScored)
        {
            redYes = false
        }
        if(yellowScored && yellowYes)
        {
            yellowYes = false
        }
        
        //runs once none of the colors are in play, checks how many stars there should be
        if(numShapes == 0) {
            numShapes = 1
            
            //means the level button will come up and be capable of being selected
            levelButton = true

            greyCircle?.isHidden = true
            
            //checks how many stars there should be depending on the par
            if(swipeCount <= par) {
                threeStars?.isHidden = false
                print("three stars")
            }
            else if (swipeCount <= (par * 2)) {
                twoStars?.isHidden = false
                print ("two stars")
            }
            else if (swipeCount <= (par * 3)) {
                oneStar?.isHidden = false
                print("one star")
            } else {
                zeroStars?.isHidden = false
                print("zero stars")
            }

            print(swipeCount)
            redSquare?.position = CGPoint(x: 0, y: 0)
            yellowTriangle?.position = CGPoint(x: 0, y: 0)
            
        }
        
        //checks whether the color is still in play, if not subtracts for numShapes
        if(!redYes ) {
            numShapes -= 1
            print("redMinus")
            redSquare?.position = CGPoint(x: 1000, y: 1000)
            redYes = false
            redScored = false
        }
        
        if(!yellowYes) {
            numShapes -= 1
            print("yellowMinus")
            yellowTriangle?.position = CGPoint(x: 1000, y: 1000)
            yellowYes = false
            yellowScored = false
        }
    }
    
    //------------------------------------------------------------------------------------
    // levelSetup() - sets up levels and instance data for each level according to
    // LevelSelect.preset
    //------------------------------------------------------------------------------------
    func levelSetup(){
        
        greyCircle?.position = CGPoint(x: 0, y: 429)
        
        greyCircle?.isHidden = false
        zeroStars?.isHidden = true
        oneStar?.isHidden = true
        twoStars?.isHidden = true
        threeStars?.isHidden = true
        
        
        levelButton = false
        redSquare?.physicsBody?.isDynamic = true
        yellowTriangle?.physicsBody?.isDynamic = true
        
        swipeCount = -1
        
        //sets up location for each node, par, and number of shapes.
        
        //LEVEL 1
        if(LevelSelect.preset == 1) {
            swipeCount = 0
            par = 5
            redSquare?.isHidden = false
            yellowTriangle?.isHidden = false
            numShapes = 2
            yellowTriangle?.position = CGPoint(x: -275, y: 0)
            redSquare?.position = CGPoint(x: 275, y: 0)
        }
        
        //LEVEL 2
        if(LevelSelect.preset == 2) {
            par = 8
            redSquare?.isHidden = false
            yellowTriangle?.isHidden = false
            numShapes = 2
            yellowTriangle?.position = CGPoint(x: 225, y: 530)
            redSquare?.position = CGPoint(x: -225, y: 530)
        }
        
        //LEVEL 3
        if(LevelSelect.preset == 3) {
            
        }
        
        //LEVEL 4
        if(LevelSelect.preset == 4) {
            
        }
        
        //LEVEL 5
        if(LevelSelect.preset == 5) {
            
        }
        
        //LEVEL 6
        if(LevelSelect.preset == 6) {
            
        }
        
        //LEVEL 7
        if(LevelSelect.preset == 7) {
            
        }
        
        //LEVEL 8
        if(LevelSelect.preset == 8) {
            
        }
        
        //LEVEL 9
        if(LevelSelect.preset == 9) {
            
        }
        
        //LEVEL 10
        if(LevelSelect.preset == 10) {
            
        }
        
        //LEVEL 11
        if(LevelSelect.preset == 11) {
            
        }
        
        //LEVEL 12
        if(LevelSelect.preset == 12) {
            
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            self.touchMoved(toPoint: t.location(in: self))
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
}
