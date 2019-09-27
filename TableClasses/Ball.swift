//
//  Flipper.swift
//  PinballTV
//
//  Created by Dian "Charles" Qi on 27/09/2019.
//  Copyright © 2019 Dian "Charles" Qi. All rights reserved.
//

import Foundation
import SpriteKit

class Ball:SKSpriteNode {
    private var spawnPoint : CGPoint = CGPoint(x: 300, y: -600);
    private var heighThreshold : CGFloat = 0.0;
    
    
    func setUp() {
        self.physicsBody?.categoryBitMask = BodyType.ball.rawValue
        self.physicsBody?.collisionBitMask = BodyType.flipper.rawValue | BodyType.ball.rawValue
        self.physicsBody?.contactTestBitMask = BodyType.flipper.rawValue | BodyType.ball.rawValue
        self.physicsBody?.usesPreciseCollisionDetection = true
        ResetBall()
    }
    
    func CheckIfResetBall() -> Bool {
        if self.position.y < heighThreshold
        {
            ResetBall();
            
            return true;
        }
        
        return false;
    }
    
    private func ResetBall() {        
        let spawnPosition = spawnPoint;
        self.position = spawnPosition;
        
        self.physicsBody?.velocity = CGVector(dx: 0, dy: 0);
        self.physicsBody?.applyImpulse(CGVector(dx: 10, dy: 1000));
    }
}
