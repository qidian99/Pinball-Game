//
//  GameScene.swift
//  PinballTV
//
//  Created by Dian "Charles" Qi on 26/09/2019.
//  Copyright © 2019 Dian "Charles" Qi. All rights reserved.
//

import SpriteKit
import GameplayKit

enum BodyType:UInt32 {
    
    case flipper = 1
    case ball = 2
    case flipperStop = 4
    case bumper = 8
    case arrow = 16
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var sceneWidth:CGFloat = 0
    var sceneHeight:CGFloat = 0
    var playerIndex1InUse:Bool = false
    
    var mainBall:Ball = Ball()
    
    #if os(tvOS)
    
    let tapLeft = UITapGestureRecognizer()
    let tapRight = UITapGestureRecognizer()
    
    #endif
    
    //==============================================================
    // Private Variables
    //==============================================================
    
    private var lastUpdateTime : TimeInterval = 0
    
    // UI
    internal var scoreLabel : SKLabelNode?
    internal var livesLable : SKLabelNode?
    
    // Sprite nodes
    private var ballNode : Ball?
    private var ballSpawnPointNode : SKNode?
    
    private var leftFlipper : Flipper?
    private var rightFlipper : Flipper?
    private var rightFlipper2 : Flipper?
    
    private var arrows : Arrows?
    
