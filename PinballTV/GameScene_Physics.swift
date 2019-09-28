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
        
        if ( contact.bodyA.categoryBitMask == BodyType.ball.rawValue && contact.bodyB.categoryBitMask == BodyType.bumper.rawValue ) {
            if let bumper:Bumper = contact.bodyB.node as? Bumper {
                bumper.Collided()
                
                // Plays the bumper collision sound.
                soundsPlayer?.PlayBumper();
                
                // Updates the game score.
                GameScore.instance.AddScore(scoreToAdd: bumper.PointsToGive);
                scoreLabel?.text = "Score: \(GameScore.instance.Score)";
                
            }
        } else if ( contact.bodyB.categoryBitMask == BodyType.ball.rawValue && contact.bodyA.categoryBitMask == BodyType.bumper.rawValue ) {
            if let bumper:Bumper = contact.bodyA.node as? Bumper {
                bumper.Collided()
                
                // Plays the bumper collision sound.
                soundsPlayer?.PlayBumper();
                
                // Updates the game score.
                GameScore.instance.AddScore(scoreToAdd: bumper.PointsToGive);
                scoreLabel?.text = "Score: \(GameScore.instance.Score)";
            }
        }
        
        if ( contact.bodyA.categoryBitMask == BodyType.ball.rawValue && contact.bodyB.categoryBitMask == BodyType.arrow.rawValue ) {
            if let arrow:Arrows = contact.bodyB.node as? Arrows {
                if let ball:Ball = contact.bodyA.node as? Ball {
                    arrow.Collided(ball: ball)
                }
            }
        } else if ( contact.bodyB.categoryBitMask == BodyType.ball.rawValue && contact.bodyA.categoryBitMask == BodyType.arrow.rawValue ) {
            if let arrow:Arrows = contact.bodyA.node as? Arrows {
                if let ball:Ball = contact.bodyB.node as? Ball {
                    arrow.Collided(ball: ball)
                }
            }
        }
    }
    
    
} 
