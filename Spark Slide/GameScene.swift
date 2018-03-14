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

    var background: SKSpriteNode?
    var redSquare: SKSpriteNode?
    var greyCircle: SKSpriteNode?
    var yellowTriangle: SKSpriteNode?
    var blueDiamond: SKSpriteNode?
    var yellowGoal: SKSpriteNode?
    var redGoal: SKSpriteNode?
    var nextLevelIcon: SKSpriteNode?
    var oneStar: SKSpriteNode?
    var twoStars: SKSpriteNode?
    var threeStars: SKSpriteNode?
    var zeroStars: SKSpriteNode?
    var pauseButton: SKSpriteNode?
    var resetButton: SKSpriteNode?
    var levelSelectButton: SKSpriteNode?
    var resume: SKSpriteNode?
    var redGoalBoy: SKSpriteNode?
    var yellowGoalBoy: SKSpriteNode?
    var blueGoal: SKSpriteNode?
    var blueGoalBoy: SKSpriteNode?
    var wall: SKSpriteNode?
    var purplePentagon: SKSpriteNode?
    var purpleGoal:SKSpriteNode?
    var purpleGoalBoy:SKSpriteNode?
    var parLabel: SKLabelNode?
    var swipeLabel: SKLabelNode?
    var swipeWall: SKSpriteNode?
    var loading: SKSpriteNode?
    var rightWall: SKSpriteNode?
    var leftWall: SKSpriteNode?
    var topWall: SKSpriteNode?
    var bottomWall: SKSpriteNode?
    var barrier1: SKSpriteNode?
    var barrier2: SKSpriteNode?
    var barrier3: SKSpriteNode?
    var barrier4: SKSpriteNode?

    var touchBegan = CGPoint(x: 0.0, y: 0.0)
    var touchEnd = CGPoint(x: 0.0, y: 0.0)
    var topLeft = CGPoint(x: -355.467, y:641)
    var bottomLeft = CGPoint(x: -355.467, y:-641)
    var topRight = CGPoint(x: 355.467, y:641)
    var bottomRight = CGPoint(x: 355.467, y:-641)
    
    var redScored:Bool = false
    var yellowScored:Bool = false
    var blueScored:Bool = false
    var purpleScored:Bool = false
    var greenScored:Bool = false
    var levelButton:Bool = false
    var gamePaused:Bool = false
    var wallIsRotating: Bool = false
    var wallIsSliding:Bool = false
    var wallTimer = Timer()
    var loadingTimer = Timer()
    var slideWallLeft:Bool = true
    
    var numShapes:Int = 2
    var swipeCount:Int = 0
    var par: Int = 0
    var stars: Int = 0
    
    static var myDelegate : backButtonProtocol?
    
    override func didMove(to view: SKView) {
        background = self.childNode(withName: "background") as? SKSpriteNode
        background?.position = CGPoint(x:0,y:0)
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
        pauseButton = self.childNode(withName: "pauseButton") as? SKSpriteNode
        resetButton = self.childNode(withName: "resetButton") as? SKSpriteNode
        levelSelectButton = self.childNode(withName: "levelSelectButton") as? SKSpriteNode
        resume = self.childNode(withName: "resume") as? SKSpriteNode
        blueDiamond = self.childNode(withName: "blueDiamond") as? SKSpriteNode
        redGoalBoy = self.childNode(withName: "redGoalBoy") as? SKSpriteNode
        yellowGoalBoy = self.childNode(withName: "yellowGoalBoy") as? SKSpriteNode
        blueGoalBoy = self.childNode(withName: "blueGoalBoy") as? SKSpriteNode
        blueGoal = self.childNode(withName: "blueGoal") as? SKSpriteNode
        wall = self.childNode(withName: "wall") as? SKSpriteNode
        purplePentagon = self.childNode(withName: "purplePentagon") as? SKSpriteNode
        purpleGoal = self.childNode(withName: "purpleGoal") as? SKSpriteNode
        purpleGoalBoy = self.childNode(withName: "purpleGoalBoy") as? SKSpriteNode
        parLabel = self.childNode(withName: "parLabel") as? SKLabelNode
        swipeLabel = self.childNode(withName: "swipeLabel") as? SKLabelNode
        swipeWall = self.childNode(withName: "swipeWall") as? SKSpriteNode
        loading = self.childNode(withName:"loading") as? SKSpriteNode
        rightWall = self.childNode(withName:"rightWall") as? SKSpriteNode
        leftWall = self.childNode(withName:"leftWall") as? SKSpriteNode
        bottomWall = self.childNode(withName:"bottomWall") as? SKSpriteNode
        topWall = self.childNode(withName:"topWall") as? SKSpriteNode
        barrier1 = self.childNode(withName:"barrier1") as? SKSpriteNode
        barrier2 = self.childNode(withName:"barrier2") as? SKSpriteNode
        barrier3 = self.childNode(withName:"barrier3") as? SKSpriteNode
        barrier4 = self.childNode(withName:"barrier4") as? SKSpriteNode
        
        greyCircle?.physicsBody = SKPhysicsBody(circleOfRadius: (greyCircle?.size.width)! / 2.0)
        greyCircle?.physicsBody?.affectedByGravity = false
        greyCircle?.physicsBody?.friction = 0.01
        
        greyCircle?.physicsBody?.mass = 0.01
        redSquare?.physicsBody?.mass = 0.005
        yellowTriangle?.physicsBody?.mass = 0.005
        blueDiamond?.physicsBody?.mass = 0.005
        purplePentagon?.physicsBody?.mass = 0.005
        
        greyCircle?.physicsBody?.restitution = 0.25
        redSquare?.physicsBody?.restitution = 0.25
        yellowTriangle?.physicsBody?.restitution = 0.25
        blueDiamond?.physicsBody?.restitution = 0.25
        purplePentagon?.physicsBody?.restitution = 0.25
        
        loading?.position = CGPoint(x:0,y:0)
        loading?.isHidden = true
        
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
        if(!gamePaused) {
            swipeCount += 1
            move()
        }
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
        swipeCount = -1
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
        
        
        if(pauseButton?.contains(touch.location(in: self)))! {
            levelSelectButton?.isHidden = false
            resetButton?.isHidden = false
            resume?.isHidden = false
            
            levelSelectButton?.position = CGPoint(x: 0,y: 430)
            resetButton?.position = CGPoint(x:0,y:230)
            resume?.position = CGPoint(x:0, y:30)
            gamePaused = true
            swipeCount -= 1
            
        }
        if(gamePaused) {
            if(levelSelectButton?.contains(touch.location(in: self)))! {
                GameScene.myDelegate?.backButton()
            }
            if(resetButton?.contains(touch.location(in: self)))! {
                print("reset")
                wallTimer.invalidate()
                levelSetup()
                swipeCount = -1
                resetButton?.position = CGPoint(x:1000,y:1000)
                resume?.position = CGPoint(x:1000,y:1000)
                levelSelectButton?.position = CGPoint(x:1000,y:1000)
            }
            if(resume?.contains(touch.location(in: self)))! {
                print("resume")
                gamePaused = false
                resume?.isHidden = true
                levelSelectButton?.isHidden = true
                resetButton?.isHidden = true
                redSquare?.isHidden = false
                greyCircle?.isHidden = false
                yellowTriangle?.isHidden = false
            }
            
        }
        
        if let label = self.label {
            label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
        }
        
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    
    
    }
    //------------------------------------------------------------------------
    // update() - checks every frame for whether each shape is being touched by
    // the grey ball, and if so updates their properties accordingly.
    //------------------------------------------------------------------------
    override func update(_ currentTime: TimeInterval) {
        if(swipeCount >= 0) {
            swipeLabel?.text = ("moves: \(swipeCount)")
        }
        
        stopCollision(node: redSquare!, goal: redGoal!)
        stopCollision(node: yellowTriangle!, goal: yellowGoal!)
        stopCollision(node: blueDiamond!, goal: blueGoal!)
        stopCollision(node: purplePentagon!, goal: purpleGoal!)
        
        shapeScore()
        
        if(wallIsRotating) {
            wall?.zRotation += 0.01
        }
        
        if(wallIsSliding) {
            slidingWall()
        }
    }
    
    func slidingWall() {
        if(slideWallLeft) {
            swipeWall?.position.x += 2
        } else {
            swipeWall?.position.x -= 2
        }
        
        if(Double((swipeWall?.position.x)!) >= 350.0) {
            slideWallLeft = false
        }
        if(Double((swipeWall?.position.x)!) <= -350.0) {
            slideWallLeft = true
        }
    }
    
    
    //------------------------------------------------------------------------------------
    // levelSetup() - sets up levels and instance data for each level according to
    // LevelSelect.preset
    //------------------------------------------------------------------------------------
    func levelSetup(){
        greyCircle?.position = CGPoint(x: 0, y: 0)
        print("level setup")
        greyCircle?.isHidden = false
        zeroStars?.isHidden = true
        oneStar?.isHidden = true
        twoStars?.isHidden = true
        threeStars?.isHidden = true
        resetButton?.isHidden = true
        levelSelectButton?.isHidden = true
        resume?.isHidden = true
        blueDiamond?.isHidden = true
        blueGoal?.isHidden = true
        blueGoalBoy?.isHidden = true
        purplePentagon?.isHidden = true
        purpleGoal?.isHidden = true
        purpleGoalBoy?.isHidden = true
        swipeWall?.isHidden = true
        gamePaused = false
        yellowGoal?.position = CGPoint(x:-310.357, y:-600.941)
        yellowGoalBoy?.position = CGPoint(x:-275, y:-567)
        redGoal?.position = CGPoint(x:310.357, y:-600.942)
        redGoalBoy?.position = CGPoint(x: 275,y: -567)
        blueDiamond?.position = CGPoint(x: -1000, y: 1000)
        blueGoal?.position = CGPoint(x:1000, y: 1000)
        blueGoalBoy?.position = CGPoint(x:1000,y: 1000)
        purplePentagon?.position = CGPoint(x: -1000, y: 1000)
        purpleGoal?.position = CGPoint(x:1000, y: 1000)
        purpleGoalBoy?.position = CGPoint(x:1000,y: 1000)
        swipeWall?.position = CGPoint(x:1000,y:1000)
        
        wall?.position = CGPoint(x:1000, y:1000)
        swipeWall?.position = CGPoint(x:1000, y:1000)
        oneStar?.position = CGPoint(x: 0 , y: 0)
        twoStars?.position = CGPoint(x: 0 , y: 0)
        threeStars?.position = CGPoint(x: 0 , y: 0)
        zeroStars?.position = CGPoint(x: 0 , y: 0)
        levelSelectButton?.position = CGPoint(x: 0,y: 430)
        resetButton?.position = CGPoint(x:0,y:230)
        resume?.position = CGPoint(x:0, y:30)
        
        levelButton = false
        redSquare?.physicsBody?.isDynamic = true
        yellowTriangle?.physicsBody?.isDynamic = true
        
        redSquare?.zRotation = 0
        yellowTriangle?.zRotation = 0
        blueDiamond?.zRotation = 45
        purplePentagon?.zRotation = 0
        
        redSquare?.physicsBody?.isDynamic = false
        yellowTriangle?.physicsBody?.isDynamic = false
        blueDiamond?.physicsBody?.isDynamic = false
        purplePentagon?.physicsBody?.isDynamic = false
        
        redSquare?.physicsBody?.isDynamic = true
        yellowTriangle?.physicsBody?.isDynamic = true
        blueDiamond?.physicsBody?.isDynamic = true
        purplePentagon?.physicsBody?.isDynamic = true
        
        barrier1?.isHidden = true
        barrier2?.isHidden = true
        barrier3?.isHidden = true
        barrier4?.isHidden = true
        
        redSquare?.zRotation = 0
        yellowTriangle?.zRotation = 0
        
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
            par = 12
            redSquare?.isHidden = false
            yellowTriangle?.isHidden = false
            numShapes = 3
            yellowTriangle?.position = CGPoint(x: 225, y: 530)
            redSquare?.position = CGPoint(x: -225, y: 530)
            blueDiamond?.position = CGPoint(x: 0, y: -530)
            blueGoal?.position = CGPoint(x:0, y: 600.942)
            blueGoalBoy?.position = CGPoint(x:0,y: 566)
            blueDiamond?.isHidden = false
            blueGoal?.isHidden = false
            blueGoalBoy?.isHidden = false
        }
        
        //LEVEL 4
        if(LevelSelect.preset == 4) {
            par = 12
            wall?.position = CGPoint(x:168.632, y:322.604)
            wall?.size.height = 592.736
            wall?.size.width = 114.724
            redSquare?.isHidden = false
            yellowTriangle?.isHidden = false
            numShapes = 3
            
            blueDiamond?.isHidden = false
            blueGoal?.isHidden = false
            blueGoalBoy?.isHidden = false
            
            greyCircle?.position = CGPoint(x:25.009,y:530.177)
            yellowTriangle?.position = CGPoint(x:-195.697,y:193.126)
            blueDiamond?.position = CGPoint(x:-195.697, y:-245.257)
            redSquare?.position = CGPoint (x:-195.697, y:530.097)
            yellowGoal?.position = CGPoint(x:310.357, y:199.184)
            yellowGoalBoy?.position = CGPoint(x:275, y:165.242)
            redGoal?.position = CGPoint(x:310.357, y:-600.942)
            redGoalBoy?.position = CGPoint(x: 275,y: -567)
            blueGoal?.position = CGPoint(x:310.358, y:563.838)
            blueGoalBoy?.position = CGPoint(x: 275, y:567)
        }
        
        //LEVEL 5
        if(LevelSelect.preset == 5) {
            par = 8
            redSquare?.isHidden = false
            yellowTriangle?.isHidden = false
            numShapes = 4
            
            blueDiamond?.isHidden = false
            blueGoal?.isHidden = false
            blueGoalBoy?.isHidden = false
            
            purplePentagon?.isHidden = false
            purpleGoal?.isHidden = false
            purpleGoalBoy?.isHidden = false
            
            greyCircle?.position = CGPoint(x:0,y:0)
            yellowTriangle?.position = CGPoint(x:0,y:-200)
            blueDiamond?.position = CGPoint(x:-200, y:0)
            redSquare?.position = CGPoint (x:200, y:0)
            purplePentagon?.position = CGPoint(x: 0, y: 200)
            
            yellowGoal?.position =  CGPoint(x:-310.357, y:-600.942)
            yellowGoalBoy?.position = CGPoint(x:-275, y:-567)
            redGoal?.position = CGPoint(x:310.357, y:-600.942)
            redGoalBoy?.position = CGPoint(x: 275,y: -567)
            blueGoal?.position = CGPoint(x:310.358, y:563.838)
            blueGoalBoy?.position = CGPoint(x: 275, y:567)
            purpleGoal?.position = CGPoint(x:-310.358, y:563.838)
            purpleGoalBoy?.position = CGPoint(x: -275, y:567)
        }
        
        //LEVEL 6
        if(LevelSelect.preset == 6) {
            wall?.isHidden = false
            wall?.position = CGPoint(x: 0, y:0)
            wallIsRotating = true
            par = 16
            redSquare?.isHidden = false
            yellowTriangle?.isHidden = false
            numShapes = 4
            
            blueDiamond?.isHidden = false
            blueGoal?.isHidden = false
            blueGoalBoy?.isHidden = false
            
            purplePentagon?.isHidden = false
            purpleGoal?.isHidden = false
            purpleGoalBoy?.isHidden = false
            
            greyCircle?.position = CGPoint(x:0,y:530)
            yellowTriangle?.position = CGPoint(x:225,y:325)
            blueDiamond?.position = CGPoint(x:-225, y:-325)
            redSquare?.position = CGPoint (x:-225, y:325)
            purplePentagon?.position = CGPoint(x: 225, y: -325)
            
            yellowGoal?.position =  CGPoint(x:-310.357, y:-600.942)
            yellowGoalBoy?.position = CGPoint(x:-275, y:-567)
            redGoal?.position = CGPoint(x:310.357, y:-600.942)
            redGoalBoy?.position = CGPoint(x: 275,y: -567)
            blueGoal?.position = CGPoint(x:310.358, y:563.838)
            blueGoalBoy?.position = CGPoint(x: 275, y:567)
            purpleGoal?.position = CGPoint(x:-310.358, y:563.838)
            purpleGoalBoy?.position = CGPoint(x: -275, y:567)
        }
        
        //LEVEL 7
        if(LevelSelect.preset == 7) {
            par = 16
            numShapes = 4
            wallIsSliding = true
            blueDiamond?.isHidden = false
            purplePentagon?.isHidden = false
            purpleGoal?.isHidden = false
            purpleGoalBoy?.isHidden = false
            blueGoal?.isHidden = false
            blueGoalBoy?.isHidden = false
            swipeWall?.isHidden = false
            redSquare?.isHidden = false
            yellowTriangle?.isHidden = false
            swipeWall?.position = CGPoint (x:-200, y:0)
            
            greyCircle?.position = CGPoint(x: 0, y:500)
            purplePentagon?.position = CGPoint(x:280, y:320)
            blueDiamond?.position = CGPoint(x:-280,y:320)
            redSquare?.position = CGPoint(x:-100, y:320)
            yellowTriangle?.position = CGPoint(x:100, y:320)
            
            swipeWall?.position = CGPoint(x:-200, y:115.755)
            blueGoal?.position = CGPoint(x:293, y:-220)
            blueGoalBoy?.position = CGPoint(x:275,y:-217)
            purpleGoal?.position = CGPoint(x:-293,y:-220)
            purpleGoalBoy?.position = CGPoint(x:-275,y:-217)
            redGoal?.position = CGPoint(x:310.357,y:-600.942)
            redGoalBoy?.position = CGPoint(x:275, y:-567)
            yellowGoal?.position = CGPoint(x:-310.357,y:-600.942)
            yellowGoalBoy?.position = CGPoint (x:-275, y:-567)
            
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
        parLabel?.text = "par: \(par)"
    }
    
    func wallStop(shape: SKSpriteNode){
        
    }
    
    func shapeScore() {
        //these bools mean whether their color is still in play
        var redYes: Bool = true
        var yellowYes:Bool = true
        var blueYes:Bool = true
        var purpleYes:Bool = true

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
        
        if(blueYes) {
            if(blueDiamond?.physicsBody?.allContactedBodies().contains((blueGoal?.physicsBody)!))! {
                blueDiamond?.isHidden = true
                blueDiamond?.physicsBody?.isDynamic = false
                blueScored = true
            }
        }
        
        if(purpleYes) {
            if(purplePentagon?.physicsBody?.allContactedBodies().contains((purpleGoal?.physicsBody)!))! {
                purplePentagon?.isHidden = true
                purplePentagon?.physicsBody?.isDynamic = false
                purpleScored = true
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
        if(blueScored && blueYes)
        {
            blueYes = false
        }
        if(purpleScored && purpleYes)
        {
            purpleYes = false
        }
        
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
        
        if(!blueYes) {
            numShapes -= 1
            print("blueMinus")
            blueDiamond?.position = CGPoint(x: 1000, y: 1000)
            blueYes = false
            blueScored = false
        }
        
        if(!purpleYes) {
            numShapes -= 1
            print("purpleMinus")
            purplePentagon?.position = CGPoint(x: 1000, y: 1000)
            purpleYes = false
            purpleScored = false
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
            blueDiamond?.position = CGPoint(x: 0, y: 0)
            
        }
        
        //checks whether the color is still in play, if not subtracts for numShapes
        
    }
    
    func stopCollision (node: SKSpriteNode, goal: SKSpriteNode) {
        let check1: Bool = (node.physicsBody?.allContactedBodies().contains((topWall?.physicsBody)!))!
        let check2: Bool = (node.physicsBody?.allContactedBodies().contains((bottomWall?.physicsBody)!))!
        let check3: Bool = (node.physicsBody?.allContactedBodies().contains((leftWall?.physicsBody)!))!
        let check4: Bool = (node.physicsBody?.allContactedBodies().contains((rightWall?.physicsBody)!))!
        let check5: Bool = (node.physicsBody?.allContactedBodies().contains((goal.physicsBody)!))!
        if(!check1 && !check2 && !check3 && !check4 && check5) {
            node.physicsBody?.collisionBitMask = 0
        } else {
            node.physicsBody?.collisionBitMask = 2
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

protocol backButtonProtocol {
    func backButton()
}

