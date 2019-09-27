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
    
    func setUp() {
        self.physicsBody?.categoryBitMask = BodyType.ball.rawValue
        self.physicsBody?.collisionBitMask = BodyType.flipper.rawValue | BodyType.ball.rawValue
        self.physicsBody?.contactTestBitMask = BodyType.flipper.rawValue | BodyType.ball.rawValue
        self.physicsBody?.usesPreciseCollisionDetection = true
    }
}