    // Audio
    private var musicPlayer: MusicPlayer?
    internal var soundsPlayer: SoundsPlayer?
    
    
    override func didMove(to view: SKView) {
        
        physicsWorld.contactDelegate = self
        
        sceneWidth = self.frame.width
        sceneHeight = self.frame.height

        print(sceneWidth)
        print(sceneHeight)
        
        #if os(tvOS)
        tapLeft.addTarget(self, action: #selector(tappedLeft) )
        tapLeft.allowedPressTypes = [NSNumber (value: UIPress.PressType.leftArrow.rawValue)]
        self.view!.addGestureRecognizer(tapLeft)
        
        tapRight.addTarget(self, action: #selector(tappedRight) )
        tapRight.allowedPressTypes = [NSNumber (value: UIPress.PressType.rightArrow.rawValue)]
        self.view!.addGestureRecognizer(tapRight)
        #endif
        
        setUpChildren()
        
        musicPlayer = MusicPlayer(scene: self, fileNamed: "BackgroundMusic.mp3");
        musicPlayer!.Play();
        
        soundsPlayer = SoundsPlayer(scene: self);
        
    }
    
    private func FindUINodes()
    {
        self.scoreLabel = self.childNode(withName: "Score Label") as? SKLabelNode
        self.livesLable = self.childNode(withName: "Lives Label") as? SKLabelNode
        
        self.livesLable?.text = "Lives: \(GameScore.instance.Lives)"
    }
    
    func setUpChildren() {
        for node in self.children {
            if let flipper:Flipper = node as? Flipper {
                flipper.setUp()
            }
            else if let flipperStoper:FlipperStop = node as? FlipperStop {
                flipperStoper.setUp()
            }
            else if let someBall:Ball = node as? Ball {
                someBall.setUp()
                
                if (someBall.name == "MainBall") {
                    mainBall = someBall
                }
            }
//            else if let bumperB:BumperB = node as? BumperB {
//                bumperB.setUp()
//            }
//            else if let bumper:Bumper = node as? Bumper {
//                bumper.setUp()
//            }
//            else if let arrow:Arrows = node as? Arrows {
//                arrow.setUp()
//            }

            
            let forceToApply: CGVector = CGVector(dx: 0, dy: 1000)
            self.arrows = childNode(withName: "Stage/Arrows") as? Arrows
            self.arrows?.setUp(forceToApply: forceToApply, timePerFrame: 0.8)
            
            let bumperA = childNode(withName: "Stage/Bumpers/Bumper A") as? Bumper
            let bumperB = childNode(withName: "Stage/Bumpers/Bumper B") as? Bumper
            let bumperC = childNode(withName: "Stage/Bumpers/Bumper C") as? Bumper
            let bumperD = childNode(withName: "Stage/Bumpers/Bumper D") as? Bumper
            bumperA!.setUp(pointsToGive: 10)
            bumperB!.setUp(pointsToGive: 10)
            bumperC!.setUp(pointsToGive: 10)
            bumperD!.setUp(pointsToGive: 10)
            
            let bumper2A = childNode(withName: "Stage/Bumpers/Bumper 2A") as? BumperB
            let bumper2B = childNode(withName: "Stage/Bumpers/Bumper 2B") as? BumperB
            bumper2A!.setUp(pointsToGive: 15)
            bumper2B!.setUp(pointsToGive: 15)
            
            let light0 = childNode(withName: "Stage/Lights/Light0") as? Light
            let light1 = childNode(withName: "Stage/Lights/Light1") as? Light
            let light2 = childNode(withName: "Stage/Lights/Light2") as? Light
            let light3 = childNode(withName: "Stage/Lights/Light3") as? Light
            let light4 = childNode(withName: "Stage/Lights/Light4") as? Light
            let light5 = childNode(withName: "Stage/Lights/Light5") as? Light
            let light6 = childNode(withName: "Stage/Lights/Light6") as? Light
            let light7 = childNode(withName: "Stage/Lights/Light7") as? Light
            
            light0?.setUp()
            light1?.setUp()
            light2?.setUp()
            light3?.setUp()
            light4?.setUp()
            light5?.setUp()
            light6?.setUp()
            light7?.setUp()
        }
        FindUINodes()
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        for node in self.children {
            if let someFlipper:Flipper = node as? Flipper {
                someFlipper.update()
            } else if let ball:Ball = node as? Ball {
                
                for childNode in ball.children {
                    childNode.zRotation = -ball.zRotation
                }
            }
        }
        
        if (mainBall.position.y < -sceneHeight / 2) {
            _ = mainBall.CheckIfResetBall()
            GameScore.instance.TakeLife();
            self.livesLable!.text = "Lives: \(GameScore.instance.Lives)"
            
            soundsPlayer?.PlayGate();
        }
        
        if(GameScore.instance.Lives <= 0)
        {
            ChangeToGameOverScene();
        }
    }
    
    private func ChangeToGameOverScene()
    {
        soundsPlayer!.PlayGameOver();
        
        let lossScene = EndScene(size: self.size);
        lossScene.scaleMode=scaleMode;
        
        let transition = SKTransition.doorsCloseHorizontal(withDuration: 1);
        self.view?.presentScene(lossScene,transition:transition)
    }
    
    @objc func tappedLeft() {
        for node in self.children {
            if ( node.name == "FlipperLeft" ) {
                if let flipper:Flipper = node as? Flipper {
                    flipper.flip()
                }
            }
        }
    }
    
    @objc func tappedRight() {
        for node in self.children {
            if ( node.name == "FlipperRight" ) {
                if let flipper:Flipper = node as? Flipper {
                    flipper.flip()
                }
            }
        }
    }
    
    @objc func tappedUpperRight() {
        for node in self.children {
            if ( node.name == "FlipperUpperRight" ) {
                if let flipper:Flipper = node as? Flipper {
                    flipper.flip()
                }
            }
        }
    }
    
    @objc func letGoLeft() {
        for node in self.children {
            if ( node.name == "FlipperLeft" ) {
                if let flipper:Flipper = node as? Flipper {
                    flipper.lower()
                }
            }
        }
    }
    
    @objc func letGoRight() {
        for node in self.children {
            if ( node.name == "FlipperRight" ) {
                if let flipper:Flipper = node as? Flipper {
                    flipper.lower()
                }
            }
        }
    }
    
    @objc func letGoUpperRight() {
        for node in self.children {
            if ( node.name == "FlipperUpperRight" ) {
                if let flipper:Flipper = node as? Flipper {
                    flipper.lower()
                }
            }
        }
    }
}
