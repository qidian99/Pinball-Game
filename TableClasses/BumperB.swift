//
//  Bumper.swift
//  PinballTV
//
//  Created by Dian "Charles" Qi on 27/09/2019.
//  Copyright © 2019 Dian "Charles" Qi. All rights reserved.
//

import Foundation;
import SpriteKit;

class BumperB : Bumper
{
    //==============================================================
    // Initializers
    //==============================================================
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder);
    }
    
    //==============================================================
    // Internal Functions
    //==============================================================
    
    internal override func InitializePhysicsBody() 
    {
        self.physicsBody!.isDynamic = false;
        self.physicsBody!.affectedByGravity = false;
        self.physicsBody!.allowsRotation = false;
        
        self.physicsBody!.categoryBitMask = BodyType.bumper.rawValue;
        self.physicsBody!.collisionBitMask = BodyType.ball.rawValue;
        self.physicsBody!.contactTestBitMask = BodyType.ball.rawValue;
    }
    
    internal override func InitializeAnimationAction()
    {
        let semiActiveTexture = SKTexture(imageNamed: "Bumper B (Semi-Active)");
        let activeTexture = SKTexture(imageNamed: "Bumper B (Active)");
        
        let textureList = [activeTexture, semiActiveTexture];
        animationAction = SKAction.animate(with: textureList, timePerFrame: 0.05);
        
        // Sets the default texture.
        self.texture = semiActiveTexture;
    }
}
