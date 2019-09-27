//
//  GameScene_Physics.swift
//  PinballTV
//
//  Created by Dian "Charles" Qi on 27/09/2019.
//  Copyright © 2019 Dian "Charles" Qi. All rights reserved.
//

import Foundation
import SpriteKit

extension GameScene {
    func didBegin(_ contact: SKPhysicsContact) {
        if ( contact.bodyA.categoryBitMask == BodyType.flipper.rawValue && contact.bodyB.categoryBitMask == BodyType.flipperStop.rawValue ) {
            if let someFlipper:Flipper = contact.bodyA.node as? Flipper {
                someFlipper.lockFlipper()
            }
        } else if ( contact.bodyA.categoryBitMask == BodyType.flipperStop.rawValue && contact.bodyB.categoryBitMask == BodyType.flipper.rawValue ) {
            if let someFlipper:Flipper = contact.bodyB.node as? Flipper {
                someFlipper.lockFlipper()
            }
        }
    }
    
    
}
