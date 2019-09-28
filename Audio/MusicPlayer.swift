//
//  MusicPlayer.swift
//  PinballTV
//
//  Created by Dian "Charles" Qi on 27/09/2019.
//  Copyright © 2019 Dian "Charles" Qi. All rights reserved.
//

import Foundation;
import SpriteKit;

class MusicPlayer
{
    private var music: SKAudioNode;
    
    init(scene: SKScene, fileNamed: String)
    {
        music = SKAudioNode(fileNamed: fileNamed);
        music.autoplayLooped = true;
        
        scene.addChild(music);
    }
    
    public func Play()
    {
        //music.run(SKAction.play());
    }
}
