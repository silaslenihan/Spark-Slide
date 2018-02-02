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
    var starOne:SKSpriteNode?
    var starTwo:SKSpriteNode?
    var starThree:SKSpriteNode?
    
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
        starOne = self.childNode(withName: "starOne") as? SKSpriteNode
        starTwo = self.childNode(withName: "starTwo") as? SKSpriteNode
        starThree = self.childNode(withName: "starThree") as? SKSpriteNode
        
        greyCircle?.physicsBody = SKPhysicsBody(circleOfRadius: (greyCircle?.size.width)! / 2.0)
        greyCircle?.physicsBody?.affectedByGravity = false
        greyCircle?.physicsBody?.friction = 0.01
        
        greyCircle?.physicsBody?.mass = 0.01
        redSquare?.physicsBody?.mass = 0.005
        yellowTriangle?.physicsBody?.mass = 0.01
        nextLevelIcon?.isHidden = true
        starOne?.isHidden = true
        starTwo?.isHidden = true
        starThree?.isHidden = true
        
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
    
   
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        if(levelButton == true) {
            if (nextLevelIcon?.contains(touch.location(in: self)))! {
                nextLevel()
            }
        }
        
        
        if let label = self.label {
            label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
        }
        
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
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
    
    
    override func update(_ currentTime: TimeInterval) {
        var redYes: Bool = true
        var yellowYes:Bool = true
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
        
        if(redScored)
        {
            redYes = false
        }
        if(yellowScored && yellowYes)
        {
            yellowYes = false
        }
        
        if(numShapes == 0) {
            levelButton = true
            nextLevelIcon?.isHidden = false
            greyCircle?.isHidden = true
            if(swipeCount <= par) {
                starThree?.isHidden = false
            }
            if (swipeCount <= (par * 2) ) {
                starTwo?.isHidden = false
            }
            if (swipeCount <= (par * 3)) {
                starOne?.isHidden = false
            } else {
                stars = 0
            }
        }
        
        if(!redYes ) {
            numShapes -= 1
            print("redMinus")
            redYes = false
            redScored = false
        }
        
        if(!yellowYes) {
            numShapes -= 1
            print("yellowMinus")
            yellowYes = false
            yellowScored = false
        }
    }
    
    func levelSetup(){
        
        greyCircle?.position = CGPoint(x: 0, y: 429)
        
        greyCircle?.isHidden = false
        nextLevelIcon?.isHidden = true
        starOne?.isHidden = false
        starTwo?.isHidden = false
        starThree?.isHidden = false
        
        levelButton = false
        redSquare?.physicsBody?.isDynamic = true
        yellowTriangle?.physicsBody?.isDynamic = true
        
        swipeCount = 0
        
        if(LevelSelect.preset == 1) {
            par = 5
            redSquare?.isHidden = false
            yellowTriangle?.isHidden = false
            numShapes = 2
            yellowTriangle?.position = CGPoint(x: -275, y: 0)
            redSquare?.position = CGPoint(x: 275, y: 0)
        }
        
        if(LevelSelect.preset == 2) {
            redSquare?.isHidden = false
            yellowTriangle?.isHidden = false
            numShapes = 2
            yellowTriangle?.position = CGPoint(x: 225, y: 530)
            redSquare?.position = CGPoint(x: -225, y: 530)
        }
        if(LevelSelect.preset == 3) {
            
        }
        if(LevelSelect.preset == 4) {
            
        }
        if(LevelSelect.preset == 5) {
            
        }
        if(LevelSelect.preset == 6) {
            
        }
        if(LevelSelect.preset == 7) {
            
        }
        if(LevelSelect.preset == 8) {
            
        }
        if(LevelSelect.preset == 9) {
            
        }
        if(LevelSelect.preset == 10) {
            
        }
        if(LevelSelect.preset == 11) {
            
        }
        if(LevelSelect.preset == 12) {
            
        }
    }
}
