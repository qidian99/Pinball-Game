//
//  Flipper.swift
//  PinballTV
//
//  Created by Dian "Charles" Qi on 27/09/2019.
//  Copyright © 2019 Dian "Charles" Qi. All rights reserved.
//

import Foundation
import SpriteKit

class Flipper:SKSpriteNode {
    
    var initialPosition:CGPoint = CGPoint.zero
    var upperRotation:CGFloat = 0
    var lowerRotation:CGFloat = 0
    var alreadyUp:Bool = false
    
    func setUp() {
        initialPosition = self.position
        
        self.physicsBody?.categoryBitMask = BodyType.flipper.rawValue
        self.physicsBody?.collisionBitMask = BodyType.flipperStop.rawValue | BodyType.ball.rawValue
        self.physicsBody?.contactTestBitMask = BodyType.flipperStop.rawValue | BodyType.ball.rawValue
        self.physicsBody?.usesPreciseCollisionDetection = true
        
        if ( self.name == "FlipperRight" ) {
            upperRotation = -30
            lowerRotation = 30
            self.zRotation = degreesToRadians(degrees: lowerRotation)
        } else if ( self.name == "FlipperLeft" ) {
            upperRotation = 30
            lowerRotation = -30
            self.zRotation = degreesToRadians(degrees: lowerRotation)
        }
    }
    
    func radiansToDegrees(radians: CGFloat)-> CGFloat {
        return radians * 180 / CGFloat(Double.pi)
    }
    
    func degreesToRadians(degrees: CGFloat)-> CGFloat {
        return degrees * CGFloat(Double.pi) / 180
    }
    
    func flip() {
        print("flip")
        if ( alreadyUp == false ) {
            alreadyUp = true
            self.physicsBody?.isDynamic = true
            self.physicsBody?.allowsRotation = true
            
            self.physicsBody?.applyImpulse( CGVector(dx: 0, dy: 5000) )
        }
    }
    
    func lower() {
        print("lower")
        alreadyUp = false
        self.physicsBody?.isDynamic = true
        self.physicsBody?.allowsRotation = true
        self.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        self.physicsBody?.angularVelocity = 0
        
        let flip:SKAction = SKAction.rotate(toAngle: degreesToRadians(degrees: lowerRotation), duration: 0.1)
        let run:SKAction = SKAction.run {
            
            self.lockFlipperDown()
            
        }
        self.run( SKAction.sequence([ flip, run ]), withKey: "LowerThenLock")
    }
    
    func lockFlipperDown() {
        
        self.zRotation = degreesToRadians(degrees: lowerRotation)
        lockFlipper()
        
    }
    
    func lockFlipper() {
        self.physicsBody?.applyImpulse( CGVector(dx: 0, dy: 0) )
        self.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        self.physicsBody?.angularVelocity = 0
        self.physicsBody?.isDynamic = false
        self.physicsBody?.allowsRotation = false
    }
    
    func update () {
        self.position = initialPosition
        
        if (self.name == "FlipperRight") {
            
            if (self.zRotation > degreesToRadians(degrees: lowerRotation)) {
                self.zRotation = degreesToRadians(degrees: lowerRotation)
            } else if (self.zRotation < degreesToRadians(degrees: upperRotation)) {
                self.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                self.physicsBody?.applyTorque(0)
                self.physicsBody?.angularVelocity = 0
                self.zRotation = degreesToRadians(degrees: upperRotation)
            }
            
        } else if (self.name == "FlipperLeft") {
            
            if (self.zRotation < degreesToRadians(degrees: lowerRotation)) {
                self.zRotation = degreesToRadians(degrees: lowerRotation)
            } else if (self.zRotation > degreesToRadians(degrees: upperRotation)) {
                self.zRotation = degreesToRadians(degrees: upperRotation)
            }
            
        }
    }
}
