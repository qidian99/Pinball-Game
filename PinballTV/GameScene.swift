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
    case bumper = 4
    case flipperStop = 8
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
    
    #if os(iOS)
    
    #endif
    
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
        }
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
        
        if (mainBall.position.y < 0) {
            
            mainBall.position = CGPoint(x: 720, y: 1079)
            mainBall.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        }
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
}
