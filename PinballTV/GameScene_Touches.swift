//
//  GameScene_Touches.swift
//  PinballTV
//
//  Created by Dian "Charles" Qi on 26/09/2019.
//  Copyright © 2019 Dian "Charles" Qi. All rights reserved.
//

import Foundation
import SpriteKit

extension GameScene {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
//            if ( location.x < sceneWidth / 2) {
            if ( location.x < 0 ) {
                tappedLeft()
            } else {
                if ( location.y > 0 ) {
                    tappedUpperRight()
                } else {
                    tappedRight()
                }
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            if ( location.x < 0 ) {
                letGoLeft()
            } else {
                if ( location.y > 0 ) {
                    letGoUpperRight()
                } else {
                    letGoRight()
                }
            }
        }
    }
}
