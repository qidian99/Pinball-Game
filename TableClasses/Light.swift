//
//  Light.swift
//  PinballTV
//
//  Created by Dian "Charles" Qi on 27/09/2019.
//  Copyright © 2019 Dian "Charles" Qi. All rights reserved.
//

import Foundation;
import SpriteKit;

class Light : SKSpriteNode
{
    //==============================================================
    // Initializers
    //==============================================================
    
    init()
    {
        let texture = SKTexture(imageNamed: "Flipper");
        let color = SKColor.white;
        let size = CGSize(width: 1.0, height: 1.0);
        
        super.init(texture: texture, color: color, size: size);
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder);
    }
    
    public func setUp()
    {
        let randomNum = CGFloat(Float(arc4random()) / Float(UINT32_MAX)) * 20;
        let randomTime:TimeInterval = TimeInterval(randomNum);
        
        let inactiveTexture = SKTexture(imageNamed: "Light (Inactive)");
        let activeTexture = SKTexture(imageNamed: "Light (Active)");
        
        let textureList = [activeTexture, inactiveTexture];
        let animationAction = SKAction.animate(with: textureList, timePerFrame: randomTime);
        self.run(SKAction.repeatForever(animationAction));
        
        // Sets the default texture.
        self.texture = inactiveTexture;
    }
}
