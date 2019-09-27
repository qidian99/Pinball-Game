//
//  Flipper.swift
//  PinballTV
//
//  Created by Dian "Charles" Qi on 27/09/2019.
//  Copyright © 2019 Dian "Charles" Qi. All rights reserved.
//

import Foundation
import SpriteKit

class FlipperStop:SKSpriteNode {
    
    func setUp() {
        self.physicsBody?.categoryBitMask = BodyType.flipperStop.rawValue
        self.physicsBody?.collisionBitMask = BodyType.flipper.rawValue
        self.physicsBody?.contactTestBitMask = BodyType.flipper.rawValue
    }
}
